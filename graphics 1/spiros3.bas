
''' 3spiros.bas
'' Mindless simple Eye Candy 
cls
rect 0,0,xmax,ymax color 0 filled
dim x(12):dim x1(12)
dim y(12):dim y1(12)
a=xmax/4-10:j=5
d=xmax/2: e=xmax/4: f=xmax*3/4
for i=0 to 11
  t=cos(i*2*pi/12)
   x(i)=t*a: x1(i)=t*12
  t=sin(i*2*pi/12)
   y(i)=t*a: y1(i)=t*12
    circle x1(b)+d,y1(b)+d-18,1 color 15 filled
next
at xmax/2-txtw("5")/2, ymax/2-18-txth("5")/2 :  color 7,0 : ? "5";

for i=0 to 4
 for a=11 to 0 step -1
  for b=11 to 0 step -1
    circle x1(b)+d,y1(b)+d-18,1 color a+2 filled
    line x(a)+e,y(a)+e,x(b)+e,y(b)+e color a+2
    line x(a)+f,y(a)+e,x(b)+f,y(b)+e color b+2
    line x(a)+d,y(a)+f,x(b)+d,y(b)+f color i+a+1
    next : next
    j=j-1
    at xmax/2-txtw("8")/2, ymax/2-18-txth("8")/2 
    color 7,0 : ? j;
next

 for a=11 to 0 step -1
  for b=11 to 0 step -1
    line x(a)+e,y(a)+e,x(b)+e,y(b)+e color 0
    line x(a)+f,y(a)+e,x(b)+f,y(b)+e color 0
    line x(a)+d,y(a)+f,x(b)+d,y(b)+f color 0
next : next
cls
'
