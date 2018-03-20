
'2016-02-08 now updated to loose need for keyboard, much cleaner screen
REM Crop Circles.bas for SmallBASIC 0.12.0 
REM created: 05-11-2015 MGA/B+ for On-line samples
' This is almost a direct translation of PeterMaria's BP.org post:
' "Alien Signs" 1-11-2015, I changed the coloration for my own title

xq=xmax/2
yq=ymax/2
color 15,2
pen on
while 1
  cls
  r0= Rand(1,5)/10: r1=Rand(1,5)/10: r2=Rand(1,5)/10
  fc= Rand(10,200)/10: st=Rand(10,500)/800
  xol=0
  yol=0
  mol=0
  for i=0 to 120 step st
    a0=(i/r0)*(2*pi)
    a1=((i/r1)*(2*pi))*-1
    x1=xq+(sin(a0)*((r0-r1)*fc))*50
    y1=yq+(cos(a0)*((r0-r1)*fc))*50
    x2=x1+(sin(a1)*((r2)*fc))*50
    y2=y1+(cos(a1)*((r2)*fc))*50
    if mol = 0 then
      mol = 1
      xol = x2                                                             
      yol = y2
    else 
      line xol,yol,x2,y2,rgb(0,194,0)
      xol=x2
      yol=y2
    end if
  next    
  'locate 0,0: input "press enter for next screen ";t
  at 10,10:?"Tap/click/press key  for next screen..."
  showpage
  pause
wend
pen off
func rand(low, high)
  rand=rnd*(high-low)+low
end