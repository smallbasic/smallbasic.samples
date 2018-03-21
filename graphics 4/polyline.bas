
' poly thick line test.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-04-01

const cx = xmax/2
const cy = ymax/2

'new kick butt fast ptline!!!
sub ptline(x1, y1, x2, y2, thick) 'this draws a little rectangle
  local arr, r, dx, dy, perpA1, perpA2
  dim arr()
  r = thick/2
  dx = x2 - x1
  dy = y2 - y1
  perpA1 = atan2(dy, dx) + pi/2
  perpA2 = perpA1 - pi
  arr << x1 + r * cos(perpA1) 'corner 1
  arr << y1 + r * sin(perpA1) 
  arr << x2 + r * cos(perpA1) 'corner 2
  arr << y2 + r * sin(perpA1) 
  arr << x2 + r * cos(perpA2) 'corner 3
  arr << y2 + r * sin(perpA2) 
  arr << x1 + r * cos(perpA2) 'corner 4
  arr << y1 + r * sin(perpA2)
  arr << x1 + r * cos(perpA1) 'back to first corner
  arr << y1 + r * sin(perpA1)
  drawpoly arr filled
end

'versus MGA's old slow thickLine
sub rtLine(x1, y1, x2, y2, rThick)
  'x1, y1 is one endpoint of line
  'x2, y2 is the other endpoint of the line
  'rThick is the radius of the tiny circles that will be drawn 
  '   from one end point to the other to create the thick line
  'Yes, the line will then extend beyond the endpoints with circular ends.

  local length, stepx, stepy, dx, dy, i
  rThick = int(rThick/2) : stepx = x2 - x1 : stepy = y2 - y1
  length = int((stepx ^ 2 + stepy ^ 2) ^.5)
  if length then
    dx = stepx / length : dy = stepy / length
    for i = 0 to length
      circle x1 + dx * i, y1 + dy * i, rThick filled
    next
  else
    circle x1, y1, rThick filled
  end if
end

'Thanks Andy Amaya!
func tline(x1, y1, x2, y2, pensize)
    If penSize < 2 Then Line x1, y1, x2, y2 : Return
'    penSize is thickness to draw line
    offst = Int(penSize/2)    'offset to center rects
'    Calculate deltax and deltay for initialization
    deltax = Abs(x2 - x1)
    deltay = Abs(y2 - y1)
'    Initialize all variables based on which is the independent variable
    If deltax >= deltay Then
'        x is the independent variable
        numRects = deltax + 1
        d = Int(deltay/2) - deltax
        dinc1 = Int(deltay/2)
        dinc2 = Int((deltay - deltax)/2)
        xinc1 = 1
        xinc2 = 1
        yinc1 = 0
        yinc2 = 1
    Else
'        y is the independent variable
        numRects = deltay + 1
        d = Int(deltax/2) - deltay
        dinc1 = Int(deltax/2)
        dinc2 = Int((deltax - deltay)/2)
        xinc1 = 0
        xinc2 = 1
        yinc1 = 1
        yinc2 = 1
    End If
'    Make sure x and y move in the right directions
    If x1 > x2 Then
        xinc1 = -xinc1
        xinc2 = -xinc2
    End If
    If y1 > y2 Then
        yinc1 = -yinc1
        yinc2 = -yinc2
    End If
'    Start drawing at x, y
    x = x1 - offst
    y = y1 - offst
'    Draw the filled rects
    For i = 1 To numRects
        rect x,y, x+pensize, y+pensize
        If d < 0 Then
            d = d + dinc1
            x = x + xinc1
            y = y + yinc1
        Else
            d = d + dinc2
            x = x + xinc2
            y = y + yinc2
        End If
    Next
End

t0 = ticks
for c = 1 to 15
  color c
  for a = 0 to 2 * pi step pi/36
    rtline cx, cy, cx + 300 * cos(a), cy + 300 * sin(a), 15
  next
next
rtTime = ticks - t0
? "MGA's old method for thick line took ";rtTime;" ms to draw this 15 times."
delay 3000
cls
t0 = ticks
for c = 1 to 15
  color c
  for a = 0 to 2 * pi step pi/36
    ptline cx, cy, cx + 300 * cos(a), cy + 300 * sin(a), 15
  next
next
ptTime = ticks - t0
? "MGA's new method for thick line took ";ptTime;" ms to draw this 15 times."
? "New method time / Old method time is ";ptTime / rtTime
delay 3000
cls
t0 = ticks
for c = 1 to 15
  color c
  for a = 0 to 2 * pi step pi/36
    tline cx, cy, cx + 300 * cos(a), cy + 300 * sin(a), 15
  next
next
tTime = ticks - t0
? "Andy's tline method for thick line took ";tTime;" ms to draw this 15 times."
? "Andy's tline time / MGA Old method time is ";tTime / rtTime
? "Andy's tline time / MGA New method time is ";tTime / ptTime
pause