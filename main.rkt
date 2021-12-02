#lang racket

(require "game.rkt")
(require "gui.rkt")

; temporary game start (solo)
(send frame show #t)
(open-game)
(initialize 1)
(send-message "It's your turn")
(set-score (get-score 1))
