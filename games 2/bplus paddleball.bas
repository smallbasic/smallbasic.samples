
'Bplus paddleball 2016-02-05 for SmallBASIC 0.12.2 [B+=MGA]
'2016-02-06 sound added

rb=10
computer=0
player=0
initball

pen on
while player<21 and computer <21
  cls
  updatescore
  drawtable
  drawpaddle
  drawball
  showpage
  delay 10
wend
pen off
if computer>player then
  color 9,15
  s="  Game goes to Computer.  "
  at (xmax-txtw(s))/2+100,ymax/2-txth(s)/2:?s
else
  color 12,15
  s="  Game goes to Player!!!  "
  at (xmax-txtw(s))/2+100,ymax/2-txth(s)/2:?s
end if
showpage
delay 3000

sub initball
  xball=rnd*.4*xmax
  yball=ymax/2-.25*ymax+rnd*.5*ymax
  dx=rnd*6+17
  r=int(rnd*2)
  if r then dx*=-1
  dy=rnd*3+6
  r=int(rnd*2)
  if r then dy*=-1
end

sub updatescore
  color 12,0
  s="Player"
  at (100-txtw(s))/2,10:?s
  s=str(player)
  at (100-txtw(s))/2,40:?s
  color 9,0
  s="Computer"
  at (100-txtw(s))/2,100:?s
  s=str(computer)
  at (100-txtw(s))/2,140:?s
end

sub drawtable
  color rgb(230,190,230),0
  rect 100,0,xmax,ymax,rgb(0,128,80) filled
  rect 100,0,xmax,10 filled
  rect 100,ymax-10,xmax,ymax filled
  rect 100,0,110,ymax filled
  rect 100,50,110,50+10*rb,12 filled
  rect 100,ymax-50-10*rb,110,ymax-50,12 filled
  rect xmax-20,10,xmax,ymax-10,9 filled
end

sub drawpaddle
  my=pen(5)
  topy=my-5*rb
  boty=my+5*rb
  rect xmax-20,topy,xmax-10,boty,rgb(255,124,0) filled
  rect xmax-10,topy,xmax,boty,rgb(120,60,30) filled
end

sub drawball
  xball+=dx
  if xball>xmax-20 then
'next line if yball (LT sign) topy or yball (GT sign) boty then 'paddle miss
    if yball<topy or yball>boty then 'paddle miss
      computer+=1
      sound 100,100
      delay 500
      initball
    else 'paddle hit
      sound 660,20
      dx=dx*-1
      xball=xmax-20-rb
    end if
  end if
  if xball<110 then
'next line  if (yball(gt sign)50 and yball(LT sign)50+10*rb) or (yball(GT sign)ymax-50-10*rb and yball(LT sign)ymax-50) then
    if (yball>50 and yball<50+10*rb) or (yball>ymax-50-10*rb and yball<ymax-50) then
      player+=1
      sound 200,100
      delay 500
      initball
    else
      sound 990,20
      dx=dx*-1
      xball=110+rb
    end if  
  end if
  yball+=dy
  if yball<10+rb then
    sound 990,20
    dy=dy*-1
    yball=10+rb
  end if
  if yball>ymax-10-rb then
    sound 990,20
    dy=dy*-1
    yball=ymax-10-rb
  end if
  circle xball,yball,rb,1,14 filled
end 
