
' Psychedelic Star Swirl.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-03-03
' from Psychodelic Swirl for Naalaa [B+=MGA] 2017-03-02
' extreme modification of Rick's Swirl there

cx = xmax / 2 : cy = ymax / 2 : StartAngle = 0
clr = 1 : r = rnd : g = rnd : b = rnd

while 1
  cls 
  Bang
  showpage
'  delay 450
  StartAngle = StartAngle - pi/18
wend
 
sub Bang()
  angle = StartAngle
  size = .1 : radius = .1 : ds = .1
  while radius < 400
    x = cos(angle) * radius
    y = sin(angle) * radius
    For r = size to 1 step -14
      chColor 
      star cx + x, cy + y, r/2.7, r, 7 ,angle
    Next
    angle = angle + 41.0
    radius = radius + 1.0
    size = size + ds
    ds = ds + 0.0001
  wend
end

sub chColor()
  clr = clr + .8
  color rgb(127+127*sin(r*clr), 127+127*sin(g*clr), 127+127*sin(b*clr))
  if clr > 10000 then r = rnd : g = rnd : b = rnd : clr = 0
end

 sub star( x, y, rInner, rOuter, nPoints, angleOffset)
  ' x, y are same as for circle,
  ' rInner is center circle radius
  ' rOuter is the outer most point of star
  ' nPoints is the number of points,
  ' angleOffset = angle offset IN DEGREES, it will be converted to radians in sub
  ' this is to allow us to spin the polygon of n sides
  pAngle = RAD(360 / nPoints)  :  radAngleOffset = RAD(angleOffset)
  x1 = x + rInner * cos(radAngleOffset)
  y1 = y + rInner * sin(radAngleOffset)
  for i = 0 to nPoints - 1
    x2 = x + rOuter * cos(i * pAngle + radAngleOffset + .5 * pAngle)
    y2 = y + rOuter * sin(i * pAngle + radAngleOffset + .5 * pAngle)
    x3 = x + rInner * cos((i + 1) * pAngle + radAngleOffset)
    y3 = y + rInner * sin((i + 1) * pAngle + radAngleOffset)
    line x1, y1, x2, y2
    line x2, y2, x3, y3
    x1 = x3 : y1 = y3
  next
end sub
