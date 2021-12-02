#lang racket

(provide standard-deck
         select-card
         calculate-score
         card
         card-value
         card->number)

;;; H,D,S,C represent Heart, Diamond, Spade, and Clubs respectively.
;;; K,Q,J,A represent King, Queen, Jack, and Ace respectively 
(struct card (value suit))

;;; standard 52 card deck
(define standard-deck
  (vector-immutable
   (card 2 "H") (card 2 "D") (card 2 "S") (card 2 "C")
   (card 3 "H") (card 3 "D") (card 3 "S") (card 3 "C")
   (card 4 "H") (card 4 "D") (card 4 "S") (card 4 "C")
   (card 5 "H") (card 5 "D") (card 5 "S") (card 5 "C")
   (card 6 "H") (card 6 "D") (card 6 "S") (card 6 "C")
   (card 7 "H") (card 7 "D") (card 7 "S") (card 7 "C")
   (card 8 "H") (card 8 "D") (card 8 "S") (card 8 "C")
   (card 9 "H") (card 9 "D") (card 9 "S") (card 9 "C")
   (card 10 "H") (card 10 "D") (card 10 "S") (card 10 "C")
   (card "A" "H") (card  "A" "D") (card "A" "S") (card "A" "C")
   (card "Q" "H") (card "Q" "D") (card "Q" "S") (card "Q" "C")
   (card "K" "H") (card "K" "D") (card "K" "S") (card "K" "C")
   (card "J" "H") (card "J" "D") (card "J" "S") (card "J" "C")))

;;; (card->number val) -> integer?
(define (card->number val)
  (if (null? val) 0
      (let ([val (card-value val)])
        (cond [(number? val)
               val]
              [(string? val)
               (if (equal? "A" val)
                   11
                   10)]
              [else 0]))))

;;; (nonnull? x) -> boolean?
(define (nonnull? x)
  (not (null? x)))

;;; (select-card cards) -> card?
(define (select-card cards)
  (let* ([card-list (filter nonnull?  (vector->list cards))]
         [pos (random (length card-list))]
         [chosen-one (list-ref card-list pos)])
    (vector-set! cards pos null)
    chosen-one))

;;; (calculate-score cards) -> integer?
;;;  cards : listof card?
;;; Adds the values of all cards in a list.
;;;  todo: handle aces being 11 or 1
(define (calculate-score cards)
  (letrec ([add-cards
            (lambda (cards)
              (if (null? cards) 0
                  (+ (card->number (car cards)) (add-cards (cdr cards)))))])
    (let ([score (add-cards cards)])
      (if (> score 21) -1 score))))
