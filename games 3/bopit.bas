# Magnitude = sqrt32(AccX*AccX + AccY*AccY + AccZ*AccZ);

dim lights(11)

sub init
  local i
  for i = 0 to len(lights) - 1
    lights[i] = false
  next i
end

func orange(vr)
  return rgb(0x9f, 0x80 - 5 * vr, 0)
end  

func green(vr)
  return rgb(0, 0x80 - 4 * vr, 0)
end  

func blue(vr)
  return rgb(0, 0, 255 - 5 * vr)
end  

sub ball(x, y, size, lit, fn)
  local r, c, vr
  local nstep = size / 25

  for r = size to 1 step - nstep
    vr = r * 25 / size
    if (lit) then
      c = call(fn, vr)
    else
      c = 255 - 4 * vr
      c = rgb(c, c, c)
    endif
    circle x, y, r, 1, c filled
  next
end

' outer : orange
' inner : green
' center: blue
sub show
  local x = xmax / 2
  local y = ymax / 2
  local s1 = xmax / 15
  local s2 = s1 * .7
  local s3 = s2 * .7
  local i

  ball(x, y, s1, lights[5], @blue)
  x -= s1 * 2
  ball(x, y, s2, lights[4], @green)
  x -= s2 * 2
  for i = 3 to 0 step - 1
    ball(x, y, s3, lights[i], @orange)
    x -= s1 * 1.1
  next i

  x = xmax / 2 + s1 * 2
  ball(x, y, s2, lights[6], @green)
  x += s2 * 2
  for i = 7 to 10
    ball(x, y, s3, lights[i], @orange)
    x += s1 * 1.1
  next i
end

sub go()
  local i = 0
  local j = 0

  lights[j] = true

  while 1
    cls
    show()
    showpage
    delay 15
    lights[j] = false
    j = (j + 1) mod 11
    lights[j] = true
  wend
end

init()
go()