
''' Bezier_pen
''
'' with Pen/Mouse
'' for SmallBasic-v0.9.0.3
'' on Win98se, by Ted Clayton

'' references:
''
'' "Learning Mathematics with Micros"
'' by A. Oldknow & D. Smith, p.81
''
'' Sketch.sb, for Pen/Mouse code

? "Pick a line by left-clicking"
? "two points on the screen."
?
? "Then, pick a 3rd point, to"
? "the side of the line.  The"
? "line will rubber-band toward,"
? "but not to, the new point."
?
? "To dynamically rubber-band"
? "the line; left-click-hold,"
? "and move the mouse."
?
? "Uses ''binomial probability"
? "distribution'', a.k.a.,"
? "''Pascal''s Triangle''."
?
? "''q'' to quit"

dim P1(1)   '' end-point #1
dim P2(1)   '' #2
dim Cp(1)   '' control-point
dim Bp(1)   '' Bezier-curve point

pen on 	'' pick 2 points
gosub WaitForPen
P1(0)=pen(4)	'' end-point #1		
P1(1)=pen(5)
circle P1(0), P1(1), 3 color 12
gosub WaitForPen
P2(0)=pen(4)	'' end-point #2
P2(1)=pen(5)
circle P2(0), P2(1), 3 color 10

repeat
  gosub WaitForPen	
  cls
  '' control-point
  Cp(0)=pen(4)
  Cp(1)=pen(5)
  circle P1(0), P1(1), 3 color 12
  circle P2(0), P2(1), 3 color 10
  circle Cp(0), Cp(1), 3 color 9
  pset P1(0), P1(1)
  '' calculate, plot Bezier curve
  '' uses Pascal''s Triangle
  for t=0.05 to 1 step 0.05
    s=1-t
    k1=s*s
    k2=2*s*t
    k3=t*t
    for i=0 to 1
      Bp(i)=k1*P1(i)+k2*Cp(i)+k3*P2(i)
    next i
    line Bp(0), Bp(1)
  next t
  line P2(0), P2(1)
  k=inkey
until k="q"
pen off
end

label WaitForPen
while pen(0)=0
  k=inkey
  if k="q" then end
wend
return'
