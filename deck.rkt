#lang racket

(require csc151)
(require rackunit)
(require racket/undefined)

;;; Procedure:
;;;   random-vector-elt
;;; Parameters:
;;;   vec, a non-empty vector
;;; Purpose:
;;;   Unpredictably pick an element of vec.
;;; Produces:
;;;   val, a value
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   * val is an element of vec.
;;;   * If vec contains more than one element, it is difficult to predict 
;;;     which element val is.
(define random-vector-elt
  (lambda (vec)
    (vector-ref vec (random (vector-length vec)))))


(struct card (value suit))
;;;cards
;;;a list of all the cards in a deck:
;;;H,D,S,C represent Heart, Spade, Club, Diamond respectively.
;;; K,Q,J,A represent King ,Queen, Jack and Ace respectively 
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




 
(define card-value->number
  (lambda(val)
  (cond [(number? val)
              val]
        [(string? val)
          (if (equal? "A" val)
              11
            10)]
          [else 0])))

(define select-card
  (lambda (cards)
    (let* ([pos (random (vector-length cards))]
           [chosen-one (vector-ref cards pos)])
    (vector-set! cards pos null)
      chosen-one)))
(define deck
  (vector-copy standard-deck))
(select-card deck)

