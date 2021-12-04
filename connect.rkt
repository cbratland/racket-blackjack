
#lang racket
;first message from the user must send ip

(require racket/udp)
(require csc151)
(require pkg)
(require pkg/lib)

(define apptype 'null)
(define myCrypt 'null)
(define dmode #t)

(define (randPort)
  (when (zero? portID)
    (set! portID (random 49152 65536))))

(define display?
  (λ (x)
    (when dmode
      (display x))))

(define words (vector->immutable-vector (list->vector (file->lines "wordlist.txt"))))

(define bind null)

(define (crypt str)
  (string-join (map (section vector-ref words <>)
                    (map string->number
                         (string-split str ".")))))

(define (decrypt str)
  (string-join (map number->string (map (section vector-member <> words) (string-split str))) "."))

(define (get-ipv4-win)
  (let* ([ipstr (car (sequence->list (sequence-filter (o (section string-contains? <> "ipv4 address")
                                                         string-downcase)
                                                      (in-lines (car (process "ipconfig"))))))]
         [ips-fidx (sub1 (string-length ipstr))])
    (string-trim (substring ipstr
                            (- (string-length ipstr) 15)
                            (sub1 (string-length ipstr))))))
         
(define (get-ipv4-mac)
  (string-trim (car (string-split (cadr (string-split (car (sequence->list (in-lines (car (process (string-append "ifconfig | grep \"inet \"| grep -v 127.0.0.1"))))))
                                                      "inet"))
                                  "netmask"))))

(define (get-ipv4-linux)
  (let* ([ipstr (car (sequence->list (in-lines (car (process "hostname -I")))))])
    (string-trim ipstr)))

(define get-ipv4
  (λ ()
    (match (system-type)
      ['windows (get-ipv4-win)]
      ['mac (get-ipv4-mac)]
      [_ (get-ipv4-linux)])))






(define soc (udp-open-socket #f #f))
(define first-recieve null)
(define buffer (make-bytes 32))
(define join-buffer (make-bytes 16))
(define inputs null)
(define host "")
(define joinPort 65535)
(define portID 0)

; (recieve-thread) -> <void?>
;  Loops over the recieve function
(define recieve-thread
  (thread (lambda () (let loop ()
                       (when (udp-bound? soc)
                         (lambda ()
                           (sync (udp-receive!-evt soc buffer))
                           (set! inputs (append inputs (list (bytes->string/utf-8 buffer))))
                           (set! buffer (make-bytes 16))))
                       (loop)))))

; (recieve-thread) -> <void?>
;  Loops over the recieve function
(define join-thread
  (thread
   (lambda ()
     (let loop ()
       (if (zero? portID)
             (lambda ()
               (when (udp? first-recieve)
                 (when (udp-bound? first-recieve)
                   (sync (udp-receive!-evt first-recieve join-buffer))
                   (displayln "recieved")))
               (let ([inputstring (bytes->string/utf-8 join-buffer)])
                 (if (string-contains? "joinBlackjack" inputstring)
                     (lambda ()
                       (set! portID (string->number (cadr (string-split inputstring "Port")))))
                     null)))
             
             (kill-thread join-thread))
       (loop)))))

; (stop-recieve) -> <void?>
;  Kills the recieve-thread thread
(define stop-recieve
  (λ ()
    (kill-thread recieve-thread)))

; (user-begin frhost) -> <void?>
;   frhost : string?
;  begins connection with host from the user side
(define user-begin 
  (lambda (frhost)
    (udp-bind! soc #f 0)
    (let-values ([(a* b c* d*) (udp-addresses soc true)])
      (set! portID b))
    (set! host (decrypt frhost))
    (user-send joinPort (string->bytes/utf-8 (string-append "joinBlackjackPort" (number->string joinPort))))))

; (user-sender [prt] data) -> <void?>
;   prt : number
;   data : bytes?
;  sends data to the reciever port of the host, if prt is provided, send to prt port number instead of portID 
(define user-send
  (case-lambda
    [(data) (udp-send-to soc host portID data)]
    [(prt data) (udp-send-to soc host prt data)]))

(define exit
  (λ ()
    (stop-recieve)
    (udp-close soc)))

; (server-begin) -> <void?>
;  begins connection lobby
(define server-begin
  (lambda ()
    (set! host (get-ipv4))
    (set! first-recieve (udp-open-socket))
    (udp-bind! first-recieve #f joinPort)))
