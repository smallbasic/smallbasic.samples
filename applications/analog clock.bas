
'rem Analog clock.bas SmallBASIC 0.12.2 update Code Library example
'rem 2016-01-30 [B+=MGA]

' center
cx = xmax/2
cy = ymax/2

' default radius
if xmax>ymax then
  r  = cy * 0.9
  er = cy * .95
else
  r  = cx * 0.9
  er = cx * .95
end if

w2 = txtw("99999")
tr = r * 0.8
ir = tr - w2/2
hr = ir * 0.6
mr = ir * 0.7
sr = ir * 0.8

' display loop
while 1

color 0,1:cls
' draw frame
circle cx, cy, er, 1, rgb(255,235,125)  filled
circle cx, cy, er-5 color 15
circle cx, cy,  r color 0 filled
circle cx, cy,  r+5 color 15

' draw hours
color 15,4
  for i=1 to 12
    s  = ltrim(str(i))
    sw = txtw(s): sh = txth(s)
    sa = i * (2*PI)/12
    dx = tr * sin(sa)
    dy = tr * cos(sa)
    x = cx+dx: y = cy-dy
    circle x, y, w2 color 4 filled
    at x-sw/2, y-sh/2
    print s;
  next i
  ' minute ticks
  for j=1 to 60
    msa = j * (2*PI)/60
    mdx = (mr+5) * sin(msa)
    mdy = (mr+5) * cos(msa)
    mx = cx+mdx
    my = cy-mdy
    if j mod 5=0 then circle mx, my, 4,1,13 filled  else circle mx, my, 2,1,9 filled
  next
  start = timer
  timehms start, hour, mint, ssec
  
  hours = hour+(mint/60)
  if ( hours > 12 ) then hours -= 12
  
  ha  = hours * (2*PI)/12
  ma  = mint  * (2*PI)/60
  sa  = ssec  * (2*PI)/60
  
  color 15, 0
  at cx-.5*(txtw(time)), cy-.17*r
  print time;
  
  draw_arrow sa, sr, 7
  draw_arrow ma, mr, 9
  draw_arrow ha, hr, 12
  
  showpage
  while start - timer = 0: delay 20: wend
wend
end

sub draw_arrow(a, r, c)
  local cr=10  
  color c
  circle cx,cy,cr filled
  dx = r * cos(a-pi/2)
  dy = r * sin(a-pi/2)
  line cx, cy, cx+dx, cy+dy
  line cx+cr,cy,cx+dx,cy+dy
  line cx-cr,cy,cx+dx,cy+dy
  line cx,cy+cr,cx+dx,cy+dy
  line cx,cy-cr,cx+dx,cy+dy
  circle cx,cy,2,1,0 filled
  circle cx,cy,cr-2,1,0
end
