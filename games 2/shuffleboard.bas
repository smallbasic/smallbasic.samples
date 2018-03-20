
rem shuffle v3.bas SmallBASIC 0.12.2 [B+=MGA] 2016-02-08 test new charging system for puck
rem Shuffleboard test by Johnno 2016-01-26
rem This is my modified 'friction on ice' program.
rem Very crude version of Shuffleboard - One Player.
rem Press and hold the SPACE key to release.
rem Press too long and you lose a life.
rem
rem 2016-01-26 [B+=MGA] testing on NOOK
rem 2016-01-27  modified to fit screen width
rem
rem 2016-01-27 {MGA fork} convert all Y dimensions in terms of text height 
rem ''''''''''''''''''''' convert lives to 10 shots then game over (added with stripe)
rem ''''''''''''''''''''' add mouse support, trim down code
rem 2016-02-08 Modifying puck charging system modified pen on/off and delays
rem '''''''''''''''''''' better ending?

const yellow = rgb(255,255,0)
const darkyellow = rgb(220,220,80)
const magenta = rgb(255,0,255)
const cyan = rgb(0,255,255)
const red = rgb(255,0,0)
const grey = rgb(128,128,128)
const blue = rgb(0,0,255)
const darkblue = rgb(0,0,128)
const orange = rgb(255,128,0)
const black = rgb(0,0,0)
const green = rgb(0,255,0)
const white = rgb(255,255,255)
const limit = xmax*.980
const th=txth("By")
const spacebar="Tap/Click/Drag/SPACEBAR(PC)... not too long"
cls

posX = th
posY = 7*th
score = 0
lives = 10
shot = 0
XVel = 0

'Main ==================================================
pen on
while lives>0
  updateStats
  updateBoard
  updatePlayer
  updateScore
  showpage
  delay 15
wend
pen off
updateStats
Gameover
pause

sub center(lineNum,txt)
  at xmax/2 - txtw(txt)/2,linenum*th : ? txt
end

sub stripe(tlXfracXmax)
  rect xmax*tlXfracXmax,2*th,xmax*tlXfracXmax+.005*xmax,11*th filled
end

sub updateStats
  cls
  color yellow,black
  center(14,"Score: " + str(score))
  color green,black
  center(16,"Shots Left: " + str(lives))
  color white,black
  center(18,spacebar) 
end

sub updateBoard
  rect 0,0,xmax,2*th,blue filled
  rect .25*th,.25*th,xmax-.25*th,1.75*th,darkblue filled
  rect 0,11*th,xmax,13*th,blue filled
  rect .25*th,11.25*th,xmax-.25*th,12.75*th,darkblue filled
  
  color white,black
  stripe .2
  at int(xmax*.25),3*th: print "10"
  
  color grey,black
  stripe .3
  at int(xmax*.35),3*th: print "20"
  
  color orange,black
  stripe .4
  at int(xmax*.45),3*th: print "30"
  
  color blue,black
  stripe .5
  at int(xmax*.55),3*th: print "40"
  
  color green,black
  stripe .6
  at int(xmax*.65),3*th: print "55"

  color cyan,black
  stripe .7
  at int(xmax*.75),3*th: print "75"
  
  color magenta,black
  stripe .8
  at int(xmax*.85),3*th: print "100"
  
  color yellow,black
  stripe .9
  at int(xmax*.95),3*th: print "-25"
  at int(xmax*.15),3*th: print "-25"

  color red,black
  center(21, "WARNING: Hit Red Stripe -50 !")
  stripe .995
end

sub updatePlayer
  k = inkey
  if k=" " or pen(3)=1  and posX < xmax/2 then 
    XVel = XVel + 0.8
  endif
  XVel = XVel * 0.98
  posX = posX + XVel
  posX = int(posX)
  posY = int(posY)
  'pause
  if posX > 2*th and XVel < 1 then XVel = 0
  if posX >= limit then
    color red,black
    posX = limit
    delay 1000
    score-=50
    lives-=1
    if lives=0 then gameover
    posX = th
    XVel = 0
  end if
  circle posX,posY,th,1,yellow filled
  circle posX,posY,.75*th,1,orange filled
end

sub updateScore
  if XVel=0 and posX>th then
    if posX>xmax*.9 and posX<limit-5 then
      score-=25
      elif posX>xmax*.8
        score+=100
      elif posX>xmax*.7
        score+=75
      elif posX>xmax*.6
        score+=55
      elif posX>xmax*.5
        score+=40
      elif posX>xmax*.4
        score+=30
      elif posX>xmax*.3
        score+=20
      elif posX>xmax*.2
        score+=10
      else
        score-=25  
      end if
      delay 1000
      posX=th
      lives-=1
      'at posX-th,posY+th:? int(posX)
  endif
end

sub Gameover
  color 15,0
  center(18,space(len(spacebar)+2))
  center(18,"Game Over...")
  showpage
  delay 20
end

