
'Space shooter v3.bas  SmallBASIC 0.12.2 (B+=MGA) 2016-08-13
' designed for 1200+ X 700+ screen size
' some problems in first version solved in sdlBasic version 2
' sdlBasic version 2 also has many new features


'translated and modified from
'space shooter.sdlbas [B+=MGA] 2016-08-10 modified from
' space shooter.bas  SmallBASIC 0.12.2 (B+=MGA) 2016-03-25

randomize
definekey 27, quits
cx = xmax / 2 : cy = ymax / 2 : highScore = "0" : level = 0 : fileName = ""
dim scores(8), star(200, 2)
x = 0 : y = 1 : size = 2

sub quits
  quit = 1
end

func rand(n1, n2)  ' numbers between n1, n2 inclusive, no worries first and second argument
  local hi, lo
  if n1 > n2 then
    hi = n1 : lo = n2
  else
    hi = n2 : lo = n1
  end if
  rand = (rnd * (hi - lo + 1)) \ 1 + lo
end

sub text(x, y, size, s) ' a sub to make translating to SmallBASIC from SdlBasic easier
  'when this sub is used text size is altered for the rest of the run
  local l
  l.w = window() : l.w.setfont(size, "pt", 0, 0)
  at x, y : ? s
  showpage
  'delay 2
end
 
'used to get input the same size and colors as text size for printing 
func textInput(x, y, sz, prompt, back, fore ) 
  'this requires sub text(x, y, size, s)
  local k, rtn, quit
  rect 0, y, xmax, y + 1.2 * sz, back filled
  color fore
  text x, y, sz, prompt
  k = 0 : rtn = "" : quit = 0
  while quit = 0 ' until press enter
    k = asc(inkey)
    if k = 13 then quit = 1
    'while inkey = k : delay 10 : wend
    if k > 31 and k < 127 then
      rtn = rtn + chr(k)
    elif k = 8 or k = 127 ' backspace and delete
      rtn = left(rtn, len(rtn) - 1)
    end if
    rect 0, y, xmax, y + 1.2 * sz, back filled
    color fore
    text x, y, sz, prompt + rtn
  wend
  textInput = rtn
end

sub instructions()
  'global number created here: level
  'global strings created here: fileName, highScore 
  local fore, back, name, lv, lvl
  lvl = 0
  fore = 15 : back = 0
  color fore, back
  text 300, 170, 20, "Hello Captain,"
  name = textInput(300, 200, 20, "Please type your name for the log and enter > ", back, fore)
  fileName = name + ".dat"
  if exist(fileName) then
    open fileName for input as #1
    for i = 1 to 9
      line input #1, hs
      scores(i - 1) = hs
    next
    close #1
  else
    open fileName for output as #1
    for i = 1 to 9
      print #1, str(0)
      scores(i - 1) = str(0)
    next
    close #1
  end if
  text 300, 250, 20, name + ", you have unlimited power for phasers to shoot at targets."
  text 300, 280, 20, "Just lock in and click mouse button, zap... boom!"
  text 300, 310, 20, "Get hit once by a target and the game is over!"
  text 300, 340, 20, "You need to choose a level of play:"
  text 300, 370, 20, "For every increase in level the targets go faster and the"
  text 300, 400, 20, "likely-hood of getting hit by a target increases."
  lvl = 0
  while lvl < 1 or lvl > 9 
    lv = textInput(300, 450, 20, "Enter number key 1 to 9 for your level > ", back, fore)
    lvl = int(lv)
    if lvl < 1 or lvl > 9 then beep
  wend
  highScore = scores(lvl - 1)
  text 300, 500, 20, "Level " + str(lvl) + " chosen, your high score for that level is "+ highScore
  delay 2500
  level = lvl
  cls
end

sub drawspace(moving)
  'uses array star(200, 2), global x=0, y=1, size=2
  local i, c
  for i = 0 to cy
    c = rgb(0, 0, .1 * i + 12)
    line 0, i, xmax, i, c
    line 0, ymax - i, xmax, ymax-i, c
  next
  c = rgb(0, 200, 200)
  for i = 0 to 200
    if moving then
      star(i, x) += star(i, size) ^ .25 
      if star(i, x) > xmax then star(i, x) = -1 * rnd * 20
    end if
    if star(i, size) = 1 then
      pset star(i, x), star(i, y), c
    else
      circle star(i, x), star(i, y), star(i, size) - 1, 1, c filled
    end if
  next
