
'
'Mastermind v7.bas 2016-02-27 [B+=MGA] for SmallBASIC 0.12.2
'translated and modified from SdlBasic and forum input
'Thanks to Johnno for all his input, I used much
'v6 modified with new countingCattle function, more 3d look and color
'v7 don't need EXIT button more room for Guess button
'V7 change color selected bar

randomize
option base 1
const tw=txtw("B")
const th=txth("By")
const cx=xmax/2
const cy=ymax/2

const sq=min(xmax,ymax)
const diam=sq/10
const radi=sq/20

const bullcowl=cx-4*diam-6*tw
const framel=bullcowl+5*tw
const cpl=cx+tw
const cpr=cx+2*tw+2*diam

const w=rgb(255,255,255)
const gy=rgb(190,190,205)
const board=rgb(150,150,165)
const b2=rgb(80,80,95)
const deck="RGBYOP"      'here are 6 color initials Red Green Blue Yellow Orange Purple

label restart
DIM gues(4) 'cc= color counts, so  ccs= color counts in secret$,  ccg= color counts in guess$
secret="" : for i=1 to 4 : secret=secret+mid(deck,int(rnd*6)+1,1) : next  'one line to make secret$
rect cx-sq/2,0,cx+sq/2,sq,board filled
curcolr=r:clr="R"   'screen prep and initialization
drawcontrols
color w,board
at cx+tw,2:? "Mastermind: 4 color code"
at cx+tw,th+2:?"  C=Cow right color only"
at cx+tw,2*th+2:?"  B=Bull color and spot"
guesses = 0 : lc=0
rect framel-.5*tw,0,cx-.5*tw,sq,b2 filled
drawframe
pen on
quit=0
while quit=0 'the game begins
  if pen(3)=1 then
    mx=pen(4):my=pen(5)
    delay 70
    if mx> cpl and mx<cpr and my> 1.5*diam and my< 9*diam then  'click in control panel
      if my< 2.5*diam then 'guess button clicked
        handleguess
      elseif my< 4*diam 'clicked a color update in control panel or quit
        curcolr=r:clr="R":updatecolor
      elseif my< 5*diam
        curcolr=g:clr="G":updatecolor
      elseif my< 6*diam
        curcolr=b:clr="B":updatecolor
      elseif my< 7*diam
        curcolr=y:clr="Y":updatecolor
      elseif my< 8*diam
        curcolr=o:clr="O":updatecolor
      elseif my< 9*diam
        curcolr=p:clr="P":updatecolor
      end if 'mouse in control box
    elseif mx> framel and mx< framel+4*diam and my> lc*diam and my< lc*diam+diam 'mouse click in the guess boxes
      if mx< framel+diam then
        gues(1)=clr
        ball framel+radi,lc*diam+radi,clr
      elseif mx< framel+2*diam
        gues(2)=clr
        ball framel+1.5*diam,lc*diam+radi,clr
      elseif mx< framel+3*diam
        gues(3)=clr
        ball framel+2.5*diam,lc*diam+radi,clr
      elseif mx< framel+4*diam
        gues(4)=clr
        ball framel+3.5*diam,lc*diam+radi,clr
      end if 'mouse in guess frame
    end if ' mouse positions on click
  end if 'mousebutton
  checkguess
  delay 20
wend
pen off

sub handleguess()
  OK=1:guess=""
  for i=1 to 4
    if gues(i)="" then
      OK=0
    else
      guess=guess+gues(i)
    end if
  next
  if OK then
    color 0,board
    guesses += 1
    if guess = secret then
      at cx+tw,9*diam : ? "You won after ";guesses;" guesses!"
      at cx+tw,9*diam+th : ? "Click/tap to restart..."
      delay 500
      while pen(0)=0 and pen(3)=0 : delay 100 : wend
      color 15,0: cls : goto restart
    end if
    if guesses=10 then
      at cx+tw,9*diam : ? "The code was: "+secret
      at cx+tw,9*diam+th : ? "Click/tap to restart..."
      delay 500
      while pen(0)=0 and pen(3)=0 : delay 100 : wend
      color 15,0: cls : 
      goto restart
    end if
    at bullcowl,lc*diam+radi-.5*th : ? countingCattle(secret,guess)
    lc=lc+1
    drawframe
    for i=1 to 4:gues(i)="":next
  end if 'guess OK ends handling guess$
end
 
sub checkguess()
  local OK,i
  OK=1
  for i=1 to 4
    if gues(i)="" then OK=0
  next
  if OK=1 then
    rect cpl,1.5*diam,cpr,2.5*diam,w filled
    rect cpl+1,1.5*diam+1,cpr,2.5*diam,gy filled 'guess box
    color 0,gy
    s="Guess"
    tx=cpl+(cpr-cpl)/2-txtw(s)/2
    ty=2*diam-txth(s)/2
    at tx,ty:?s
  else
    rect cpl,1.5*diam,cpr,2.5*diam,board filled
  end if
end

sub drawframe()
  local sc,i,cc
  sc=64/(radi-5)
  for i=0 to 3
    for rr=radi-5 to 0 step -1
      cc=rr*sc
      circle framel+diam*i+radi,lc*diam+radi,rr,1,rgb(cc,cc,cc+15) filled
    next
  next
end

sub drawcontrols()
  local i,cplr
  cplr=cpl+radi
  ball cplr,3.5*diam,"R"
  ball cplr,4.5*diam,"G"
  ball cplr,5.5*diam,"B"
  ball cplr,6.5*diam,"Y"
  ball cplr,7.5*diam,"O"
  ball cplr,8.5*diam,"P"
  updatecolor
end

sub updatecolor()
  rect cpl+diam+tw,3*diam,cx+sq/2,9*diam,board filled
  ymult=instr(deck,clr)
  color clr,board
  at cpl+diam+tw,(ymult+2)*diam+radi-.5*th : ? "< = Selected Color"
end

func countingCattle(secrt,guss)
  local bulls,cows,build,i,j
  bulls=0:cows=0:build=""
  for i=1 to len(secrt)
    if mid(secrt,i,1)=mid(guss,i,1) then bulls+=1
  next
  for i=1 to len(secrt)  'this destroys the copy of guess given the function
    if len(guss) then
      for j=1 to len(guss)  'every match with secret is removed from guess
        if mid(secrt,i,1)=mid(guss,j,1) then cows+=1:guss=replace(guss,j,"",1):exit for 
      next
    end if
  next
  cows=cows-bulls
  if bulls then build=build+string(bulls,"B")
  if cows then build=build+string(cows,"C")
  if !(bulls or cows) then build="X"
  countingCattle=build 
end

sub ball(x,y,cx)
   local r,sc,start
   sc=32/radi:start=int(32/sc)-2
   for r=start to 0 step -1
      if cx ="R" then 
         circle x,y,r,1,rgb(255-6*r*sc,0,0) filled
      elif cx="B"
         circle x,y,r,1,rgb(0,0,255-6*r*sc) filled
      elif cx="G"
         circle x,y,r,1,rgb(0,220-6*r*sc,0) filled
      elif cx="O"
         circle x,y,r,1,rgb(255-3*r*sc,150-3*r*sc,0) filled
      elif cx="Y"
         circle x,y,r,1,rgb(255-4*r*sc,255-4*r*sc,0) filled
      elif cx="P"
         circle x,y,r,1,rgb(255-7*r*sc,0,130-2*r*sc) filled
       fi
   next
end
