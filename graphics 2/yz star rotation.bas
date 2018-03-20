
'YZ star rotation.bas 2015-11-29 SmallBASIC 0.12.0 [B+=MGA]

d=5:md=int(d/2) 'point star

xc=xmax/2:yc=ymax/2:if xc>yc then s=yc-10 else s=xc-10
xo=1:xd=1:yo=1:yd=1
color 14,0
while 1
   while r<50
  r+=1
  cls
  at xc,0:? d
  t=xc+s*cos(b)*xo:u=yc+s*sin(b)
  for i=1 to d
    b+=md*2*pi/d
    v=xc+s*cos(b)*xo:w=yc+s*sin(b)
    line t,u,v,w
    t=v:u=w
  next
  showpage
  b+=.1*d
  xo-=.1*xd
  if xo<-1 then xo=-1:xd=-xd
  if xo>1 then xo=1:xd=-xd
  delay 50
  wend
  d=d+2:md=int(d/2):b=0:r=0
wend
