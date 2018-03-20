
'texting.bas for SmallBASIC 0.12.2 [B+=MGA] 2016-02-21

cx=xmax/2
cy=ymax/2
dim cc(3)
cc(0)=9
cc(1)=14
cc(2)=12
cc(3)=rgb(0,128,0)
mess="SmallBASIC"   
? mess
xd=txtw(mess)
yd=txth(mess)
side=xd+2*yd
dim dat(xd,yd)
for y=0 to yd
   for x=0 to xd
      if point(x,y)<>point(0,0) then dat(x,y)=1
   next
next

repeat 
  scale++
until scale*side>xmax or scale*side>ymax
scale=scale-1
start=scale
ccc=0
cls

while 1
  color cc(ccc mod 4),0
  pmess cx-.5*xd*scale,cy-.5*side*scale,scale
  color cc((ccc+1) mod 4)
  downmess cx+.5*xd*scale,cy-.5*xd*scale,scale
  color cc((ccc+2) mod 4)
  revmess cx-.5*xd*scale,cy+.5*xd*scale,scale
  color cc((ccc+3) mod 4)
  upmess cx-.5*side*scale,cy-.5*xd*scale,scale
  scale-=1
  ccc+=1
  ccc=ccc mod 4
  if scale<0.1 then 
    restart++
    ccc=restart mod 4
    scale=start
  end if
  delay 100
wend

sub upmess(lx,ty,scale)
  local x,y
  for y=0 to yd
    for x=0 to xd
      if dat(x,y) then
        rect lx+y*scale,ty+xd*scale-x*scale step scale,scale filled
      end if
    next
  next
end
sub downmess(lx,ty,scale)
  local x,y
  for y=0 to yd
    for x=0 to xd
      if dat(x,y) then
        rect lx+yd*scale-y*scale,ty+x*scale step scale,scale filled
      end if
    next
  next
end
sub pmess(lx,ty,scale)
  local x,y,sx,sy,c
  for y=0 to yd
    for x=0 to xd
      if dat(x,y) then
        'c=dat(x,y)
        'rect lx+x*scale,ty+y*scale step scale,scale,c filled
        rect lx+x*scale,ty+y*scale step scale,scale filled
        end if
    next
  next
end
sub revmess(lx,ty,scale)
  local x,y
  for y=0 to yd
    for x=0 to xd
      if dat(xd-x,yd-y) then
        'c=dat(xd-x,yd-y)
        rect lx+x*scale+scale,ty+y*scale+scale step scale,scale filled
      end if
    next
  next
end
