' networking.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-04-14
' hey Ashish at QB64, you have a fan!
' I just watched this:
' https://www.openprocessing.org/sketch/111878
' wow this place has some cool stuff, too bad can't do transparent triangles

def rand(lo, hi) = (rnd * (hi - lo + 1)) \ 1 + lo 
def rdir = iff(rnd < .5, -1, 1)
def distance(x1, y1, x2, y2) = ( (x1 - x2) ^ 2 + (y1 - y2) ^ 2) ^ .5

nP = 85
dim p(nP), tri(7)

for i = 0 to nP
  p(i).x = rand(0, xmax)
  p(i).y = rand(0, ymax)
  p(i).dx = rdir * rnd * 6
  p(i).dy = rdir * rnd * 3.5
  p(i).c = rgb(rand(64, 255), rand(64, 255), rand(64, 255))
  p(i).r = rand(1, 4)
next

while 1
  cls
  for i = 0 to nP 'big show of points and triangle
    color p(i).c
    circle p(i).x, p(i).y, p(i).r filled
    for j = i + 1 to nP 'search for triangle points within 100 pixels
      if distance(p(i).x, p(i).y, p(j).x, p(j).y) < 130 then
        tri(0) = p(i).x : tri(1) = p(i).y
        tri(2) = p(j).x : tri(3) = p(j).y
        tri(6) = p(i).x : tri(7) = p(i).y
        for k = j + 1 to NP
          if distance(p(k).x, p(k).y, p(j).x, p(j).y) < 130 then
            tri(4) = p(k).x : tri(5) = p(k).y
            drawpoly tri 'filled 'or not filled ??
          end if
        next
      end if
    next
    'update points
    p(i).x = p(i).x + p(i).dx : p(i).y = p(i).y + p(i).dy
    if p(i).x < 0    then p(i).x = 0    : p(i).dx = p(i).dx * -1
    if p(i).x > xmax then p(i).x = xmax : p(i).dx = p(i).dx * -1
    if p(i).y < 0    then p(i).y = 0    : p(i).dy = p(i).dy * -1
    if p(i).y > ymax then p(i).y = ymax : p(i).dy = p(i).dy * -1 
  next
  showpage
wend
rem Welcome to SmallBASIC
