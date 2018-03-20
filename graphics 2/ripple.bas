
dim vs(319,199)
?"wait a moment..
showpage
at 5,175
?"SmallBASIC  TESTED ON Jellybean"
xm=xmax
ym=ymax
xs=xm/319+1
ys=ym/199+1
for y=0 to 199
for x=0 to 319
l=sqr((y-140)^2+(x-160)^2)
b=-point(x*.28,y/5+160) & 255
b+=-point(y+92,493-x)& 255
r=min(255,max(0,255-l-l))
g=min(255,max(0,(x xor y)/4+r/2+b))
b=max(0,g/8-r/8+20-y+r/100*b)*.8
c=rgb(r,g,b)
vs(x,y)=c
pset x,y,c
next
next
for y=0 to 199
for x=0 to 319
c=vs(x,y)
xx=xm*x/319
yy=ym*y/199
rect xx,yy,step xs,ys,c filled
next
next

while 1
i=(i+1)mod 360
for y=0 to 39
y2=162-y+5*sin(y+i)
for x=0 to 319
c=vs(x,y2)
xx=xm*(x-y2/12+15)/319
yy=ym*(y+160)/199
rect xx,yy,step xs,ys,c filled
next
next
showpage
wend
