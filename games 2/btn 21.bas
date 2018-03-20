
'btn 21.bas  SmallBASIC 0.12.2 [B+=MGA] 2016-03-24
'massive overhaul from Black Jack games that started with funky MS Small Basic code
'translated to SmallBASIC 0.12.2 then SdlBasic then JB then back to SmallBASIC 0.12.2
'under new names for game and variables and procedures, orig code had over 300 lines
'called TWENTYONE because the rules and play is not quite the same as Black Jack
2016-03-25 working with mouse and buttons, updated Cardname function and drawcard sub
2016-03-25 post as btn 21.bas

const ytb=ymax/2-50
const ybb=ymax/2
const xlb1=10
const xlb2=220
const xlb3=430
dim deck(52),player(11)
for i=1 to 52
  deck(i)=i
next
points=100

while 1
  if points<=0 then exit
  total=0:pointsrisk=0:ace=0
  'first thing when start a round show game and points status
  color 11,3:cls
  ?"TWENTYONE status: You have ";points;" points available to risk.":?
  for i=1 to 10
    if i*10<=points then drwbtn xmax/8,i*50,"risk "+str(i*10)+" points"
  next
  drwbtn xmax/8,550,"risk all points!"
  drwbtn xmax/8,600,"leave table"
  pen on
  choice=0
  repeat
    if pen(3) then
      mx=pen(4):my=pen(5)
      if mx>xmax/8 and mx<xmax/8+200 then
        for i=1 to 12
          if my>50*i and my<50*i+50 then
            if i>=11 or (i<11 and i*10<=points) then choice=i
          end if
        next
      end if
    end if
  until choice<>0
  pen off
  delay 120
  if choice=12 then
    exit
  elif choice=11
    pointsrisk=points
  else
    pointsrisk=choice*10
  end if
  for i=52 to 2 step -1
    r=int(rnd*(i))+1
    swap deck(r),deck(i)
  next
  deckindex=1 'first card to draw
  dim player(11)
  playerindex=1
  drawcard
  drawcard
  startround
wend

sub startround
  while 1
    if total>35 then stay:exit
    color 11,3:cls
    ? "TWENTYONE:";"    points: ";points;"    risk: ";pointsrisk:?
    for i=1 to playerindex-1
      ? player(i)
    next
    ?:? "Card Total at present is ";total:?
    drwbtn xlb1,ytb,"Another Card"
    drwbtn xlb2,ytb,"Stay"
    if ace=11 then
      drwbtn xlb3,ytb,"Make Ace = 1"
    end if
    pen on
    choice=0
    repeat
      if pen(3) then
        mx=pen(4):my=pen(5)
        if my>ytb and my<ybb then
          if mx>xlb1 and mx<xlb1+200 then
            choice=1
          elif mx>xlb2 and mx<xlb2+200
            choice=2
          elif ace=11 and mx>xlb3 and mx<xlb3+200
            choice=3
          end if
        end if
      end if
    until choice<>0
    pen off
    color 11,3
    rect xlb1,ytb,xlb3+200,ybb,3 filled
    delay 160
    if choice=3 then
      total-=10:ace=1
    elif choice=2
      stay:exit
    elif choice=1
      drawcard 
    end if
  wend
end

sub drawcard
  value=deck(deckindex) mod 13
  if value=1 then
    if ace=0 or ace =1 then
      if total<11 then ace=11 else ace=1
      total+=ace
    elif ace=11
      total+=1
    end if
  elif value>1 and value<10
    total+=value
  else
    total+=10
  end if
  if total>21 and ace=11 then
    total-=10:ace=1
  end if
  deckindex++ 
  player(playerindex)=cardname(value)
  playerindex++
end

sub stay 'ends a round
  at 0,ybb+10:?:?"Dealer's cards:":?
  dealtotal=0
  while dealtotal<15
    dcard=deck(deckindex)
    deckindex++
    cname=cardname(dcard)
    if dcard=1 or dcard=14 or dcard=27 or dcard=40 then 'deal with ace
      if dealtotal<11 then dealtotal+=11:dealace=11 else dealtotal+=1
    else
      test=val(left(cname,2))
      if test>1 and test<10 then dealtotal+=test else dealtotal+=10
    end if
    if dealtotal>21 and dealace=11 then dealtotal-=10:dealace=1 
    ? cname
  wend
  ?:?"The dealer has a total of ";dealtotal;".":?
  if (total>dealtotal and total<=21) or (total<=21 and dealtotal>21) then
    points+=pointsrisk
    ?"You won ";pointsrisk;" pts!":?
  elif (dealtotal>total and dealtotal<=21) or (total>21 and dealtotal<=21)
    points-=pointsrisk
    ?"You lost ";pointsrisk;" pts.":?
  else
    ?"You tied.":?
  endif
  if points>0 then s="Continue..." else s="Out of points..."
  drwbtn xlb2,ytb,s
  pen on
  mx=0:my=0:choice=0
  repeat
    if pen(3) then
      mx=pen(4):my=pen(5)
      'delay 70 ' to avoid a double key press from slow mouse
      if mx>xlb2 and mx<xlb2+200 then
        if my>ytb and my<ybb then choice=1
      end if
    end if
  until choice<>0
  pen off
  delay 160
end

func cardname(avalue)
local test,suitname,cn
  test=(avalue-1)\13
  if test=0 then
    suitename = "Spades"
  elif test=1
    suitename = "Hearts"
  elif test=2
    suitename = "Clubs"
  elif test=3
    suitename = "Diamonds"
  end if
  test=avalue mod 13
  if test=1 then
    cn="Ace"
  elif test=11
    cn="Jack"
  elif test=12
    cn="Queen"
  elif test=0
    cn="King"
  elif test>1 and test<11
    cn=str(test)
  end if
  cardname=cn+" of " + suitename
end

sub drwbtn(x,y,s)
  local th,tw,gray,xoff,yoff
  th=txth(s):tw=txtw(s):gray=rgb(190,190,190)
  rect x,y step 200,50,0 filled
  rect x,y step 197,47,15
  rect x+1,y+1,step 197,47,gray filled
  xoff=100-tw\2:yoff=25-th\2
  color 0,gray:at x+xoff,y+yoff:? s
end
