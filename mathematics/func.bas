REM SmallBASIC
REM created: 11/08/2019

func yfn(x)
 return x^2
' return log(sin(x))
' return log(x)
' return sin(x)*(tan(x)+.1)
' return 1/(cos(x)+.001)
' return atan(x)*tan(x+.001)
'return -3*x-5
' return iff(x==0, 0, 1/x)*12
end

xm=xmax/2
ym=ymax/2
tw=30
th=30
xn=int(xm/tw)
yn=int(ym/th)
xw=xm/xn
yh=ym/yn
thh=th/2
tww=tw/4
grey=rgb(60,60,90)

for x = 0 to xn
  xleg(x)
  xleg(-x)  
next j

for y = 0 to yn
  yleg(y)
  yleg(-y)  
next j

line xm,0,xm,ymax,15
line 0,ym,xmax,ym,15

sub xleg(x)
  local px = xpx(x)
  line px, 0, px, ymax, grey
end

sub yleg(y)
  local py = ypx(y)
  line 0, py, xmax, py, grey
end

func xpx(x)
  return xm + x * xw
end

func ypx(y)
  return ym + y * yh
end

sub plotx
  local px,py,x,y,po
  po=[]
  for x = -xn to xn
    y =- yfn(x)

    po << [xpx(x),ypx(y)]
  next x
  drawpoly po color 2
end

plotx

