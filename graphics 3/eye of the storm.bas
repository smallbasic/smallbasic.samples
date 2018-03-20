
' By Rick3137 2016-05-31 Doodlebot2 Eye Of the Storm

 da = .1 ' change of angle
ang = 0  ' Angle
  c = .1 ' circle size
  r = 1  ' radius
 dr = .4 ' change of radius
clr = 0  ' color
for a = 0 to 6000
  x = cos(ang ) * r
  y = sin(ang ) * r
  color clr
  circle xmax/2 + x, ymax/2 + y, c / 2 color clr
  circle xmax/2 + x, ymax/2 + y, c color clr
  circle xmax/2 + x, ymax/2 + y, c * 2 color clr
  circle xmax/2 + x, ymax/2 + y, c * 4 color clr
  clr = clr + .5
  if clr > 16 then 
    clr = 1
  end if
  r = r + dr
  ang = ang + da
  c = c + .01
next
pause
