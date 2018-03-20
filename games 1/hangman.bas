
'''HANGMAN.BAS by Eric Toft 
''
''Hang.dat file - just create a file called hang.dat
''Put one Phrase on each line.  You can use the program 
''to add more phrases, or use an external editor.
''
''THE BAROSSA VALLEY
''THE ADELAIDE HILLS
''MT REMARKABLE
''MCLEODS DAUGHTERS
''FREELING REDLEGS

LABEL START:
CLS
RANDOMIZE TICKS
tload "HANG.DAT", FRAZE

ct = ubound(FRAZE) 
cts = FRAZE(ct) 
if cts = "" THEN 
  delete FRAZE, CT
FI

at 70, 50: PRINT "1) 1 PLAYER GAME"
at 70, 60: PRINT "2) 2 PLAYER GAME"
at 70, 70: PRINT "3) ADD A PHRASE"
at 70, 80: PRINT "4) QUIT"

LABEL redo:
KEYIN$ = COLLECTKEY
IF KEYIN$ < 1 THEN GOTO redo
IF KEYIN$ > 4 THEN GOTO redo
IF KEYIN$ = "4" THEN GOTO ENDIT
ON KEYIN$ GOSUB aPLAY, bPLAY, PHRASEIT
GOTO START

FUNC COLLECTKEY
  LABEL KEYME:
  K$ = INKEY
  IF LEN(K$) > 0 THEN
    COLLECTKEY = K$
  ELSE
    delay 500
    GOTO KEYME
  FI
END
''COLLECTKEY

LABEL aPLAY:
  ''first-randomly pick a phrase
  idx = CINT(UBOUND(FRAZE) * RND)
  PHRASE$ = FRAZE(idx)
  PLAYGAME PHRASE$
  PRINT "Pause: return to continue                    "
  COLLECTKEY
RETURN

LABEL bPLAY:
  ''first-a player enters a PHRASE
  INPUT "Enter a word or phrase :"; PHRASE$
  PLAYGAME UPPER(PHRASE$)

  PRINT "Pause: return to continue                   "
  COLLECTKEY
RETURN

LABEL PHRASEIT:
  ''first-a player enters a PHRASE
  INPUT "Enter a word or phrase to be filed :"; PHRASE$

  PRINT "Enter ''p'' to play using the phrase..."
  ? "...Anything else to go to the menu."
  ff = COLLECTKEY
  FRAZE << UPPER(PHRASE$)
  tsave "HANG.DAT", FRAZE
  if "p" = ff or "P" = ff then 
    PLAYGAME PHRASE$
    PRINT "Pause: return to continue                   "
    COLLECTKEY
  fi
RETURN

FUNC COLLECTPEN
  PEN ON
  LABEL PENME:
  IF PEN(0) THEN
  z = 0
    xx = PEN(1)
    IF PEN(2) < 30 THEN
      IF PEN(2) < 15 THEN
        adder = 0
        yy = 9
      ELSE
        adder = 13
        yy = 19
      FI
      ch = 65 + (adder + CINT(xx / 15))
      line cint(xx/15)*15,yy,(cint(xx/15)*15)+10,yy
      K$=string(1,ch)
    FI
    PEN OFF
    COLLECTPEN = K$
  ELSE
    delay 500
    GOTO PENME
  FI
END

LABEL youwin:
  at 10, 165: PRINT "YouWin!!!"
  key= "0"
RETURN

SUB PLAYGAME (PHRASE$)
  ''INIT VARS
  MISSES=0
  GUESSES=""
  key = ""
  charcnt=0
  outphrase =""
  CLS

  ''draw gallows
  line 80,35,80,50
  line 80,35,110,35
  line 110,35,110,150
  line 110,150,95,155
  line 110,150,125,155

  ''draw ABC''s
  for x = 65 to 77
    at ((x-65)*15)+5, 5
    ?chr$(x)
  next
  for x = 78 to 90
    at ((x-65-13)*15)+5, 15:
    ?chr$(x)
  next

  ''draw phrase as dashes and spaces
  for tt=1 to len(PHRASE$)
    if mid(PHRASE$,tt,1)=" " then
      outphrase += " "
    else
      outphrase += "*"
      charcnt++
    fi
  next

  at 0,175
  print outphrase

  ''start game loop
  while key <> "0"
    ''collect input
    key = COLLECTPEN

    check=instr(PHRASE$, key)
    while check > 0 then
      charcnt = charcnt - 1
      checkg=instr(GUESSES, key)
      if checkg <= 0 then
        GUESSES += KEY
      fi
      PHRASE$ = replace(PHRASE$, check, "*", 1)
      outphrase = replace(outphrase, check, key, 1)
      check=instr (PHRASE$, key)
    wend

    at 0,175
    print outphrase+"       "

    check=instr (GUESSES, key)
    if check <= 0 then
      guesses += KEY
      misses++
      on misses gosub head,body,rarm,larm,rleg,lleg,hang
    fi
    if charcnt =0 then gosub youwin
  WEND
END SUB


LABEL head:
  circle 80,55,5
RETURN

LABEL body:
  line 80,60,80,85
RETURN

LABEL rarm:
  line 80,65,60,60
RETURN

LABEL larm:
  line 80,65,100,60
RETURN

LABEL rleg:
  line 80,85,60,105
RETURN

LABEL lleg:
  line 80,85,100,105
RETURN

LABEL hang:
  line 77,53,79,53
  line 81,53,83,53
  line 78,52,78,54
  line 82,52,82,54
  line 78,57,82,57
  at 10, 165: PRINT "The phrase is: " + PHRASE$
  PENIN = "0"
RETURN

LABEL ENDIT:




'
