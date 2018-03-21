'Sierpinski in Space.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-05-28
'From  screen saver number 1.bas 2016-02-11 SmallBASIC 0.12.0 [B+=MGA]
'this version replaces solid triangle with Sierpinski line traingles.

randomize
def rdir = iff((rnd * 2)\1, 1, -1)
def rand(lo, hi) = (rnd * (hi - lo + 1)) \ 1 + lo 
const xtop = xmax + 100
const ytop = ymax + 100

label restart

ntri = rand(1, 5) : dim t(ntri) 'setup new set of triangles
for i = 1 to ntri  
  t(i).x1 = rand(-100, xtop) : t(i).x2 = rand(-100, xtop) : t(i).x3 = rand(-100, xtop)
  t(i).y1 = rand(-100, ytop) : t(i).y2 = rand(-100, ytop) : t(i).y3 = rand(-100, ytop)
  t(i).dx1 = rand(0, 10) * rdir : t(i).dx2 = rand(0, 10) * rdir : t(i).dx2 = rand(0, 10) * rdir
  t(i).dy1 = rand(0, 10) * rdir : t(i).dy2 = rand(0, 10) * rdir : t(i).dy2 = rand(0, 10) * rdir
  t(i).c = rgb( rand(55, 255) * rand(0, 1), rand(55, 255) * rand(0, 1), rand(55, 255) * rand(0, 1) )
  if t(i).c = 0 then t(i).c = rgb( rand(60, 255), rand(60, 255), rand(60,255) )
next
timesup = rand(5000, 25000)
tks = ticks

while ticks - tks < timesup
  if len(inkey) then goto restart
  cls
  for i = 1 to ntri
    color t(i).c
    SierLineTri t(i).x1, t(i).y1, t(i).x2, t(i).y2, t(i).x3, t(i).y3, 0
    t(i).x1 = t(i).x1 + t(i).dx1
    if t(i).x1 < -100 then t(i).dx1 = t(i).dx1 * -1
    if t(i).x1 > xtop then t(i).dx1 = t(i).dx1 * -1
    t(i).x2 = t(i).x2 + t(i).dx2
    if t(i).x2 < -100 then t(i).dx2 = t(i).dx2 * -1
    if t(i).x2 > xtop then t(i).dx2 = t(i).dx2 * -1
    t(i).x3 = t(i).x3 + t(i).dx3
    if t(i).x3 < -100 then t(i).dx3 = t(i).dx3 * -1
    if t(i).x3 > xtop then t(i).dx3 = t(i).dx3 * -1
    t(i).y1 = t(i).y1 + t(i).dy1
    if t(i).y1 < -100 then t(i).dy1 = t(i).dy1 * -1
    if t(i).y1 > ytop then t(i).dy1 = t(i).dy1 * -1
    t(i).y2 = t(i).y2 + t(i).dy2
    if t(i).y2 < -100 then t(i).dy2 = t(i).dy2 * -1
    if t(i).y2 > ytop then t(i).dy2 = t(i).dy2 * -1
    t(i).y3 = t(i).y3 + t(i).dy3
    if t(i).y3 < -100 then t(i).dy3 = t(i).dy3 * -1
    if t(i).y3 > ytop then t(i).dy3 = t(i).dy3 * -1
  next
  showpage
  delay 10
wend
goto restart

'Given 3 points of a triangle draw the Sierpinsky traiangle 
'within from the midpoints of each line forming the outer
'triangle. This is the basic Sierpinski Unit that is repeated
'at greater depths.
sub SierLineTri(x1, y1, x2, y2, x3, y3, depth)
  local mx1, mx2, mx3, my1, my2, my3
  
  if depth = 0 then 'draw out triangle if level 0
    line x1, y1, x2, y2
    line x2, y2, x3, y3
    line x1, y1, x3, y3
  end if
  
  'find midpoints
  if x2 < x1  then mx1 = (x1 - x2)/2 + x2 else mx1 = (x2 - x1)/2 + x1
  if y2 < y1  then my1 = (y1 - y2)/2 + y2 else my1 = (y2 - y1)/2 + y1
  if x3 < x2 then mx2 = (x2-x3)/2 + x3 else mx2 = (x3-x2)/2 + x2
  if y3 < y2 then my2 = (y2-y3)/2 + y3 else my2 = (y3-y2)/2 + y2
  if x3 < x1   then mx3 = (x1 - x3)/2 + x3 else mx3 = (x3 - x1)/2 + x1
  if y3 < y1   then my3 = (y1 - y3)/2 + y3 else my3 = (y3 - y1)/2 + y1
  
  line mx1, my1, mx2, my2 '  'draw all inner triangles
  line mx2, my2, mx3, my3
  line mx1, my1, mx3, my3
  
  if depth < 5 then 'not done so call me again
    SierLineTri(x1, y1, mx1, my1, mx3, my3, depth + 1)
    SierLineTri(x2, y2, mx1, my1, mx2, my2, depth + 1)
    SierLineTri(x3, y3, mx3, my3, mx2, my2, depth + 1)
  end if
end sub
