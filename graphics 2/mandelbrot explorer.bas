
'Mandelbrot explorer.bas for SmallBASIC 0.12.2 [B+=MGA] 2016-03-08
'I've seen this before and when JJ showed a version on basicpro,
'I was inspired to try one with SmallBASIC, original screen as basicpro

'miter= max iteration it decides how precise a level to go and the gray scale
' 8 is very crude general outline in 8 shades more or less and fast!
' 256 pretty detailed but very slow  16, 32, 64 are good levels
' press m and you will be asked to >enter a new level under the big screen label

'zoom in, out or stay just press the first letter i,o or s... no capitals

'the mouse click controls when a redraw takes place according to zoom and miter
'the next screen will be centered at the point you click and zoomed in|out|stay

xoff=(xmax-640)\2
rpf="##.00000000"
th=txth("Q")
xl=-2.6667 '<==== to match basicpro numbers
xr=2.6667
yt=-2      '<==== to match basic pro numbers
yb=2
zm=(xr-xl)/640
miter=128
mode="s"

label restart
t=timer          '========= mandelbrot section
color 15,0:cls
y=0
while y<=479
  x=0
  while x<=639
    zx=0
    zy=0
    cx=x*zm+xl
    cy=y*zm+yt
    i = miter
    while zx*zx+zy*zy <4 and i >0
      tmp = zx * zx - zy * zy + cx
      zy = 2 * zx * zy + cy
      zx = tmp
      i=i-1
    wend
    cc=i/miter
    pset x+xoff, y, rgbf(cc,cc,cc)
    x = x + 1
  wend
  y = y + 1
wend

t=(timer-t) '====================== screen labeling
color 0,rgb(255,180,180)
rect 0,482,xmax-2,480+4.5*th-2,rgb(255,180,180) filled
rect 0,482,xmax,480+4.5*th,15
lnum=480+.15*th
printlabel "Mandelbrot 640 x 480 pixel projection by SmallBASIC 0.12.2",lnum
s="x = "+format(rpf,xl)+" to "+format(rpf,xr)+"      y = "+format(rpf,yt)+" to "+format(rpf,yb)
lnum+=th
printlabel s,lnum
lnum+=th
s="Scale X "+str((1/zm+.5)\1)+"    Time = "+str(t)+" secs"
printlabel s,lnum
lnum+=th
s="Key m for Miter = "+str(miter)+"   Keys for Zoom: i=in o=out s=slide  Zoom = "+mode
printlabel s,lnum

' now wait for key press or mouse click
redraw=0
pen on
repeat
  ink=inkey
  if len(ink) then
    reprint=0
    if instr("ios",ink) then mode=ink:reprint=1
    if ink="m" then
      at (xmax-txtw("( <4 quits) New miter "))/2,480+5.5*th: input "( <4 quits) New miter ",mtest
      if mtest>=4 then miter=mtest:reprint=1 else end
    end if   
    if reprint then
      s="Key m for Miter = "+str(miter)+"   Keys for Zoom: i=in o=out s=slide  Zoom = "+mode
      printlabel s,lnum
    end if
  end if 'key press
  if pen(3) then
    mx=pen(4):my=pen(5)
    if mx-xoff<640 and mx-xoff>=0 and my<480 then 'that's what we are waiting for
      redraw=1
      mx=(mx-xoff)*zm+xl:my=my*zm+yt
      if mode="s" then
        dist=(xr-xl)/2:xr=mx+dist:xl=mx-dist
        dist=(yb-yt)/2:yt=my-dist:yb=my+dist
      elif mode="i"
        dist=(xr-xl)/4:xr=mx+dist:xl=mx-dist
        dist=(yb-yt)/4:yt=my-dist:yb=my+dist
        zm=(xr-xl)/640
      elif mode="o"
        dist=(xr-xl):xr=mx+dist:xl=mx-dist
        dist=(yb-yt):yt=my-dist:yb=my+dist
        zm=(xr-xl)/640
      end if
    end if 'mouse in range
  end if 'mouse click
until redraw
pen off
goto restart

sub printlabel(labelstring, y)
  AT (xmax-txtw(labelstring))/2,y:? labelstring
end
