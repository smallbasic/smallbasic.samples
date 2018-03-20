
'Ellipse arc length estimations.bas  SmallBASIC 0.12.2 [B+=MGA] 2016-03-18
'checked with circle (both radii are equal)
'checked with very gross estimates on ellipse (triangle hypotenuse)

cx=xmax\2:cy=ymax\2

'plug in your own numbers degrees and 2 radius
degrees=90  '<======
r1=500      '<======
r2=100      '<======

major=Max(r1,r2)
minor=Min(r1,r2)
line cx,cy,cx+major,cy,7
line cx,cy,cx,cy+minor,7
for a=0 to 360 step 360/100  'here is our ellipse along x axis
  x=major*cos(rad(a))
  y=minor*sin(rad(a))
  pset cx+x,cy+y,12
next
for a=0 to degrees step 360/1000 'here is section we will estimate
  x=major*cos(rad(a))
  y=minor*sin(rad(a))
  pset cx+x,cy+y,9
next
'well that looks right!

for power=1 to 6  'powers above 6 and my computer breaks a sweat and stalls
  stepper=360/10^power
  totaldist=0
  for a=0 to degrees step stepper
    if a=0 then
      x1=major*cos(rad(a))
      y1=minor*sin(rad(a))
    else
      x2=major*cos(rad(a))
      y2=minor*sin(rad(a))
      pdist=((x1-x2)^2+(y1-y2)^2)^.5
      totaldist=totaldist+pdist
      x1=x2
      y1=y2
    end if
  next
  ? "arc length of 0 to ";degrees;" degrees Major: ";major;" and minor: ";minor;" is ";totaldist;" for 360/10^";power;" increments."
next
pause
