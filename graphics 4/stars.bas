'remake Star Worlds.bas for SmallBASIC [B+=MGA] 2017-03-29
'using Chris method in Triangles to create what Johnno calls Particle Programs
'and shian's LOCAL method, and new plasma/flasher method 

func rand(n1, n2)
  local l 
  if n1 > n2 then l.hi = n1 : l.lo = n2 else l.hi = n2 : l.lo = n1
  rand = (rnd * (l.hi - l.lo + 1)) \ 1 + l.lo 
end 

func starArr(byref star)
  ' x, y are same as for circle,
  ' rInner is center circle radius
  ' rOuter is the outer most point of star
  ' nPoints is the number of points,
  ' angleOffset = angle offset IN DEGREES, it will be converted to radians in sub
  ' this is to allow us to spin the polygon of n sides
  ' TFfill filled True or False (1 or 0)
  
  'use l. method for tracking what is local
  local l   'p_angle, rad_angle_offset, x1, y1, i, arr
  dim l.arr()
  l.p_angle = rad(360 / star.n)  :  l.rad_angle_offset = rad(star.a - 90)
  l.x1 = star.x + star.ro * cos(l.rad_angle_offset)
  l.y1 = star.y + star.ro * sin(l.rad_angle_offset)
  l.arr << l.x1 : l.arr << l.y1
  for l.i = 0 to star.n - 1
    l.x1 = star.x + star.ri * cos(l.i * l.p_angle + l.rad_angle_offset + .5 * l.p_angle)
    l.y1 = star.y + star.ri * sin(l.i * l.p_angle + l.rad_angle_offset + .5 * l.p_angle)
    l.arr << l.x1 : l.arr << l.y1
    l.x1 = star.x + star.ro * cos((l.i + 1) * l.p_angle + l.rad_angle_offset)
    l.y1 = star.y + star.ro * sin((l.i + 1) * l.p_angle + l.rad_angle_offset)
    l.arr << l.x1 : l.arr << l.y1
  next
  if star.f then drawpoly l.arr filled else drawpoly l.arr
  starArr = l.arr
end

func makeStarProperties
  local p
  p.x = rand(0, xmax)
  p.y = rand(0, ymax)
  p.ri = rand(5, 20)
  p.m = rand(1.2, 3.5)
  p.ro = p.ri * p.m 
  p.n = rand(3, 17)
  p.a = rand(0, 360)
  p.f = rand(0, 1)
  p.dx = rand(-5, 5)
  p.dy = rand(-5, 5)
  p.sp = rand(-10, 10)
  p.z = rand(-3, 3)
  p.c = rgb(rand(128, 255), rand(128, 255), rand(128, 255))
  makeStarProperties = p
end

dim StarWorlds
n = 50
for i = 0 to n
  StarWorlds << makeStarProperties
next

while 1
  cls
  for i = 0 to n
    color StarWorlds(i).c
    istar = starArr(StarWorlds(i))
    StarWorlds(i).c = StarWorlds(i).c * .999
    StarWorlds(i).a = (StarWorlds(i).a + StarWorlds(i).sp) mod 360
    StarWorlds(i).ri = StarWorlds(i).ri + StarWorlds(i).z 
    if StarWorlds(i).ri > 50 then 
      StarWorlds(i).ri = 50 : StarWorlds(i).z = -1 * StarWorlds(i).z
    elif StarWorlds(i).ri < 5
      StarWorlds(i).ri = 5 : StarWorlds(i).z = -1 * StarWorlds(i).z
    end if
    StarWorlds(i).ro = StarWorlds(i).m * StarWorlds(i).ri
    StarWorlds(i).x = (StarWorlds(i).x + StarWorlds(i).dx)
    if StarWorlds(i).x < -50 or StarWorlds(i).x > xmax + 50 then
      StarWorlds(i) = makeStarProperties
    end if
    StarWorlds(i).y = (StarWorlds(i).y + StarWorlds(i).dy)
    if StarWorlds(i).y < -50 or StarWorlds(i).y > ymax + 50 then
      StarWorlds(i) = makeStarProperties
    end if
  next
  showpage
  delay 10
wend