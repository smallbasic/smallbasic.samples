
'3d rotating cube with message, harixxx 2016-02-22
rotx=2
roty=3
rotz=1
zoom=1

'store message
w=txtw("W")
h=txth("H")
m=6*w-1
x=w/2
y=(m-2*h)/2
at x,y:?"Small
at x,y+h:?"BASIC
for y=0 to m
for x=0 to m
'take the strong pixel only
if (-point(x,y) & 255)>50
if y<m/2 then c=0 else c=1
ms << [x,y,c]
fi
next
next
u=ubound(ms)

'3d cube coords xyz
p=[1,1,1;-1,1,1;-1,1,-1;1,1,-1;1,-1,1;-1,-1,1;-1,-1,-1;1,-1,-1]
'cube face poly
f=[3,2,1,0;4,7,3,0;4,5,6,7;1,2,6,5;3,7,6,2;1,5,4,0]

'device scaling
cx=xmax/2
cy=ymax/2
scl=min(cx,cy)/2

'main loop
while 1
'set frame to display 30 fps
'may this catch fps by ticks
ti=ticks+tickspersec/30
cls
'rotation
xr=(xr+rotx)mod 360
yr=(yr+roty)mod 360
zr=(zr+rotz)mod 360
'zoom
zm=(zm+zoom)mod 180

a=rad(1)
xs=sin(xr*a)
ys=sin(yr*a)
zs=sin(zr*a)
xc=cos(xr*a)
yc=cos(yr*a)
zc=cos(zr*a)
sz=sin(zm*a)*scl+scl*.4

t=p
'3d rotation and translate
for i=0 to 7
z=p(i,2)*xc-p(i,1)*xs
y=p(i,1)*xc+p(i,2)*xs
x=p(i,0)*yc-z*ys
z=(z*yc+p(i,0)*ys)/256+1
t(i,0)=(x*zc-y*zs)/z*sz+cx
t(i,1)=(y*zc+x*zs)/z*sz+cy
next

'draw cube
for i=0 to 5
x1=t(f(i,0),0)
y1=t(f(i,0),1)
x2=t(f(i,1),0)
y2=t(f(i,1),1)
x3=t(f(i,2),0)
y3=t(f(i,2),1)
'calc normal
n=(x1-x2)*(y3-y2)-(x3-x2)*(y1-y2)
if n>=0
x4=t(f(i,3),0)
y4=t(f(i,3),1)
a=[x1,y1,x2,y2,x3,y3,x4,y4]
l=min(1,n/40000+.4)
c=rgbf(l/3,l/2,l)
'draw cube face poly
drawpoly a color c filled

c1=[rgbf(l/4,l,l),rgbf(l,l,l)]
c2=rgbf(0,0,l/2)
r=sz/100*l+2
sx1=(x4-x1)/m
sy1=(y4-y1)/m
sx2=(x3-x2)/m
sy2=(y3-y2)/m
'draw message on the cube side
for j=0 to u
x=ms(j)(0)
y=ms(j)(1)
c=ms(j)(2)
tx1=sx1*x+x1
ty1=sy1*x+y1
tx2=(sx2*x+x2-tx1)/m
ty2=(sy2*x+y2-ty1)/m
xx=tx2*y+tx1
yy=ty2*y+ty1
circle xx,yy,r color c1(c) filled
circle xx,yy,r color c2
next
fi
next

showpage
'if ticks move foward
'we can catch the fps here
while ticks<ti do wait=here
'if the display still to fast
'replace while cmd above with delay
wend
