
'Rotating Stars Mouse Chaser.bas for SmallBASIC 0.12.0 2015-11-09 MGA/B+
'code is based on code: mouse chaser by tsh73
'for the Just Basic contest, November 2008, I am 7 years later

nPoints = 20
dim x(nPoints), y(nPoints)
for i = 1 to nPoints
   x(i) = xmax
   y(i) = ymax     'set it offscreen
next
pen on
color 9,0
while 1'len(inkey)=0
   cls
   twist+=.05
   mx=pen(4):my=pen(5)
   for i = 1 to nPoints
      if i = 1 then   'first sees mouse
         dx=mx-x(i)
         dy=my-y(i)
         v=4
      else            'others see previous
         dx=x(i-1)-x(i)
         dy=y(i-1)-y(i)
         v=0.6*v+0.2*3*(2-i/nPoints) 'use 0.8 v of previous, to pick up speed
      end if
      r=sqr(dx^2+dy^2)
      dxN=dx/r
      dyN=dy/r
      x(i) = x(i)+v*dxN
      y(i) = y(i)+v*dyN
      drawstar
   next i
   showpage
   delay 10
wend
input OK

sub drawstar()
  local sp,s,t,u,j,b,v,w
  sp=(npoints+1-i)*2+3  'star points when i is low, points are high
  s=5*(50^(1/npoints))^(npoints+1-i)
  t=x(i)+s*cos(0+twist)
  u=y(i)+s*sin(0+twist)
  for j=1 to sp
    b+=int(sp/2)*2*pi/sp
    v=x(i)+s*cos(b+twist)
    w=y(i)+s*sin(b+twist)
    line t,u,v,w,14
    t=v:u=w
  next
end 
