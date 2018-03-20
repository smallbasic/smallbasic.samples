
'boing.bas for SmallBASIC 2015-07-25 MGA/B+
'update for Android 2015-11-26
dim s(1 to 4,1 to 2) '4 corners
s(1,1)=0       : s(1,2)=50
s(2,1)=0       : s(2,2)=ymax-50
s(3,1)=xmax+30 : s(3,2)=50
s(4,1)=xmax+30 : s(4,2)=ymax-50
oldtx=0:oldtyty=0:da=.03
boingx=0:boingy=0
color 0,7 :cls

while 1
  showpage
  delay 20
  pen on
  if pen(3) then
    tx=pen(4)+20
    ty=pen(5)
    delay 50
  else
    tx=xmax/2
    ty=ymax/2
    if tx<>oldtx or ty<>oldty then
      boingx=3*(tx-oldtx)/4
      boingy=3*(ty-oldty)/4
    else 
      boingx=-3*boingx/4
      boingy=-3*boingy/4
    endif
    tx+=boingx
    ty+=boingy
  endif
  pen off
  a=0
  oldtx=tx
  oldty=ty  
  cls
  circle tx-20,ty,25 filled
  for corner = 1 to 4   
    s1x=s(corner,1)
    s1y=s(corner,2)
    dx=(tx-s1x)/2000
    dy=(ty-s1y)/2000
    x=tx-20
    y=ty
    for i=1 to 2000
      sx=20*cos(a)+x
      sy=20*sin(a)+y
      rect sx,sy,sx+2,sy+2 filled
      x-=dx:y-=dy
      a+=da
    next
  next
wend

