#lang racket

(require racket/gui/base
         (only-in mrlib/image-core render-image)
         "game.rkt"
         "deck.rkt")

(provide frame
         open-game
         open-title
         send-message
         set-score
         set-dealer-score
         start-game
         start-blackjack)

; game window
(define frame (new frame%
                   [label "Blackjack"]
                   [width 350]
                   [height 0]))

(define window-stack (new vertical-panel%
                          [parent frame]
                          [alignment (list 'center 'center)]))

; general messages
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

; dealer-score text (temporary)
(define dealer-score (new message%
                          [parent window-stack]
                          [label "Dealer's Hand: ?"]
                          [auto-resize #t]))

(define (set-dealer-score x)
  (send dealer-score set-label (string-append "Dealer's Hand: ? " (string-join (map (lambda (n)
                                                                                      (let ([val (card-value n)])
                                                                                        (if (number? val) (number->string val) val))) x)
                                                                               " "))))

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

(define play-again-btn (new button%
                            [parent window-stack]
                            [label "Play Again"]
                            [callback (lambda (button event) (start-game))]))

; title screen buttons
(define solo-btn (new button%
                      [parent window-stack]
                      [label "Singleplayer"]
                      [callback (lambda (button event) (start-game))]))
(define host-btn (new button%
                      [parent window-stack]
                      [label "Host"]
                      [callback (lambda (button event) (open-host))]))
(define join-btn (new button%
                      [parent window-stack]
                      [label "Join"]
                      ;[enabled #f]
                      [callback (lambda (button event) (open-join))]))

; host screen
(define start-btn (new button%
                       [parent window-stack]
                       [label "Start"]
                       [callback (lambda (button event) (start-game))]))

; join screen
; to get text field value: (send field get-text)
(define server-field (new text-field%
                          [parent window-stack]
                          [label "Server"]))
(define join-btn2 (new button%
                       [parent window-stack]
                       [label "Join"]
                       [callback (lambda (button event) (start-game))]))

(define cancel-btn (new button%
                        [parent window-stack]
                        [label "Cancel"]
                        [callback (lambda (button event) (open-title))]))

; switch windows
(define (open-title)
  (send-message "Blackjack")
  (send window-stack change-children (lambda (old) (list sys-message solo-btn host-btn join-btn))))

(define (open-host)
  (send-message "Waiting for players")
  (send window-stack change-children (lambda (old) (list sys-message start-btn cancel-btn))))

(define (open-join)
  (send window-stack change-children (lambda (old) (list server-field join-btn2 cancel-btn))))

(define (open-game)
  (send window-stack change-children (lambda (old) (list sys-message gameplay score dealer-score hit-stand-btns))))

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
  (disable-input)
  (end-game))

; determine what happens after player moves
(define (player-moved)
  (disable-input)
  (execute-dealer)
  (set-dealer-score (get-dealer-hand))
  (if (game-done?) (end-game)
      (if (zero? (get-flag 1))
          (enable-input)
          (player-moved))))

; end game
(define (end-game)
  (let ([winner (get-winner)])
    (send-message (string-append (cond [(number? winner) (if (= winner 1) "You won!"
                                                             (if (< (get-score 1) 0) "Busted!"
                                                                 "You lost."))]
                                       [(member 1 winner) "You tied!"]
                                       [else "You lost."])
                                 " Dealer had "
                                 (number->string (get-score 0))))
    (send window-stack change-children (lambda (old) (append old (list play-again-btn))))))

; show window
(define (start-blackjack)
  (send frame show #t)
  (open-title))

; temporary game start (solo)
(define (start-game)
  (open-game)
  (initialize 1)
  (send-message "It's your turn")
  (enable-input)
  (set-score (get-score 1))
  (set-dealer-score (get-dealer-hand)))
