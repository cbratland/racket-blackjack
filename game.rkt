#lang racket

(require "deck.rkt")

(provide data
         initialize
         stand
         hit
         get-score)

(define data
  (vector 0          ; # of players
          0          ; player #'s turn
          (vector)   ; current deck
          (vector)   ; flags
          (vector))) ; hands

; n = # of players
(define (initialize n)
  (vector-set! data 0 n)
  (vector-set! data 2 (vector-copy standard-deck))
  (vector-set! data 3 (make-vector (add1 n)))
  (vector-set! data 4 (make-vector (add1 n) '()))
  (initial-deal))

; # of players
(define (get-player-num)
  (vector-ref data 0))

; current player turn
(define (get-turn-num)
  (vector-ref data 1))
(define (set-turn-num x)
  (vector-set! data 1 x))

; card deck
(define (get-deck)
  (vector-ref data 2))

; player flags
(define (get-flags)
  (vector-ref data 3))
(define (get-flag x)
  (vector-ref (get-flags) x))
(define (set-flag pos x)
  (vector-set! (get-flags) pos x))

; player card lists
(define (get-hands)
  (vector-ref data 4))
(define (get-hand pos)
  (vector-ref (get-hands) pos))
(define (set-hands x)
  (vector-set! data 3 x))
(define (set-hand pos x)
  (vector-set! (get-hands) pos x))

; (get-score)
(define (get-score x)
  (calculate-score (get-hand x)))

; (deal-to x)
; x = player #
; n = number of cards to deal
(define (deal-to x n)
  (let ([current-hand (get-hand x)])
    ;(vector-set! flags x 0) ; set play status (0 = playing)
    (set-hand x (append current-hand (build-list n (lambda (a) (select-card (get-deck))))))
    (if (zero? (calculate-score (get-hand x))) (set-flag x 2) (set-flag x 0))))

; (deal n)
; n = number of players
; deals two cards to n players and the dealer
(define (initial-deal)
  (letrec ([deal (lambda (n)
                   (cond [(zero? n) (deal-to 0 2)]
                         [else (deal-to n 2) (deal (sub1 n))]))])
    (deal (get-player-num))))

; (hit x)
; x = player #
(define (hit x)
  (deal-to x 1)
  (calculate-score (get-hand x)))

; (stand x)
; x = player #
(define (stand x)
  (set-flag x 1))

; (execute-dealer)
; execute a move for dealer
(define (execute-dealer)
  (if (< (get-score 0) 15)
      (hit 0)
      (stand 0)))

; (game-done?)
; checks if there are any players left in play
(define (game-done?)
  (letrec ([players-done?
            (lambda (x)
              (if (zero? x) (> (get-flag 0) 0)
                  (if (zero? (get-flag x)) #f
                      (players-done? (sub1 x)))))])
    (players-done? 1))) ; fixme

; (get-winner)
; returns player id for the winner
(define (get-winner)
  (let* ([player-hands (players-with-scores)]
         [max (lambda (x1 x2) (if (> (cdr x1) (cdr x2)) x1 x2))])
    (if (null? player-hands) 0
        (car (foldl max (car player-hands) (cdr player-hands))))))

; (players-with-scores)
(define (players-with-scores)
  (let ([hand-list (get-hands)])
    (map (lambda (x y)
           (cons y (calculate-score x)))
         (vector->list hand-list)
         (range (add1 (get-player-num))))))

; (used-card-count)
; number of cards in play
(define (used-card-count)
  (length (filter null? (vector->list (get-deck)))))
