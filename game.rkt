#lang racket

(require "deck.rkt")

(provide data
         initialize
         stand
         hit
         get-score
         execute-dealer
         game-done?
         get-winner
         get-flag
         get-dealer-hand
         get-hand)

(define data
  (vector 0          ; # of players
          0          ; player #'s turn
          (vector)   ; current deck
          (vector)   ; flags
          (vector))) ; hands

; import data
(define (load-data imported-data)
  (vector-set! data 0 (vector-ref imported-data 0))
  (vector-set! data 1 (vector-ref imported-data 1))
  (vector-set! data 2 (vector-ref imported-data 2))
  (vector-set! data 3 (vector-ref imported-data 3))
  (vector-set! data 4 (vector-ref imported-data 4)))

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

; get visible dealer cards (excludes first card in hand)
(define (get-dealer-hand)
  (let ([hand (vector-ref (get-hands) 0)])
    (if (null? hand) '() (cdr hand))))

; (get-score)
(define (get-score x)
  (calculate-score (get-hand x)))

; (deal-to x n)
; x = player #
; n = number of cards to deal
(define (deal-to x n)
  (let ([current-hand (get-hand x)])
    ;(vector-set! flags x 0) ; set play status (0 = playing)
    (set-hand x (append current-hand (build-list n (lambda (a) (select-card (get-deck))))))
    (if (< (calculate-score (get-hand x)) 0) (set-flag x 2) (set-flag x 0))))

; (initial-deal)
; deals two cards to all players and the dealer
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
  (if (zero? (get-flag 0))
      (if (< (get-score 0) 15)
          (hit 0)
          (stand 0))
      #f))

; (game-done?)
; checks if there are any players left in play
(define (game-done?)
  (letrec ([players-done?
            (lambda (x)
              (if (zero? x) (> (get-flag 0) 0)
                  (if (zero? (get-flag x)) #f
                      (players-done? (sub1 x)))))])
    (or (players-done? (get-player-num))
        (= (get-flag 0) 2)))) ; dealer busted

; (get-winner)
; returns player id for the winner
(define (get-winner)
  (let* ([player-hands (players-with-scores)]
         [max (lambda (x1 x2)
                (let ([a (cdr x1)]
                      [b (cdr x2)])
                  (cond [(> a b) x1]
                        [(= a b) (cons (cons (car x1) (car x2)) a)] ; combine player numbers for a tie
                        [else x2])))])
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
