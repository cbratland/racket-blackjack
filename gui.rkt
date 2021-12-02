#lang racket

(require racket/gui/base
         (only-in mrlib/image-core render-image)
         "game.rkt")

(provide frame
         open-game
         open-title
         send-message
         set-score)

; game window
(define frame (new frame%
                   [label "Blackjack"]
                   [width 300]
                   [height 300]))

(define window-stack (new vertical-panel%
                          [parent frame]
                          [alignment (list 'center 'center)]))

; text field
; to get value: (send field get-text)
(define server-field (new text-field%
                          [parent window-stack]
                          [label "Server"]))

; system messages
(define sys-message (new message%
                         [parent window-stack]
                         [label ""]
                         [auto-resize #t]))

(define (send-message n)
  (send sys-message set-label n))

; score text
(define score (new message%
                   [parent window-stack]
                   [label "Current Score: 0"]
                   [auto-resize #t]))

(define (set-score x)
  (send score set-label (string-append "Current Score: " (number->string x))))

; card display canvas (todo)
(define gameplay (new canvas%
                      [parent window-stack]
                      [style (list 'transparent)]
                      [paint-callback
                       (lambda (canvas dc)
                         null
                         ; to render 2hdtp image: (render-image (circle 5 "solid" "red") dc 0 0)
                         )]))

; host/join buttons
(define host-join-btns (new horizontal-panel%
                            [parent window-stack]
                            [alignment (list 'center 'center)]))
(define host-btn (new button%
                      [parent host-join-btns]
                      [label "Host"]
                      [callback (lambda (button event) (open-game))]))
(define join-btn (new button%
                      [parent host-join-btns]
                      [label "Join"]
                      [enabled #f]
                      [callback (lambda (button event) null)]))

; hit/stand buttons
(define hit-stand-btns (new horizontal-panel%
                            [parent window-stack]
                            [alignment (list 'center 'center)]))
(define stand-btn (new button%
                       [parent hit-stand-btns]
                       [label "Stand"]
                       [callback (lambda (button event)
                                   (stand 1)
                                   (player-moved))]))
(define hit-btn (new button%
                     [parent hit-stand-btns]
                     [label "Hit"]
                     [callback (lambda (button event)
                                 (set-score (hit 1))
                                 (cond [(= (get-score 1) -1)
                                        (disable-input)
                                        (bust)]
                                       [else (player-moved)]))]))

; switch windows
(define (open-title)
  (send window-stack change-children (lambda (old) (list host-join-btns))))

(define (open-game)
  (send window-stack change-children (lambda (old) (list sys-message gameplay score hit-stand-btns))))

; enable input
(define (enable-input)
  (send stand-btn enable #t)
  (send hit-btn enable #t))

; disable input
(define (disable-input)
  (send stand-btn enable #f)
  (send hit-btn enable #f))

; player busts (game end for solo)
(define (bust)
  (send-message "Busted!")
  (disable-input))

; determine what happens after player moves
(define (player-moved)
  (disable-input)
  (execute-dealer)
  (if (game-done?) (send-message (string-append (if (= (get-winner) 1) "You won!" "You lost.") " Dealer had " (number->string (get-score 0))))
      (if (zero? (get-flag 1))
          (enable-input)
          (player-moved))))
