
'Hangman v2.bas SmallBASIC 0.12.0 2015-11-20 MGA/B+ modified from:
'''HANGMAN.BAS by Eric Toft 
''
''Hang.dat file - just create a file called hang.dat
''Put one Phrase on each line.  You can use the program 
''to add more phrases, or use an external editor.

'update: if hangfile is not given will use the READ/DATA method to play an Australian list of words

'HangFile="A H L.txt"  '<============== what file are we to use for words List

window 0,200,200,0    '<============== helps fit any screen
cls
randomize ticks
if HangFile<>"" then
  tload Hangfile, fraze
  ct = ubound(fraze) 
  cts = fraze(ct) 
  if cts = "" then delete fraze, ct
else
  while test<>"END"
    read test
    append fraze,upper(test)
  wend
fi

while 1
  cls
  at 90, 30: ? "HANGMAN MENU:"
  at 50, 40: ? "1) 1 PLAYER GAME: Use a word file or program's default Austrailian list."
  at 50, 50: ? "2) 2 PLAYER GAME: One player enters a word, the other has to guess it."
  at 50, 60: ? "3) ADD A PHRASE: If a file is loaded."
  at 50, 70: ? "4) QUIT"
  at 85, 80: ? "click a line or press a menu number... "
  m=inkey
  if pen(3) then
    mline=int(pen(5)/10)
    delay 30
    if mline>3 and mline<8 then m=mline-3
  endif
  if m="1" then
    idx = INT(UBOUND(FRAZE) * RND)
    PHRASE$ = ucase(FRAZE(idx))
    savePhrase$=phrase$
    PLAYGAME PHRASE$
  elif m="2"
    at 70,100:INPUT "Enter a word or phrase :"; PHRASE$
    savephrase$=upper(phrase$)
    PLAYGAME UPPER(PHRASE$)
  elif m="3"
    if hangfile<>"" then
      at 70,100:INPUT "Enter a word or phrase to be filed :"; PHRASE$
      at 70, 130:PRINT "Enter ''p'' to play using the phrase..."
      at 70,140:Input "...Anything else to go to the menu.";ff
      FRAZE << UPPER(PHRASE$)
      tsave HangFile, FRAZE
      if "p" = ff or "P" = ff then
        savePhrase$=upper(phrase$) 
        PLAYGAME Upper(PHRASE$)
      fi
    else
      at 70,100: ? "Sorry, a file has not been loaded for play."
      showpage
      delay 1200
    fi
  elif m="4"
    end  '>==== only way out of here
  fi
  showpage
  delay 10
wend

FUNC COLLECTPEN
  local xx,yy,adder,ch,k$
  PEN ON
  LABEL PENME:
  IF PEN(0) THEN
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
    delay 50
    GOTO PENME
  FI
END

SUB PLAYGAME (PHRASE$)
  ''INIT VARS
  MISSES=0:GUESSES="":key = "":charcnt=0:outphrase =""
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

  at 100,175
  print outphrase
  showpage
  
  ''game loop
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
    
    at 100,175
    print outphrase+"       "
    check=instr(GUESSES, key)
    if check <= 0 then
      guesses += KEY
      misses++
      drawbody misses
    fi
    if charcnt=0 then 
      at 100, 190: ? "You win!!!"
      showpage
      Delay 700
      key= "0"
    fi
    showpage
    delay 10
  WEND
END SUB

sub drawbody(missed)
  'globals key, savePhrase$
  select case missed
  case 1:circle 80,55,5 'head
  case 2:line 80,60,80,85 'body
  case 3:line 80,65,60,60 'rarm
  case 4:line 80,65,100,60 'larm
  case 5:line 80,85,60,105 'rleg
  case 6:line 80,85,100,105 'lleg
  case 7 'hanged
    line 77,53,79,53
    line 81,53,83,53
    line 78,52,78,54
    line 82,52,82,54
    line 78,57,82,57
    at 90, 190: PRINT "Sorry, the phrase was: " + savePHRASE$
    showpage
    delay 2000
    key = "0"
  end select
end

data "THE BAROSSA VALLEY","THE ADELAIDE HILLS","MT REMARKABLE","MCLEODS DAUGHTERS","FREELING REDLEGS","HEY MATE"
data "Hugh Jackman", "Nicole Kidman","CROCODILE DUNDEE", "down under","koala bear","vegemite","Sydney Opera House"
data "Ayers Rock","Mt Augustus","Fraser Island","Great Barrier Reef","The Three Sisters","Chambers Pillar","Melbourne"
data "Great Victoria Desert","Great Sandy Desert","Great Dividing Range","Perth","Brisbane","Lake Eyre","The Twelve Apostles"
data "KANGAROO","THE GREAT OUTBACK","ULURU","BOOMERANG","Queensland","Waltzing Matilda","fair dinkum","aussie","END"
