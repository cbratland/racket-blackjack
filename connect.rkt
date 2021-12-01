#lang racket
;first message from the user must send ip

(require racket/udp)
(require csc151)

(define words (vector->immutable-vector (list->vector (file->lines "wordlist.txt"))))

(define bind null)

(define scrabble 2026)

(define (crypt str)
  (string-join (map (section vector-ref words <>)
                    (map string->number
                         (string-split str ".")))))

(define (decrypt str)
  (string-join (map number->string (map (section vector-member <> words) (string-split str))) "."))

(define (binder linkmn)
  (let ([ip (decrypt linkmn)])
    (udp-bind! (udp-open-socket #f #f) ip scrabble)))

(define (get-ipv4-win)
  (let* ([ipstr (car (sequence->list (sequence-filter (o (section string-contains? <> "ipv4 address")
                                                         string-downcase)
                                                      (in-lines (car (process "ipconfig"))))))]
         [ips-fidx (sub1 (string-length ipstr))])
    (string-trim (substring ipstr
                            (- (string-length ipstr) 15)
                            (string-length ipstr)))))

(define get-ipv4
  (λ ()
    (when (equal? 'windows (system-type))
      (get-ipv4-win))))

(define (begin-host)
  (udp-open-socket))

(define (begin-user)
  (??))

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

;2026
;scrabble
