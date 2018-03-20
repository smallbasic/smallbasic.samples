
'Button MM Game.bas SmallBASIC 0.12.6 [B+=MGA] 2016-06-14
'overhaul The Memory Match Game:
'More BASIC keywords to select randomly from into 1 game array
'Use buttons instead on inputs with prompts for GUI game

randomize
'one time only read BASIC keywords from DATA
dim B() ' Basic keywords array 
while element != "end" 
  read element
  B << element
wend
nB = len(B)
topB = nB - 1

nMatch = 10 'number of items to use for Memory Match game up to 20 ?

'restart game here and ask for nMatch to make a higher level of difficulty

const buttonWide = (xmax - 50)/4 '4 columns of buttons with 10 * 5 space between

label restart
nButtons = nMatch * 2
' note: q or esc is available while waiting for click
cls

'shuffle or reshuffle the B array
for i = topB to 1 step -1 'shuffle algorithm
  rB = (rnd * (i + 1))\1 'range 0 to i
  swap B(i), B(rB)
next

dim game(1 to nButtons)
for i = 1 to nMatch
  game(i) = B(i)
  game(nMatch + i) = B(i)
next

'OK the game array is loaded with Basic keywords and a matching one
'Next shuffle that
for i = nButtons to 2 step -1
   rB = (rnd * i)\1 + 1 'range 1 to i
  swap game(i), game(rB)
next 
'debug check that our array is OK, oh extra comma at end of DATA line
'for i = 1 to nButtons
'  ? game(i)
'next
'pause

'display buttons with out text
for i = 1 to nButtons
  drwbtn buttonX(i), buttonY(i), ""
next

messageY = buttonY(nButtons+3) + 70 + 4  'talk to user on this line
color 11, 0
at 0, messageY 
? "Memory Match Game: click a button and then another to match, OK ? repeat... (q or esc quits)"
'the goal is to select Button1 and find matching Button2
Button1 = 0 : Button2 = 0 : gameover = 0 : matches = 0
dim matchCheck(1 to nButtons) 'this tracks buttons matched already
pen on 

while gameover = 0
  k=inkey  'allow exit/quit
  if k = "q" or (len(k) = 1 and asc(k)=27) then end
  
  if pen(3) then 'mouse clicked get mouse x,y
    mx = pen(4) : my = pen(5)
    
    bn = buttonNumber(mx, my)
    if bn > 0 and bn <= nButtons then 'need this check first! 
    'to make sure button is in range of matchCheck
    if matchCheck(bn) = 0 then 'button not matched yet
      if Button1 = 0 then
        Button1 = bn
        drwbtn buttonX(bn), buttonY(bn), game(bn)
      elif bn != Button1 and Button2 = 0
        Button2 = bn
        drwbtn buttonX(bn), buttonY(bn), game(bn)
        
        'VVVVV  when this was added buttons started flipping on magically
        OKwait ' much better !!!  with delay added in sub
        
        if game(Button1) <> game(Button2) then 'clear buttons
          drwbtn buttonX(Button1), buttonY(Button1), ""
          drwbtn buttonX(Button2), buttonY(Button2), ""
        else
          'add to matched count and check off matched buttons
          'if matched count = nMatch then gameover exit
          matchCheck(Button1) = 1 : matchCheck(Button2) = 1
          matches +=1
          if matches = nMatch then gameOver = 1
        fi 
        Button1 = 0 : Button2 = 0 
      fi 'button1 ?
    fi 'matched yet ?
    fi 'number in button range should be OK after OKwait if bn set to 0
  fi 'pen 3 ?
wend

color 11,0
th=txth("Q")
at 0, messageY + th + 4: ? "Congratulations, all matched, ...another round coming up."
at 0, messageY + 2*(th+4)
input "You may enter a new amount of items to match from 2 to 16 > ";new
if new >=2 and new <=16 then nMatch = int(new)
goto restart

data "print", "at", "input", "while...wend", "exit", "cls", "rnd", "mod", "for...next"
data "if...then", "dim", "elif", "else", "repeat...until", "sort", "split", "goto"
data "gosub", "label", "pen or pen()", "inkey", "mid", "instr", "sub", "func" 
data "and", "or", "<> or !=", ">= or <=", "> or <", "end"

func buttonY(bNumber)
  ' each button is 50 high plus 10 spacer
  buttonY = int((bNumber - 1)/4) * 60 + 10
end

func buttonX(bNumber)
  'buttonWide is const from main depends on xmax
  buttonX = ((bNumber - 1) mod 4) * (buttonWide + 10) + 10
end

func buttonNumber(mouseX, MouseY)
  'nButtons is global from main
  local i, bx, by
  for i = 1 to nButtons
    bx = buttonX(i) : by = buttonY(i)
    if mouseX >= bx and mouseX <= (bx + buttonWide) then
      if mouseY >= by and mouseY <= by + 50 then
        buttonNumber = i : exit func
      fi
    fi
  next
  buttonNumber = 0 'still here?  then no button found
end 
 
sub drwbtn(x,y,s)
  'buttonWide is const set in main program according to xmax
  local gray, xoff, yoff, ths, tws
  ths = txth(s) : tws = txtw(s) : gray = rgb(190, 190, 190)
  rect x, y step buttonWide, 50, 0 filled
  rect x, y step buttonWide - 3, 47, 15
  rect x + 1, y + 1 step buttonWide - 3, 47, gray filled
  xoff = (buttonWide - tws)\2 : yoff = 25 - ths\2
  color 0, gray : at x + xoff, y + yoff : ? s
end
 
sub OKwait() 
  local mx, my, bx, by
  bx = buttonX(nButtons + 3) : by = buttonY(nButtons + 3)
  drwbtn bx, by, "OK ?"
  while 1
    if pen(3) then
      mx = pen(4) : my = pen(5)
      if mx >= bx and mx <= bx + buttonWide then
        if my >= by and my <= by + 50 then
          exit loop
        fi
      fi
    fi
  wend
  rect bx, by step buttonWide + 5, 50, 0 filled
  
  delay 50 'in attempt to prevent magic button flipping on 
  '^^^^^^^^^^ 
  ' 2 times without popping on
  ' oh that may have helped!!!!!!!!!!!! 
  'now see if still works when I remove all this stuff I added to stop magic flipping
  ' Yes!!! Good, that was the fix
end
