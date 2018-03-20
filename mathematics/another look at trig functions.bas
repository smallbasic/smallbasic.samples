
' Another look at Trig functions.bas  SmallBASIC 0.12.2 [B+=MGA] 2016-05-01
' inspired by PeterMaria's simple code for Atan2 on Aurels' forum BasicPro
' 2017-09-23 Modified to run again on Android

' Here is another effort in a continuing series to demystify Trig functions:

' Move your mouse around the center point of the screen and see the right triangles
' created with the mouse and a horizontal line from the center
' see all the parts of the triangle expressed in numbers:
' angles to the horizontal line, lengths of the sides and hypotenuse of the right
' and the COS, SIN and TAN ratios

sub ThickArc(xCenter, yCenter, arcRadius, dAngleStart, dAngleEnd, rThick)
  local rAngle, rAngleStart, rAngleEnd, x1, y1, Stepper
  'draws an Arc with center at xCenter, yCenter, radius from center is arcRadius

  'for SmallBASIC angle 0 degrees is due East and angle increases clockwise towards South

  'THIS SUB IS SETUP TO DRAW AN ARC IN CLOCKWISE DIRECTION

  'dAngleStart is where to start Angle in degrees
  ' so make the dAngleStart the first ray clockwise from 0 degrees that starts angle drawing clockwise

  'dAngleEnd is where the arc ends going clockwise with positive degrees
  ' so if the arc end goes past 0 degrees clockwise from dAngleStart
  '  express the end angle as 360 + angle

  'rThick is the radius of the many,many tiny circles this will draw to make the arc thick
  ' so if rThick = 2 the circles will have a radius of 2 pixels and arc will be 4 pixels thick
  if arcRadius < 1 then pset xCenter, yCenter : exit func
  rAngleStart = rad(dAngleStart) : rAngleEnd = rad(dAngleEnd)
  if int(rthick) = 0 then Stepper = 1 / (arcRadius*pi) else Stepper = rThick / (arcRadius * pi / 2)
  for rAngle = rAngleStart to rAngleEnd step Stepper
    x1 = arcRadius * cos(rAngle) : y1 = arcRadius * sin(rAngle)
    if int(rThick) < 1 then
      pset xCenter + x1, yCenter + y1
    else
      circle xCenter + x1, yCenter + y1, rThick filled
    fi
  next
end

sub ThickLine(x1, y1, x2, y2, rThick)
  local length, stepx, stepy, dx, dy, i

  'x1,y1 is one endpoint of line
  'x2,y2 is the other endpoint of the line
  'rThick is the radius of the tiny circles that will be drawn
  '   from one end point to the other to create the thick line
  'Yes, the line will then extend beyond the endpoints with circular ends.

  stepx = x2 - x1
  stepy = y2 - y1
  length = (stepx ^ 2 + stepy ^ 2) ^.5
  if length then
    dx = stepx / length : dy = stepy / length
    for i=0 to length
      circle x1 + dx * i, y1 + dy * i, rThick filled
    next
  end if
end

'============================== Main
const thick = 2
const arc_radius = 100
const hor_color = rgb(30,30,30)
const sin_color = rgb(0,0,255)
const cos_color = rgb(255,0,0)
const hyp_color = rgb(0,192,0)
const ang_color = rgb(255,255,0)
const white = rgb(255,255,255)
cx = xmax / 2 : cy = ymax / 2

while 1
  cls

  'draw horizontal through center of screen
  line 0, cy, xmax, cy, hor_color

  'get mouse
  mx = pen(4) : my = pen(5)   'get mouse location

  'draw our Color Coded Trig Triangle
  color cos_color
  ThickLine cx, cy, mx, cy, thick
  color sin_color
  ThickLine mx, cy, mx, my, thick
  color hyp_color
  ThickLine cx, cy, mx, my, thick

  stepx = abs(cx - mx) : stepy = abs(cy - my)
  hyp = ( (stepx ^ 2 + stepy ^ 2) ^.5 )\1

  'to draw angle need to do some math
  'dAng = mouse angle to 0 degrees due East
  ' other Angles:  StartA, EndA and reportA are for the Trig Ratios of triangle
  dAng = ( deg(atan( (my - cy) / (mx - cx) ) )+.5 ) \ 1
  if mx < cx then dAng = dAng + 180
  if my < cy and mx > cx then dAng = dAng + 360
  if dAng <= 90 then
    startA = 0 : endA = dAng : reportA = dAng
  elif dAng <= 180
    startA = dAng : endA = 180 : reportA = 90 - (dAng - 90)
  elif dAng <= 270
    startA = 180 : endA = dAng : reportA = dAng - 180
  elif dAng <= 360
    startA = dAng : endA = 360 : reportA = 90 - (dAng - 270)
  fi
  color ang_color
  ThickArc cx, cy, arc_radius, startA, endA, thick

  'report all numbers color coded
  color ang_color
  locate 0, 0 : ? "yellow Angle (degrees) ~ "; reportA
  color white
  locate 2, 0 : ? "Lengths:"
  color Hyp_Color
  locate 3, 0 : ? "green Hyp ~ "; hyp
  color SIN_Color
  locate 4, 0 : ? " blue Opp ~ "; stepy \ 1
  color COS_Color
  locate 5, 0 : ? "  red Adj ~ "; stepx \ 1
  color white
  locate 7, 0 : ? "Ratios: (if no division by 0)"
  if hyp <> 0 then
    color COS_Color
    locate 8, 0 : ? "COS = Adj ";
    color Hyp_Color
    ? "/ Hyp ";
    color white
    ? "~ "; left(str(stepx / hyp), 6)
    color SIN_Color
    locate 9, 0 : ? "SIN = Opp ";
    color Hyp_Color
    ? "/ Hyp ";
    color white
    ? "~ "; left(str(stepy / hyp), 6)
  fi
  if stepx <> 0 then
    locate 10, 0 : ? "TAN = ";
    color SIN_Color
    ? "Opp ";
    color COS_Color
    ? "/ Adj ";
    color white
    ? "~ "; left(str(stepy / stepx), 6)
  fi
  showpage
  delay 100
wend

