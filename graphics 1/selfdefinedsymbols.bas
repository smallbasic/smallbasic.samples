
'''How to display seld defined symbols
''with ZOOM
''for SmallBasic
''(c) 02.11.2004 by Carsten
''Contact: smallbasic homepage
''

CLS
?"Demo for displaying self-defined symbols"
i=xmax/2:dx=5
never=0:ever=1
repeat
showsymbol i,99,3
showsymbol i,49,2
delay 12
clear i,99,3
clear i,49,2
i=i+dx
if i>xmax then dx=(0-dx)
if i<0 then dx=abs(dx)
until never=ever
end

sub showsymbol(sx,sy,zoom)
local i,j
restore Symbol
if zoom=0 then zoom=1
for j=0 to 7
 for i=0 to 7
  read w
  if w>0 then rect sx+(i*zoom),sy+(j*zoom),sx+((i+1)*zoom),sy+((j+1)*zoom),0 filled
 next j
next i
end

sub clear(sx,sy,zoom)
local bz
if zoom=0 then zoom=1
bz=zoom*8
rect sx,sy,sx+bz,sy+bz,15 filled
end



label Symbol
data 0,0,1,1,1,1,0,0
data 0,1,1,1,1,1,1,0
data 0,1,1,0,1,0,1,0
data 0,1,1,1,1,1,1,0
data 0,1,0,1,1,0,1,0
data 0,1,1,0,0,1,1,0
data 0,1,1,1,1,1,1,0
data 0,1,0,1,0,1,1,0

'
