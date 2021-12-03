#lang racket
(require 2htdp/image)


;Card Background
(define card-image
  (overlay (rectangle 139 168 'solid "white")
           (rectangle 140 170 'outline "black")))

;red diamond

(define red-diamond
  (above (triangle 20 'solid "red")
         (rotate 180 (triangle 20 'solid "red"))))

;red heart

(define heart1
  (overlay/offset (circle 10 'solid "red") 6 15 (rotate 180 (triangle 25 'solid "red"))))

(define heart
  (overlay/offset (circle 10 'solid "red") -9 8 heart1))

;black clover

(define clover
  (above (circle 7 'solid "black")
          (beside (circle 7 'solid "black")(circle 7 'solid "black"))
          (rectangle 7 12 'solid "black")))

;black club
(define club1
  (overlay/offset (circle 10 'solid "black") 6 15 (rotate 180 (triangle 25 'solid "black"))))

(define club2
  (overlay/offset (circle 10 'solid "black") -9 8 club1))

(define club
  (above (rotate 180 club2)
         (triangle 8 'solid "black")))

;----------------------
;   Smaller Symbols   |
;----------------------

;red diamond

(define small-diamond
  (above (triangle 15 'solid "red")
         (rotate 180 (triangle 15 'solid "red"))))

;red heart

(define sheart
  (overlay/offset (circle 8 'solid "red") 6 15 (rotate 180 (triangle 20 'solid "red"))))

(define small-heart
  (overlay/offset (circle 8 'solid "red") -9 8 sheart))

;black clover

(define small-clover
  (above (circle 5 'solid "black")
          (beside (circle 5 'solid "black")(circle 5 'solid "black"))
          (rectangle 5 10 'solid "black")))

;black club
(define sclub
  (overlay/offset (circle 5 'solid "black") 6 15 (rotate 180 (triangle 12 'solid "black"))))

(define sclub2
  (overlay/offset (circle 5 'solid "black") -9 8 sclub))

(define sclub3
  (overlay/offset (triangle 10 'solid "black") 0 3 sclub2))
       

(define small-club
  (above (rotate 180 sclub3)
         (triangle 8 'solid "black")))



;Jack Hat

(define jack-hat
  (above (beside (triangle 20 'solid "gold")(triangle 20 'solid "gold")(triangle 20 'solid "gold"))
         (rectangle 60  20 'solid "red")))

;King Crown

(define Crown-template
  (above (beside (triangle 20 'solid "gold")(triangle 20 'solid "gold")(triangle 20 'solid "gold"))
         (rectangle 60 20 'solid "gold")))

(define Crown-template1
  (overlay/offset (circle 5 'solid "red") 0 -8 Crown-template))

(define Crown-template2
  (overlay/offset (circle 5 'solid "red") 20 -8 Crown-template1))

(define Crown-template3
  (overlay/offset (circle 5 'solid "red") -20 -8 Crown-template2))

(define king-crown 
  (overlay/offset (circle 5 'solid "light blue") -0 20 Crown-template3))

;Queen Crown

(define Crown-template4
  (above (beside (triangle 20 'solid "gold")(triangle 20 'solid "gold")(triangle 20 'solid "gold"))
         (rectangle 60 20 'solid "gold")))

(define queen-crown
  (overlay/offset (circle 5 'solid "red") 0 -8 Crown-template4))





;---------------
;   Card One   |
;---------------

;Card one, black club

;four top left
(define card-one1
  (overlay/align 'left 'top (text "A" 30 "black") card-image))
;four bottom right
(define card-one2
  (overlay/align 'right 'bottom (text "A" 30 "black") card-one1))


;Center
(define one-club
  (overlay/offset club 0 0 card-one2))

;Card one, black clover

;Center
(define one-clover
  (overlay/offset clover 0 0 card-one2))

;Card one, red heart

;Center
(define one-heart
  (overlay/offset heart 0 0 card-one2))

;Card one, red diamond

;Center
(define one-diamond
  (overlay/offset red-diamond 0 0 card-one2))

(define Deck1
  (above one-club one-clover one-heart one-diamond))




;---------------
;   Card Two   |
;---------------

;Card two, black club

;four top left
(define card-two1
  (overlay/align 'left 'top (text "2" 30 "black") card-image))
;four bottom right
(define card-two2
  (overlay/align 'right 'bottom (text "2" 30 "black") card-two1))

;Center-left
(define card2-club1
  (overlay/offset club 25 0 card-two2))

;Center-right
(define two-club
  (overlay/offset club -25 0 card2-club1))

;Card two, black clover


;Center-left
(define card2-clover1
  (overlay/offset clover 25 0 card-two2))

;Center-right
(define two-clover
  (overlay/offset clover -25 0 card2-clover1))

;Card two, red heart


;Center-left
(define card2-heart1
  (overlay/offset heart 25 0 card-two2))

;Center-right
(define two-heart
  (overlay/offset heart -25 0 card2-heart1))

;Card two, red diamond


;Center-left
(define card2-diamond1
  (overlay/offset red-diamond 25 0 card-two2))

;Center-right
(define two-diamond
  (overlay/offset red-diamond -25 0 card2-diamond1))

(define Deck2
  (above two-club two-clover two-heart two-diamond))

;---------------
;  Card Three  |
;---------------

;Card four, black club

;four top left
(define card-three1
  (overlay/align 'left 'top (text "3" 30 "black") card-image))
;four bottom right
(define card-three2
  (overlay/align 'right 'bottom (text "3" 30 "black") card-three1))

;Center
(define card3-club1
  (overlay/offset club 0 0 card-three2))

;top center
(define card3-club2
  (overlay/offset club 0 50 card3-club1))

;bottom center
(define three-club
  (overlay/offset club 0 -50 card3-club2))

;Card Three, black heart

;Center
(define card3-heart1
  (overlay/offset heart 0 0 card-three2))

;top center
(define card3-heart2
  (overlay/offset heart 0 50 card3-heart1))

;bottom center
(define three-heart
  (overlay/offset heart 0 -50 card3-heart2))

;Card Three, black clover

;Center
(define card3-clover1
  (overlay/offset clover 0 0 card-three2))

;top center
(define card3-clover2
  (overlay/offset clover 0 50 card3-clover1))

;bottom center
(define three-clover
  (overlay/offset clover 0 -50 card3-clover2))

;Card Three, red-diamond

;Center
(define card3-diamond1
  (overlay/offset red-diamond 0 0 card-three2))

;top center
(define card3-diamond2
  (overlay/offset red-diamond 0 50 card3-diamond1))

;bottom center
(define three-diamond
  (overlay/offset red-diamond 0 -50 card3-diamond2))


(define Deck3
  (above three-club three-clover three-heart three-diamond))




;---------------
;   Card Four  |
;---------------

;Card four, black club

;four top left
(define card-four1
  (overlay/align 'left 'top (text "4" 30 "black") card-image))
;four bottom right
(define card-four2
  (overlay/align 'right 'bottom (text "4" 30 "black") card-four1))

;top right 
(define card4-club1
  (overlay/offset club -35 50 card-four2))
;top left 
(define card4-club2
  (overlay/offset club 35 50 card4-club1))
;bottom left
(define card4-club3
  (overlay/offset (rotate 180 club) 35 -50 card4-club2))
;bottom right
(define four-club
  (overlay/offset (rotate 180 club) -35 -50 card4-club3))

;Card four, black clover

;top right 
(define card4-clover1
  (overlay/offset clover -35 50 card-four2))
;top left 
(define card4-clover2
  (overlay/offset clover 35 50 card4-clover1))
;bottom left
(define card4-clover3
  (overlay/offset (rotate 180 clover) 35 -50 card4-clover2))
;bottom right
(define four-clover
  (overlay/offset (rotate 180 clover) -35 -50 card4-clover3))

;Card four, red heart

;top right 
(define card4-heart1
  (overlay/offset heart -35 50 card-four2))
;top left 
(define card4-heart2
  (overlay/offset heart 35 50 card4-heart1))
;bottom left
(define card4-heart3
  (overlay/offset (rotate 180 heart) 35 -50 card4-heart2))
;bottom right
(define four-heart
  (overlay/offset (rotate 180 heart) -35 -50 card4-heart3))

;Card four, red diamond

;top right 
(define card4-diamond1
  (overlay/offset red-diamond -35 50 card-four2))
;top left 
(define card4-diamond2
  (overlay/offset red-diamond 35 50 card4-diamond1))
;bottom left
(define card4-diamond3
  (overlay/offset (rotate 180 red-diamond) 35 -50 card4-diamond2))
;bottom right
(define four-diamond
  (overlay/offset (rotate 180 red-diamond) -35 -50 card4-diamond3))

(define Deck4
  (above four-club four-clover four-heart four-diamond))


;---------------
;Card Five     |
;---------------

;Card five, black club

;five top left
(define card-five1
  (overlay/align 'left 'top (text "5" 30 "black") card-image))
;five bottom right
(define card-five2
  (overlay/align 'right 'bottom (text "5" 30 "black") card-five1))

;top right 
(define card5-club1
  (overlay/offset club -35 50 card-five2))
;top left 
(define card5-club2
  (overlay/offset club 35 50 card5-club1))
;bottom left
(define card5-club3
  (overlay/offset (rotate 180 club) 35 -50 card5-club2))
;bottom right
(define card5-clubs4
  (overlay/offset (rotate 180 club) -35 -50 card5-club3))
;Center
(define five-club
  (overlay/offset club 0 0 card5-clubs4))

;Card five, black clover

;top right 
(define card5-clover1
  (overlay/offset clover -35 50 card-five2))
;top left 
(define card5-clover2
  (overlay/offset clover 35 50 card5-clover1))
;bottom left
(define card5-clover3
  (overlay/offset (rotate 180 clover) 35 -50 card5-clover2))
;bottom right
(define card5-clovers4
  (overlay/offset (rotate 180 clover) -35 -50 card5-clover3))
;Center
(define five-clover
  (overlay/offset clover 0 0 card5-clovers4))

;Card five, red heart

;top right 
(define card5-heart1
  (overlay/offset heart -35 50 card-five2))
;top left 
(define card5-heart2
  (overlay/offset heart 35 50 card5-heart1))
;bottom left
(define card5-heart3
  (overlay/offset (rotate 180 heart) 35 -50 card5-heart2))
;bottom right
(define card5-hearts4
  (overlay/offset (rotate 180 heart) -35 -50 card5-heart3))
;Center
(define five-heart
  (overlay/offset heart 0 0 card5-hearts4))

;Card five, red diamond

;top right 
(define card5-diamond1
  (overlay/offset red-diamond -35 50 card-five2))
;top left 
(define card5-diamond2
  (overlay/offset red-diamond 35 50 card5-diamond1))
;bottom left
(define card5-diamond3
  (overlay/offset (rotate 180 red-diamond) 35 -50 card5-diamond2))
;bottom right
(define card5-diamonds4
  (overlay/offset (rotate 180 red-diamond) -35 -50 card5-diamond3))
;Center
(define five-diamond
  (overlay/offset red-diamond 0 0 card5-diamonds4))
  
  
(define Deck5
  (above five-club five-clover five-heart five-diamond))  
           

;---------------
; Card Six     |
;---------------

(define card-six1
  (overlay/align 'left 'top (text "6" 30 "black") card-image))

(define card-six2
  (overlay/align 'right 'bottom (text "6" 30 "black") card-six1))

(define card6-diamond1
  (overlay/offset red-diamond 20 0 card-six2))

(define card6-diamond2
  (overlay/offset red-diamond -20 0 card6-diamond1))

(define card6-diamond3
  (overlay/offset red-diamond -20 50 card6-diamond2))

(define card6-diamond4
  (overlay/offset red-diamond 20 50 card6-diamond3))

(define card6-diamond5
  (overlay/offset red-diamond 20 -50 card6-diamond4))

(define six-diamond
  (overlay/offset red-diamond -20 -50 card6-diamond5))

;Card six, red heart

;six top left
(define card-six3
  (overlay/align 'left 'top (text "6" 30 "black") card-image))
;six bottom right
(define card-six4
  (overlay/align 'right 'bottom (text "6" 30 "black") card-six3))
;middle left
(define card6-heart1
  (overlay/offset heart 20 0 card-six4))
;middle right
(define card6-heart2
  (overlay/offset heart -20 0 card6-heart1))
;top right 
(define card6-heart3
  (overlay/offset heart -20 50 card6-heart2))
;top left 
(define card6-heart4
  (overlay/offset heart 20 50 card6-heart3))
;bottom left
(define card6-heart5
  (overlay/offset (rotate 180 heart) 20 -50 card6-heart4))
;bottom right
(define six-heart
  (overlay/offset (rotate 180 heart) -20 -50 card6-heart5))

;Card six, black clover
(define card-six5
  (overlay/align 'left 'top (text "6" 30 "black") card-image))

(define card-six6
  (overlay/align 'right 'bottom (text "6" 30 "black") card-six5))

(define card6-clover1
  (overlay/offset clover 20 0 card-six4))

(define card6-clover2
  (overlay/offset clover -20 0 card6-clover1))

(define card6-clover3
  (overlay/offset clover -20 50 card6-clover2))

(define card6-clover4
  (overlay/offset clover 20 50 card6-clover3))

(define card6-clover5
  (overlay/offset (rotate 180 clover) 20 -50 card6-clover4))

(define six-clover
  (overlay/offset (rotate 180 clover) -20 -50 card6-clover5))

;Card six, black club

;six top left
(define card-six7
  (overlay/align 'left 'top (text "6" 30 "black") card-image))
;six bottom right
(define card-six8
  (overlay/align 'right 'bottom (text "6" 30 "black") card-six7))
;middle left
(define card6-club1
  (overlay/offset club 20 0 card-six4))
;middle right
(define card6-club2
  (overlay/offset club -20 0 card6-club1))
;top right 
(define card6-club3
  (overlay/offset club -20 50 card6-club2))
;top left 
(define card6-club4
  (overlay/offset club 20 50 card6-club3))
;bottom left
(define card6-club5
  (overlay/offset (rotate 180 club) 20 -50 card6-club4))
;bottom right
(define six-club
  (overlay/offset (rotate 180 club) -20 -50 card6-club5))

                 
(define Deck6
  (above six-club six-clover six-heart six-diamond))



;---------------
;Card seven     |
;---------------

;Card seven, black club

;seven top left
(define card-seven1
  (overlay/align 'left 'top (text "7" 30 "black") card-image))
;seven bottom right
(define card-seven2
  (overlay/align 'right 'bottom (text "7" 30 "black") card-seven1))
;middle left
(define card7-club1
  (overlay/offset club 35 0 card-seven2))
;middle right
(define card7-club2
  (overlay/offset club -35 0 card7-club1))
;top right 
(define card7-club3
  (overlay/offset club -35 50 card7-club2))
;top left 
(define card7-club4
  (overlay/offset club 35 50 card7-club3))
;bottom left
(define card7-club5
  (overlay/offset (rotate 180 club) 35 -50 card7-club4))
;bottom right
(define card7-clubs6
  (overlay/offset (rotate 180 club) -35 -50 card7-club5))
;topish center
(define seven-club
  (overlay/offset club 0 25 card7-clubs6))

;Card seven, black clovers

;middle left
(define card7-clover1
  (overlay/offset clover 35 0 card-seven2))
;middle right
(define card7-clover2
  (overlay/offset clover -35 0 card7-clover1))
;top right 
(define card7-clover3
  (overlay/offset clover -35 50 card7-clover2))
;top left 
(define card7-clover4
  (overlay/offset clover 35 50 card7-clover3))
;bottom left
(define card7-clover5
  (overlay/offset (rotate 180 clover) 35 -50 card7-clover4))
;bottom right
(define card7-clovers6
  (overlay/offset (rotate 180 clover) -35 -50 card7-clover5))
;topish center
(define seven-clover
  (overlay/offset clover 0 25 card7-clovers6))

;Card seven, red diamonds

;middle left
(define card7-red-diamond1
  (overlay/offset red-diamond 35 0 card-seven2))
;middle right
(define card7-red-diamond2
  (overlay/offset red-diamond -35 0 card7-red-diamond1))
;top right 
(define card7-red-diamond3
  (overlay/offset red-diamond -35 50 card7-red-diamond2))
;top left 
(define card7-red-diamond4
  (overlay/offset red-diamond 35 50 card7-red-diamond3))
;bottom left
(define card7-red-diamond5
  (overlay/offset (rotate 180 red-diamond) 35 -50 card7-red-diamond4))
;bottom right
(define card7-red-diamonds6
  (overlay/offset (rotate 180 red-diamond) -35 -50 card7-red-diamond5))
;topish center
(define seven-diamond
  (overlay/offset red-diamond 0 25 card7-red-diamonds6))

;Card seven, red hearts

;middle left
(define card7-heart1
  (overlay/offset heart 35 0 card-seven2))
;middle right
(define card7-heart2
  (overlay/offset heart -35 0 card7-heart1))
;top right 
(define card7-heart3
  (overlay/offset heart -35 50 card7-heart2))
;top left 
(define card7-heart4
  (overlay/offset heart 35 50 card7-heart3))
;bottom left
(define card7-heart5
  (overlay/offset (rotate 180 heart) 35 -50 card7-heart4))
;bottom right
(define card7-hearts6
  (overlay/offset (rotate 180 heart) -35 -50 card7-heart5))
;topish center
(define seven-heart
  (overlay/offset heart 0 25 card7-hearts6))

(define Deck7
  (above seven-club seven-clover seven-heart seven-diamond))

;---------------
;Card Eight    |
;---------------

;Card eight, black club

;eight top left
(define card-eight1
  (overlay/align 'left 'top (text "8" 30 "black") card-image))
;eightbottom right
(define card-eight2
  (overlay/align 'right 'bottom (text "8" 30 "black") card-eight1))
;middle left
(define card8-club1
  (overlay/offset club 35 0 card-eight2))
;middle right
(define card8-club2
  (overlay/offset club -35 0 card8-club1))
;top right 
(define card8-club3
  (overlay/offset club -35 50 card8-club2))
;top left 
(define card8-club4
  (overlay/offset club 35 50 card8-club3))
;bottom left
(define card8-club5
  (overlay/offset (rotate 180 club) 35 -50 card8-club4))
;bottom right
(define card8-clubs6
  (overlay/offset (rotate 180 club) -35 -50 card8-club5))
;topish center
(define card8-clubs7
  (overlay/offset club 0 25 card8-clubs6))
;bottomish center
(define eight-club
  (overlay/offset (rotate 180 club) 0 -25 card8-clubs7))


;Card eight, black clover

;middle left
(define card8-clover1
  (overlay/offset clover 35 0 card-eight2))
;middle right
(define card8-clover2
  (overlay/offset clover -35 0 card8-clover1))
;top right 
(define card8-clover3
  (overlay/offset clover -35 50 card8-clover2))
;top left 
(define card8-clover4
  (overlay/offset clover 35 50 card8-clover3))
;bottom left
(define card8-clover5
  (overlay/offset (rotate 180 clover) 35 -50 card8-clover4))
;bottom right
(define card8-clovers6
  (overlay/offset (rotate 180 clover) -35 -50 card8-clover5))
;topish center
(define card8-clovers7
  (overlay/offset clover 0 25 card8-clovers6))
;bottomish center
(define eight-clover
  (overlay/offset (rotate 180 clover) 0 -25 card8-clovers7))

;Card eight, red diamonds

;middle left
(define card8-diamond1
  (overlay/offset red-diamond 35 0 card-eight2))
;middle right
(define card8-diamond2
  (overlay/offset red-diamond -35 0 card8-diamond1))
;top right 
(define card8-diamond3
  (overlay/offset red-diamond -35 50 card8-diamond2))
;top left 
(define card8-diamond4
  (overlay/offset red-diamond 35 50 card8-diamond3))
;bottom left
(define card8-diamond5
  (overlay/offset (rotate 180 red-diamond) 35 -50 card8-diamond4))
;bottom right
(define card8-diamonds6
  (overlay/offset (rotate 180 red-diamond) -35 -50 card8-diamond5))
;topish center
(define card8-diamonds7
  (overlay/offset red-diamond 0 25 card8-diamonds6))

;bottomish center
(define eight-diamond
  (overlay/offset (rotate 180 red-diamond) 0 -25 card8-diamonds7))


;Card eight, hearts

;middle left
(define card8-heart1
  (overlay/offset heart 35 0 card-eight2))
;middle right
(define card8-heart2
  (overlay/offset heart -35 0 card8-heart1))
;top right 
(define card8-heart3
  (overlay/offset heart -35 50 card8-heart2))
;top left 
(define card8-heart4
  (overlay/offset heart 35 50 card8-heart3))
;bottom left
(define card8-heart5
  (overlay/offset (rotate 180 heart) 35 -50 card8-heart4))
;bottom right
(define card8-hearts6
  (overlay/offset (rotate 180 heart) -35 -50 card8-heart5))
;topish center
(define card8-hearts7
  (overlay/offset heart 0 25 card8-hearts6))

;bottomish center
(define eight-heart
  (overlay/offset (rotate 180 heart) 0 -25 card8-hearts7))

(define Deck8
  (above eight-club eight-clover eight-heart eight-diamond))

;---------------
;Card Nine     |
;---------------

;Card nine, black club

;nine top left
(define card-nine1
  (overlay/align 'left 'top (text "9" 30 "black") card-image))
;nine bottom right
(define card-nine2
  (overlay/align 'right 'bottom (text "9" 30 "black") card-nine1))
;middle left
(define card9-club1
  (overlay/offset club 35 0 card-nine2))
;middle right
(define card9-club2
  (overlay/offset club -35 0 card9-club1))
;top right 
(define card9-club3
  (overlay/offset club -35 50 card9-club2))
;top left 
(define card9-club4
  (overlay/offset club 35 50 card9-club3))
;bottom left
(define card9-club5
  (overlay/offset (rotate 180 club) 35 -50 card9-club4))
;bottom right
(define card9-clubs6
  (overlay/offset (rotate 180 club) -35 -50 card9-club5))
;topish center
(define card9-clubs7
  (overlay/offset club 0 50 card9-clubs6))
;bottomish center
(define card9-clubs8
  (overlay/offset (rotate 180 club) 0 -50 card9-clubs7))
;Center
(define nine-club
  (overlay/offset club 0 0 card9-clubs8))


;Card nine, black clover

;middle left
(define card9-clover1
  (overlay/offset clover 35 0 card-nine2))
;middle right
(define card9-clover2
  (overlay/offset clover -35 0 card9-clover1))
;top right 
(define card9-clover3
  (overlay/offset clover -35 50 card9-clover2))
;top left 
(define card9-clover4
  (overlay/offset clover 35 50 card9-clover3))
;bottom left
(define card9-clover5
  (overlay/offset (rotate 180 clover) 35 -50 card9-clover4))
;bottom right
(define card9-clovers6
  (overlay/offset (rotate 180 clover) -35 -50 card9-clover5))
;topish center
(define card9-clovers7
  (overlay/offset clover 0 50 card9-clovers6))
;bottomish center
(define card9-clovers9
  (overlay/offset (rotate 180 clover) 0 -50 card9-clovers7))
;Center
(define nine-clover
  (overlay/offset clover 0 0 card9-clovers9))

;Card nine, red heart

;middle left
(define card9-heart1
  (overlay/offset heart 35 0 card-nine2))
;middle right
(define card9-heart2
  (overlay/offset heart -35 0 card9-heart1))
;top right 
(define card9-heart3
  (overlay/offset heart -35 50 card9-heart2))
;top left 
(define card9-heart4
  (overlay/offset heart 35 50 card9-heart3))
;bottom left
(define card9-heart5
  (overlay/offset (rotate 180 heart) 35 -50 card9-heart4))
;bottom right
(define card9-hearts6
  (overlay/offset (rotate 180 heart) -35 -50 card9-heart5))
;topish center
(define card9-hearts7
  (overlay/offset heart 0 50 card9-hearts6))
;bottomish center
(define card9-hearts9
  (overlay/offset (rotate 180 heart) 0 -50 card9-hearts7))
;Center
(define nine-heart
  (overlay/offset heart 0 0 card9-hearts9))

;Card nine, red diamond

;middle left
(define card9-diamond1
  (overlay/offset red-diamond 35 0 card-nine2))
;middle right
(define card9-diamond2
  (overlay/offset red-diamond -35 0 card9-diamond1))
;top right 
(define card9-diamond3
  (overlay/offset red-diamond -35 50 card9-diamond2))
;top left 
(define card9-diamond4
  (overlay/offset red-diamond 35 50 card9-diamond3))
;bottom left
(define card9-diamond5
  (overlay/offset (rotate 180 red-diamond) 35 -50 card9-diamond4))
;bottom right
(define card9-diamonds6
  (overlay/offset (rotate 180 red-diamond) -35 -50 card9-diamond5))
;topish center
(define card9-diamonds7
  (overlay/offset red-diamond 0 50 card9-diamonds6))
;bottomish center
(define card9-diamonds9
  (overlay/offset (rotate 180 red-diamond) 0 -50 card9-diamonds7))
;Center
(define nine-diamond
  (overlay/offset red-diamond 0 0 card9-diamonds9))

(define Deck9
  (above nine-club nine-clover nine-heart nine-diamond))

;---------------
;   Card Ten    |  
;---------------

;Card ten, black club

;ten top left
(define card-ten1
  (overlay/align 'left 'top (text "10" 25 "black") card-image))
;ten bottom right
(define card-ten2
  (overlay/align 'right 'bottom (text "10" 25 "black") card-ten1))
;middle left
(define card10-club1
  (overlay/offset club 50 0 card-ten2))
;middle right
(define card10-club2
  (overlay/offset club -50 0 card10-club1))
;top right 
(define card10-club3
  (overlay/offset club -35 50 card10-club2))
;top left 
(define card10-club4
  (overlay/offset club 35 50 card10-club3))
;bottom left
(define card10-club5
  (overlay/offset (rotate 180 club) 35 -50 card10-club4))
;bottom right
(define card10-clubs6
  (overlay/offset (rotate 180 club) -35 -50 card10-club5))
;topish center
(define card10-clubs7
  (overlay/offset club 0 50 card10-clubs6))
;bottomish center
(define card10-clubs8
  (overlay/offset (rotate 180 club) 0 -50 card10-clubs7))
;Center Left
(define card10-clubs9
  (overlay/offset club 17 0 card10-clubs8))
;Center right
(define ten-club
  (overlay/offset club -17 0 card10-clubs9))

;Card ten, black clovers

;middle left
(define card10-clover1
  (overlay/offset clover 50 0 card-ten2))
;middle right
(define card10-clover2
  (overlay/offset clover -50 0 card10-clover1))
;top right 
(define card10-clover3
  (overlay/offset clover -35 50 card10-clover2))
;top left 
(define card10-clover4
  (overlay/offset clover 35 50 card10-clover3))
;bottom left
(define card10-clover5
  (overlay/offset (rotate 180 clover) 35 -50 card10-clover4))
;bottom right
(define card10-clovers6
  (overlay/offset (rotate 180 clover) -35 -50 card10-clover5))
;topish center
(define card10-clovers7
  (overlay/offset clover 0 50 card10-clovers6))
;bottomish center
(define card10-clovers8
  (overlay/offset (rotate 180 clover) 0 -50 card10-clovers7))
;Center Left
(define card10-clovers9
  (overlay/offset clover 17 0 card10-clovers8))
;Center right
(define ten-clover
  (overlay/offset clover -17 0 card10-clovers9))

;Card ten, red hearts

;middle left
(define card10-heart1
  (overlay/offset heart 50 0 card-ten2))
;middle right
(define card10-heart2
  (overlay/offset heart -50 0 card10-heart1))
;top right 
(define card10-heart3
  (overlay/offset heart -35 50 card10-heart2))
;top left 
(define card10-heart4
  (overlay/offset heart 35 50 card10-heart3))
;bottom left
(define card10-heart5
  (overlay/offset (rotate 180 heart) 35 -50 card10-heart4))
;bottom right
(define card10-hearts6
  (overlay/offset (rotate 180 heart) -35 -50 card10-heart5))
;topish center
(define card10-hearts7
  (overlay/offset heart 0 50 card10-hearts6))
;bottomish center
(define card10-hearts8
  (overlay/offset (rotate 180 heart) 0 -50 card10-hearts7))
;Center Left
(define card10-hearts9
  (overlay/offset heart 17 0 card10-hearts8))
;Center right
(define ten-heart
  (overlay/offset heart -17 0 card10-hearts9))

;Card ten, red diamonds

;middle left
(define card10-diamond1
  (overlay/offset red-diamond 50 0 card-ten2))
;middle right
(define card10-diamond2
  (overlay/offset red-diamond -50 0 card10-diamond1))
;top right 
(define card10-diamond3
  (overlay/offset red-diamond -35 50 card10-diamond2))
;top left 
(define card10-diamond4
  (overlay/offset red-diamond 35 50 card10-diamond3))
;bottom left
(define card10-diamond5
  (overlay/offset (rotate 180 red-diamond) 35 -50 card10-diamond4))
;bottom right
(define card10-diamonds6
  (overlay/offset (rotate 180 red-diamond) -35 -50 card10-diamond5))
;topish center
(define card10-diamonds7
  (overlay/offset red-diamond 0 50 card10-diamonds6))
;bottomish center
(define card10-diamonds8
  (overlay/offset (rotate 180 red-diamond) 0 -50 card10-diamonds7))
;Center Left
(define card10-diamonds9
  (overlay/offset red-diamond 17 0 card10-diamonds8))
;Center right
(define ten-diamond
  (overlay/offset red-diamond -17 0 card10-diamonds9))

(define Deck10
  (above ten-club ten-clover ten-heart ten-diamond))

;---------------
;   Card Jack   |  
;---------------

;top left jack
(define jack-card1
  (overlay/align 'left 'top (text "J" 25 "black") card-image))
;ten bottom right
(define jack-card2
  (overlay/align 'right 'bottom (text "J" 25 "black") jack-card1))
;Jack icon
(define jack-card
  (overlay/offset jack-hat 0 0 jack-card2))

;Jack Club

;top club
(define top-club
  (overlay/offset small-club 55 45 jack-card))
;bottom club
(define jack-club
  (overlay/offset (rotate 180 small-club) -55 -45 top-club))

;Jack clovers

;top clover
(define top-clover
  (overlay/offset small-clover 55 45 jack-card))
;bottom clover
(define jack-clover
  (overlay/offset (rotate 180 small-clover) -55 -45 top-clover))

;Jack hearts

;top heart
(define top-heart
  (overlay/offset small-heart 55 45 jack-card))
;bottom clover
(define jack-heart
  (overlay/offset (rotate 180 small-heart) -55 -45 top-heart))

;Jack diamond

;top clover
(define top-diamond
  (overlay/offset small-diamond 55 45 jack-card))
;bottom clover
(define jack-diamond
  (overlay/offset (rotate 180 small-diamond) -55 -45 top-diamond))

(define Deck11
  (above jack-club jack-clover jack-heart jack-diamond))


;---------------
;   Card Queen  |  
;---------------

;top left queen
(define queen-card1
  (overlay/align 'left 'top (text "Q" 25 "black") card-image))

;Bottom right Queen
(define queen-card2
  (overlay/align 'right 'bottom (text "Q" 25 "black") queen-card1))

;Queen icon
(define queen-card
  (overlay/offset queen-crown 0 0 queen-card2))

;Queen Club

;top club
(define top-club1
  (overlay/offset small-club 55 45 queen-card))
;bottom club
(define queen-club
  (overlay/offset (rotate 180 small-club) -55 -45 top-club1))

;Queen clovers

;top clover
(define top-clover1
  (overlay/offset small-clover 55 45 queen-card))
;bottom clover
(define queen-clover
  (overlay/offset (rotate 180 small-clover) -55 -45 top-clover1))

;Queen hearts

;top heart
(define top-heart1
  (overlay/offset small-heart 55 45 queen-card))
;bottom clover
(define queen-heart
  (overlay/offset (rotate 180 small-heart) -55 -45 top-heart1))

;Queen diamond

;top clover
(define top-diamond1
  (overlay/offset small-diamond 55 45 queen-card))
;bottom clover
(define queen-diamond
  (overlay/offset (rotate 180 small-diamond) -55 -45 top-diamond1))

(define Deck12
  (above queen-club queen-clover queen-heart queen-diamond))

;---------------
;   Card king   |  
;---------------

;top left king
(define king-card1
  (overlay/align 'left 'top (text "K" 25 "black") card-image))
;ten bottom right
(define king-card2
  (overlay/align 'right 'bottom (text "K" 25 "black") king-card1))
;king icon
(define king-card
  (overlay/offset king-crown 0 0 king-card2))

;king Club

;top club
(define top-club2
  (overlay/offset small-club 55 45 king-card))
;bottom club
(define king-club
  (overlay/offset (rotate 180 small-club) -55 -45 top-club2))

;king clovers

;top clover
(define top-clover2
  (overlay/offset small-clover 55 45 king-card))
;bottom clover
(define king-clover
  (overlay/offset (rotate 180 small-clover) -55 -45 top-clover2))

;king hearts

;top heart
(define top-heart2
  (overlay/offset small-heart 55 45 king-card))
;bottom clover
(define king-heart
  (overlay/offset (rotate 180 small-heart) -55 -45 top-heart2))

;king diamond

;top clover
(define top-diamond2
  (overlay/offset small-diamond 55 45 king-card))
;bottom clover
(define king-diamond
  (overlay/offset (rotate 180 small-diamond) -55 -45 top-diamond2))

(define Deck13
  (above king-club king-clover king-heart king-diamond))

;---------------
;   Back Card   |  
;---------------

(define back-card
  (overlay/offset (text "BlackJack" 20 "black") 0 0 card-image))



(define Whole-Deck
  (beside Deck1 Deck2 Deck3 Deck4 Deck5 Deck6 Deck7 Deck8 Deck9 Deck10 Deck11 Deck12 Deck13 back-card))

