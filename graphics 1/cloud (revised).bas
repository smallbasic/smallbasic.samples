
''' cloud.bas
'' From "Fractals" by Hans Lauwerier
'' Shows Orbits of a dynamical system
'' by Tim Corcoran 2001
'' modified by ML 4/1/07

xoffs = xmax/2
yoffs = ymax/2

cls
a = 3.5
b=-3
x=3.21
y=6.54
sub1

for n=0 to 25000
  pset (x*4)+xoffs,(y*4)+yoffs
  z=x
  x=y+w
  sub1
  y=w-z
next n

beep
end

sub sub1
if x>1 then w=a*x+b*(x-1): exit sub
if x<-1 then w=a*x+b*(x+1):  exit sub
w = a*x: exit sub: end
end sub
'
