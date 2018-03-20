   10 REM written in SmallBasic 
   20 REM runs in QB64 and numbered and runs in BB4W, finally runs in SW BASIC
   30 REM ===================== title and instructions
   40 PRINT "                      Where Is Kitty ?                    2015-02-25 B+"
   50 PRINT " 10 rooms (numbered 0 to 9) kitty walks +/- 1 between guesses."
   60 PRINT " Usually (80% of time) kitty starts walking in one direction, keeps going"
   70 PRINT " in that direction into next room. The dog, that is with you looking for"
   80 PRINT " kitty, will tell how many moves ago kitty was in the room with barks,"
   90 PRINT " up to 4 Woofs = 4 moves ago, a (dog sighs) means no kitty scent."
  100 DIM last4moves(4)
  110 GOTO 260
  120 REM ============================ SUB move kitty
  130 FOR j = 2 TO 0 STEP -1
  140   last4moves(j + 1) = last4moves(j)
  150 NEXT j
  160 last4moves(0) = room
  170 IF (RND) < .8 THEN GOTO 190
  180 direction = -1 * direction
  190 room = room + direction
  200 IF room < 10 THEN GOTO 220
  210 room = 0
  220 IF room > -1 THEN GOTO 240
  230 room = 9
  240 RETURN
  250 REM ============================= initialize
  260 IF (RND) > .5 THEN GOTO 290
  270 direction = 1
  280 GOTO 300
  290 direction = -1
  300 room = INT(10 * (RND))
  310 REM move kitty to fill out last4moves arr
  320 FOR i = 1 TO 4
  330   GOSUB 120
  340 NEXT i
  350 REM ================================================game
  360 PRINT
  370 INPUT "Guess the room number 0 to 9, kitty is in (any other quits) enter:",guess
  380 IF guess < 0 OR guess > 9 THEN GOTO 540
  390 IF guess = room THEN GOTO 530
  400 FOR k = 0 TO 3
  410   IF guess <> last4moves(k) THEN GOTO 470
  420   FOR l = 1 TO k + 1
  430     PRINT " Woof";
  440   NEXT l
  450   PRINT
  460   GOTO 500
  470 NEXT k
  480 PRINT "(dog sighs)"
  490 REM prep next round
  500 GOSUB 120
  510 GOTO 360
  520 REM Kitty found or not say goodbye
  530 PRINT "Ah, there's kitty!"
  540 PRINT " Goodbye."
  550 INPUT "            Press Enter ";temp$
  560 END