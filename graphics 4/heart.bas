' Heart drawing.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-02-13

for k = 1 to 7
  cls
  for i = 1 to 50
    if int(rnd*2) then
      color rgb(rand(220, 255), rand(220, 255), rand(220, 255))
    else
      red = rand(60,255)
      color rgb(red, 0, int(.15 * red))
    end if
    drawheart rand(0, xmax), rand(0, ymax), rand(0, 180)/pi, rand(30, 200)
  next
  h = 490/760 * ymax
  while h > 30
    cnt+=1
    if cnt%2 then
      a = 0
      color rgb(160, 20, 30)
      hy = ymax/2 + .6 * h
    else
      a = pi
      color 0
      hy = ymax/2 - .5 * h
    end if
    drawHeart xmax/2, hy ,a,h
    h = h/2  
  wend
  cnt -= 1
  showpage
'  delay 1500
next

a = 127
cls
color rgb(220, 90, 90)
at 10, 10 : ? "One momemt... "
showpage
'delay 10
hmax = 390/760*ymax 
while 1
  red = rnd^2 : green = rnd^2 : blue = rnd^2
  for h = hmax to 15 step -1
    cc = rgb(a+a*sin(red*h*.1), a+a*sin(green*h*.1), a+a*sin(blue*h*.1) ) 
    'color rgb(a+a*sin(red*h*.1), a+a*sin(green*h*.1), a+a*sin(blue*h*.1) )
    color cc
    drawHeart xmax/2, ymax - hmax/3, 0, h
  next
  showpage
  delay 10
wend

func rand(n1, n2) 
  if n1 > n2 then hi = n1 : lo = n2 else hi = n2 : lo = n1
  rand = (rnd * (hi - lo + 1)) \ 1 + lo 
end 
sub drawHeart(x, y, angle, height) 'height below 30 not so good over 300 outgrows height box
  'height x height is approximately the square the heart fits inside
  'x, y is bottom point of upright heart
  local k, r
  k = 3*pi/2 'when angle = 0 then you have standard upright heart
  for r = 0 to height/6
    'circle x + 5*r*cos(k + angle), y + 5*r*sin(k + angle), 3 filled
    circle x + 5*r*cos(k + angle - pi/11), y + 5*r*sin(k + angle - pi/11), r^1.2 filled
    circle x + 5*r*cos(k + angle + pi/11), y + 5*r*sin(k + angle + pi/11), r^1.2 filled
  next 
  'fix bottom point
  for r = -pi/9 to pi/9 step .02
    line x, y, x + .8*height*cos(k + angle + r), y + .8*height*sin(k + angle + r)
  next
end