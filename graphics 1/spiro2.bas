
''' spiro2.bas
'' Simple eye-candyS demo
cls
rect 0,0,xmax,ymax color 0 filled
dim x(12)
dim y(12)

h1=ymax/2

for i=0 to 11
  t=cos(i*2*pi/12)
  x(i)=h1+t*(xmax/2-10)
  t=sin(i*2*pi/12)
  y(i)=h1+t*(ymax/2-10)
next
randomize
for i=0 to 4
 for a=11 to 0 step -1
  for b=11 to 0 step -1
    circle x(b),y(b),2 color rnd*14 filled
    line x(a),y(a),x(b),y(b) color b
next : next
next
for i=2 to 0 step -2
for a=11 to 0 step -1
  for b=11 to 0 step -1
    circle x(b),y(b),2 color 0 filled
    line x(a),y(a),x(b),y(b) color i
next : next: 
next
'
