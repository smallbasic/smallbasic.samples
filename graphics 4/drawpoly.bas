option predef antialias off
' DRAWPOLY demo.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-03-24

sub regPoly(x, y, r, nPoints, angleOffset, fillTF)
  ' x, y are same as for circle,
  ' r is radius to points
  ' nPoints is the number of points,
  ' angleOffset = angle offset IN DEGREES, it will be converted to radians in sub
  ' this is to allow us to spin the polygon of n sides
  local p_angle, rad_angle_offset, x1, x2, y1, y2, i, arr
  p_angle = rad(360 / nPoints)  :  rad_angle_offset = rad(angleOffset)
  dim arr(2*nPoints+1)
  for i = 0 to nPoints
    x1 = x + r * cos(i * p_angle + rad_angle_offset)
    y1 = y + r * sin(i * p_angle + rad_angle_offset)
    arr(2*i) = x1
    arr(2*i + 1) = y1
  next
  if fillTF then drawpoly arr filled else drawpoly arr
end

cx = xmax/2 : cy = ymax/2 :
'test regPoly fillTF = 1, show spin potential
while asc(inkey) <> 32
  cls
  for i = 14 to 3 step -1
    color i
    regPoly cx, cy, i*20, i, a, 1
  next 
  color 15
  locate 1,1 : ? "Test regPoly TFfill = 1, press spacebar for next test."
  showpage
  a = a + 1
wend

'test regPoly fillTF = 0
 d = 1 : m = .1 :  n = 3 
while 1
  cls
  xo = 0 : yo = 0 : a = 0
  r1 = 20 : stepper = 60
  for i = 0 to 720 step stepper
    color rgb(255*i/720, 0, 128 - 128*i/720)
    for j = 0 to 20
      regPoly cx - 360 + xo , cy - 180 + yo, r1 + j, n, 0, 0
      regPoly cx - 359 + xo , cy - 180 + yo, r1 + j, n, 0, 0  'dang the holes!
      regPoly cx - 360 + xo , cy - 181 + yo, r1 + j, n, 0, 0  'dang the holes!
      regPoly cx - 361 + xo , cy - 181 + yo, r1 + j, n, 0, 0  'dang the holes!
    next
    xo = xo + stepper * m : yo = yo + stepper * m/2
    if i < 360 then r1 = r1 + stepper else r1 = r1 - stepper
  next
  showpage
  m = m + .1 * d
  if m > 1 then d = d * -1
  if m <= 0 then m = .1 : d = 1 : n = n + 1
  if n >= 15 then n = 3
wend
