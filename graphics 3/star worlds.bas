
' Star Worlds.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-05-30
' Did you bump your head? Do you see stars swimming all around?

'Thanks Andy Amaya for following code
sub filltri(x1, y1, x2, y2, x3, y3)
  local x, y, length, slope1, slope2, slope3
  'triangle coordinates must be ordered: where x1 < x2 < x3
  if x2 < x1 then x = x2 : y = y2 : x2 = x1 : y2 = y1 : x1 = x : y1 = y
  'swap x1, y1, with x3, y3
  if x3 < x1 then x = x3 : y = y3 : x3 = x1 : y3 = y1 : x1 = x : y1 = y
  'swap x2, y2 with x3, y3
  if x3 < x2 then x = x3 : y = y3 : x3 = x2 : y3 = y2 : x2 = x : y2 = y
  if x1 <> x3 then slope1 = (y3 - y1) / (x3 - x1)
  'draw the first half of the triangle
  length = x2 - x1
  if length <> 0 then
    slope2 = (y2 - y1) / (x2 - x1)
    for x = 0 to length
      line int(x + x1), int(x * slope1 + y1), int(x + x1), int(x * slope2 + y1)
    next
  end if
  'draw the second half of the triangle
  y = length * slope1 + y1 : length = x3 - x2
  if length <> 0 then
    slope3 = (y3 - y2) / (x3 - x2)
    for x = 0 To length
      line int(x + x2), int(x * slope1 + y), int(x + x2), int(x * slope3 + y2)
    next
  end if
  line x1, y1, x2, y2
  line x2, y2, x1, y1
  line x2, y2, x3, y3
  line x3, y3, x2, y2
  line x1, y1, x3, y3
  line x3, y3, x1, y1
end

sub Star(x, y, rInner, rOuter, nPoints, angleOffset, TFfill)
  ' x, y are same as for circle,
  ' rInner is center circle radius
  ' rOuter is the outer most point of star
  ' nPoints is the number of points,
  ' angleOffset = angle offset IN DEGREES, it will be converted to radians in sub
  ' this is to allow us to spin the polygon of n sides
  ' TFfill filled True or False (1 or 0)
  local p_angle, rad_angle_offset, x1, y1, x2, y2, x3, y3, i
  p_angle = rad(360 / nPoints)  :  rad_angle_offset = rad(angleOffset)
  x1 = x + rInner * cos(rad_angle_offset)
  y1 = y + rInner * sin(rad_angle_offset)
  for i = 0 to nPoints - 1
    x2 = x + rOuter * cos(i * p_angle + rad_angle_offset + .5 * p_angle)
    y2 = y + rOuter * sin(i * p_angle + rad_angle_offset + .5 * p_angle)
    x3 = x + rInner * cos((i + 1) * p_angle + rad_angle_offset)
    y3 = y + rInner * sin((i + 1) * p_angle + rad_angle_offset)
    if TFfill then
      filltri x1, y1, x2, y2, x3, y3
    else
      line x1, y1, x2, y2
      line x2, y2, x3, y3
    end if
    x1 = x3 : y1 = y3
  next
  if TFfill then circle x, y, rInner filled  
end

'handy.bas ''''''''''''''''''
func rand(n1, n2) 
  local hi, lo
  if n1 > n2 then hi = n1 : lo = n2 else hi = n2 : lo = n1
  rand = (rnd * (hi - lo + 1)) \ 1 + lo 
end 
def rdir = iff(rnd < .5, -1, 1)
func rclr 'set a rand color fairly bright 
  local test
  test = rgb( rand(255, 64) * rand(0, 1), rand(255, 64) * rand(0, 1), rand(255, 64) * rand(0, 1) ) 
  if test then rclr = test else rclr = 15
end
sub ink(r,g,b)
  color rgb(r, g, b)
end
sub hue(number)
  color number
end
''''''''''''''''
sub newStarSystem
  if fillTF then ns = rand(15, 100) else ns = rand(30, 300)
  dim x(ns), y(ns), dx(ns), dy(ns), ri(ns), ro(ns), p(ns), c(ns), a(ns), da(ns)
  for i = 0 to ns-1 
    x(i) = rand(0, xmax)       :  y(i) = rand(0, ymax)
    dx(i) = rdir * rand(1, 5)  : dy(i) = rdir * rand(1, 5)
    a(i) = rand(1,360)         : da(i) = rand(1,10) * rdir()
    p(i) = rand(3, 12)         :  c(i) = rclr
  next
  ri(0) = rand(20, 40)         : ro(0) = rand(1, 5) * ri(0) + ri(0)
  for i = 1 to 4
    ri(i) = rand(10, .5 * ri(0))    : ro(i) = rand(1, 5) * ri(i) + ri(i)
  next
  for i = 5 to ns-1
    ri(i) = rand(1, .25 * ri(0))    : ro(i) = rand(1, 5) * ri(i) + ri(i)
  next
end sub

'=================================================  main
label restart
newStarSystem
while 1
    cls
    k = inkey
    if len(k) then 
       if k = "f" then fillTF = 1 - fillTF 
       goto restart
    end if
    for i = 0 to ns - 1
      hue c(i)
      Star x(i), y(i), ri(i), ro(i), p(i), a(i), fillTF
      x(i) = x(i) + dx(i)
      if x(i) < -10 then
        dx(i) = dx(i) * -1 : x(i) = -9
      elif x(i) > xmax + 10 
        dx(i) = dx(i) * -1 : x(i) = xmax + 9
      end if
      y(i) = y(i) + dy(i)
      if y(i) < -10 then
      dy(i) = dy(i) * -1 : y(i) = -9
      elseif y(i) > ymax + 10 then   ' <=== ha! this is leftover from sdlbasic and doesn't seem to cause SB any problem
        dy(i) = dy(i) * -1 : y(i) = ymax + 9
      end if
      a(i) = a(i) + da(i)
      a(i) = a(i) mod 360
    next
    hue 10 : ?" ((: f toggles fill, any starts new screen, there is no esc :))"
    showpage
    delay 10
wend

