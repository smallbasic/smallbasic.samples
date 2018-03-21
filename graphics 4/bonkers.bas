' cheap bonkers.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-01-07
' from Galileo's Collection, Bonkers is a funky mystery
' but I think it is about colliding particles.
' In this version use spacebar to toggle between clearing 
' screen. The orange balls have recently collided.
n = 10  '<<<<<<<<<<<< feel free to play with this number

clrMode = 1
dim x(n), y(n), dx(n), dy(n), c(n)
for i = 0 to n
  x(i) = xmax/n * i
  y(i) = ymax/n * i
  dx(i) = (rnd*25 +5) * iff(rnd < .5,-1, 1)
  dy(i) = (rnd*25 +5) * iff(rnd < .5,-1, 1)
next

while 1
  k = inkey
  if asc(k) = 32 then clrMode *= -1
  if clrMode < 0 then cls
  for i = 0 to n
    x(i) += dx(i) 
    if x(i) > xmax then dx(i) *= -1 : x(i) = xmax
    if x(i) < 0 then dx(i) *= -1 : x(i) = 0
    y(i) += dy(i) 
    if y(i) > ymax then dy(i) *= -1 : y(i) = ymax 
    if y(i) < 0 then dy(i) *= -1 : y(i) = 0
    if i < n then 
      for j = i + 1 to n
        if sqr((x(i)-x(j))^2 + (y(i)-y(j))^2) < 50 then
          dx(i) *= -1 ': dy(i) *= -1 
          dy(j) *= -1 ': dx(j) *= -1 
          c(i) = 1 : c(j) = 1
        fi
      next
    fi
    for r = 25 to 1 step -1
      if c(i) then
        color rgb(255-5*r,64-2*r,0)
      else
        color rgb(255-10*r,255-10*r,255-10*r)
      fi
      circle x(i), y(i), r filled
    next
    c(i) = 0
  next
  showpage
  delay 10
wend