end

sub method3(ex, ey, count)   'from explosions study combine method 1 and 2 = 2 sets of dots
  local max_dot, num_dots, dot_x, dot_y, dot_dx, dot_dy, dot_size, dot_colr, dots, i, angle, shade, counter
  max_dot = 400 : num_dots = 401
  dim dot_x(num_dots), dot_y(num_dots), dot_dx(num_dots), dot_dy(num_dots), dot_size(num_dots), dot_colr(num_dots)
  dim dots(128,50)
  for i = 0 to 127
    dots(i, 0) = ex
    dots(i, 1) = ey
    angle = rnd * 360
    dots(i, 2) = cos(angle)
    dots(i, 3) = sin(angle)
    dots(i, 4) = rand(65, 75)
  next

  for i = 0 to max_dot
    dot_x(i) = ex
    dot_y(i) = ey
    angle = rnd * 2 * pi
    dot_dx(i) = rnd * 95 * cos(angle)
    dot_dy(i) = rnd * 95 * sin(angle)
    dot_size(i) = rnd * 2 + 1
    shade = rnd * 255
    dot_colr(i) = rgb(shade, shade, shade)
  next

  while 1
    drawspace(0)
    counter = counter + 1
    for i = 0 to max_dot
      if dot_x(i) > 0 and dot_x(i) < xmax and dot_y(i) > 0 and dot_y(i) < ymax  then
        counter = counter + 1
        circle dot_x(i), dot_y(i), dot_size(i), 1, dot_colr(i) filled
        dot_x(i) = dot_x(i) + dot_dx(i)
        dot_y(i) = dot_y(i) + dot_dy(i)
      end if
    next
    for i = 0 to 127
      if dots(i, 4) > 0 and dots(i,0) > 0 and dots(i,0) < xmax and dots(i,1) < ymax and dots(i,1) > -100 then
        dots(i, 0) = dots(i, 0) + dots(i, 2) * dots(i, 4)
        dots(i, 1) = dots(i, 1) + dots(i, 3) * dots(i, 4)
        dots(i, 4) = dots(i, 4) - 0.04
        shade = 64 + rnd * 128
        circle dots(i, 0), dots(i, 1), rnd * 7 + 1, 1, rgb(shade, shade, shade) filled
      end if
    next
    showpage
    delay 30
    if counter >= count then
      exit loop
    end if
  wend
end

'main ======================================= main 
'set up stars
for i = 0 to 100
  star(i, x) = rnd * xmax : star(i,y) = rnd * ymax  : star(i, size) = 1
next
for i = 1 to 70
  star(i + 100, x) = rnd * xmax : star(i + 100, y) = rnd * ymax : star(i + 100, size) = 2
next
for i = 1 to 25
  star(i + 170, x) = rnd * xmax : star(i + 170, y) = rnd * ymax : star(i + 170, size) = 3
next
for i = 1 to 5
  star(i + 195, x) = rnd * xmax : star(i + 195, y) = rnd * ymax : star(i + 195, size) = 4
next

'some initializing 
r = .2 : g = .3 : b = .4 : looper = 0 
hits = 0 : active = 0 : xz = 0 : yz = 0 : hit = 0 : targets = 0 : beemer = 0
quit = 0

