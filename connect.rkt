#lang racket
;first message from the user must send ip

(require racket/udp)
(require csc151)

(define apptype 'null)
(define myCrypt 'null)
(define hostSoc null)
(define quake 26000)
(define dmode #t)

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
  (let* ([ipstr (in-lines (car (process "ipconfig")))])
    (string-trim ipstr)))

(define get-ipv4
  (λ ()
    (match (system-type)
      ['windows (get-ipv4-win)]
      ['mac (get-ipv4-mac)]
      [_ (get-ipv4-linux)])))

(define (begin-host)
  (set! apptype 'host)
  (udp-open-socket)
  (set! myCrypt (crypt (get-ipv4))))

(define (begin-user host)
  (let ([hostIP (decrypt host)])
    (set! hostSoc (udp-open-socket))
    (udp-bind! hostSoc hostIP quake)))

#|
(define count 0)

(define s (udp-open-socket #f #f))
(udp-bind! s #f 12346)

(define buffer (make-bytes 1024))

(let loop ((start-time #f))
  (sync (udp-receive!-evt s buffer))
  (udp-send-to s "127.0.0.1" 12345 #"pong")
  (set! count (+ count 1))
  
  (let ([start-time (or start-time (current-inexact-milliseconds))])
    (when (zero? (modulo count 100))
      (display "\r")
      (let* ([now (current-inexact-milliseconds)]
	     [delta (- now start-time)]
	     [rate (if (zero? delta) 0 (/ count (/ delta 1000)))])
	(display (list 'count count
		       'runtime (/ (truncate delta) 1000)
		       'rate (truncate rate)
		       'stamp now))))
    
    (loop start-time)))
|#

;;evt prac
#| From TonyG's gist "Soak Testing Racket's UDP".
(sync (handle-evt (udp-receive!-evt s buffer)
		      (lambda (_)
			(set! last-recv-time (current-inexact-milliseconds))
			(set! received-count (+ received-count 1))
			(inner-loop)))
	  always-evt)|#