instructions
pen on
while quit = 0 'quit set to 1 by esc keypress
  cls
  drawspace 1
  'draw target
  looper ++
  if looper mod 100 = 0  then  ' new target
    active = 1 : targets += 1
    side = rand(1, 4)
    select case side
    case 1 'left
      xz = 0 : yz = rand(250, ymax - 250) 
      dx = rand(level, 4 + level) : dy = rand(-3 - level, 3 + level)
    case 2 'right
      xz = xmax : yz = rand(250, ymax - 250)
      dx = rand(-level, -4 - level) : dy = rand(-3 - level, 3 + level)
    case 3 ' top
      xz = rand(250, xmax - 250) : yz = 0 
      dx = rand(-4 - level, 4 + level) : dy = rand(level, 3 + level)
    case 4 'bottom
      xz = rand(250, xmax - 250) : yz = ymax
      dx = rand(-4 - level, 4 + level) : dy = rand(-level, -3 - level)
    end select
    if looper > 1000000 then looper = 0
  else
    if active then
      for rz = 20 to 0 step -5
        if rz mod 2 = 0 then
          circle xz, yz, rz, 1, 12 filled
        else
          circle xz, yz, rz, 1, 15 filled
        end if    
      next
      xz = xz + dx : yz = yz + dy
    end if
  end if
  
  'create craft
  circle cx, cy, 10, 1, rgb(190,40,0) filled
  circle cx, cy, 30, 3/20, rgb(190,150,90) filled
  for light = 1 to 12
    circle cx - 35 + 5 * light + ls, cy, 1, 1, 15 filled
  next
  ls = ls + 1
  if ls > 5 then ls = 0
  
  'create beam sight too slow!!!!!!!!!!!!!!!!
  mx = pen(4) : my = pen(5)
  'if mx > 0 and my > 0 then  ' slow use mouse pointer
  '  color 15
  '  circle mx, my, 5
  '  circle mx, my, 10
  '  circle mx, my, 15
  '  line mx, my - 20, mx, my + 20
  '  line mx - 20, my, mx + 20, my
  'end if
  r +=.2 : g += .005 : b+=.010
  if r > .5 then r=.02
  if g > .5 then g=.005
  if b > .5 then b=.01

  'plasma beamer
  r += .2 : g += .005 : b += .010
  if r > .5 then : r = .02 : end if
  if g > .5 then : g = .005 : end if
  if b > .5 then : b = .01 : end if
  if pen(3) then
    mx = pen(4) : my = pen(5)
    'delay 30
    beemer = 1
    dist = ((mx - cx) ^ 2 +(my - cy) ^ 2) ^ .5
    if dist <> 0 then
      if cx-mx = 0 then
        if my > cy then angle = 90 else angle=270
      else
        angle = deg(atan( (cy-my) / (cx-mx) ) )
        if mx < cx then angle = angle + 180
      end if
    end if
    ra = deg(atan(21 / dist))
    angle1 = angle - ra
    angle2 = angle1 + 2 * ra
    for ray = 1 to dist
      x1 = int(cx + ray * cos(rad(angle1)))
      y1 = int(cy + ray * sin(rad(angle1)))
      x2 = int(cx + ray * cos(rad(angle2)))
      y2 = int(cy + ray * sin(rad(angle2)))
      cc = RGB(127 + 127 * sin(r * ray), 127 + 127 * sin(g * ray), 127 + 127 * sin(b * ray))
      line x1 + 1, y1 + 1, x2, y2, cc
      line x2 + 1, y2 + 1, x1, y1, cc  'get rid of some holes in beam
    next
  end if
  
  'hits
  if abs(mx-xz) < 15 and abs(my-yz) < 15 and beemer = 1 then
    if active then
      hits += 1
      method3(xz, yz, 1500)
      active = 0
      hit = 1
    end if
  end if
  
  if targets <> 0 then
    at 10, 10: ?"   Hits " + str(hits)
    at 10, 30: ?"Targets " + str(targets)
    at 10, 50: ?"Percent " + str( int(100 * hits/targets) )
    at 950, 10: ?"Level " + str(level) + " High Score " + highScore
  end if
  
  'target crashes into ship
  if abs(xz-cx) < 30 and abs(yz - cy) < 30 then ' game over
    circle cx, cy, 60, 1, 15 filled
    showpage
    delay 5
    method3 cx, cy, 3500
    color 14
    text 350, 300, 100, " Game Over!"
    showpage
    delay 2500
    exit loop
  end if
  beemer = 0
  showpage
  delay 1
wend
'update scoring
sc = int(100 * hits / targets) : lv = level - 1
if int( scores(lv) ) < sc then
  scores(lv) = str(sc)
  open fileName for output as #1
  for i = 1 to 9
    print #1, scores(i - 1)
  next
  close #1
end if
pause
