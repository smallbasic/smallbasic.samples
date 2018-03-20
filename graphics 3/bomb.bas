
'bomb.bas for SmallBASIC 0.12.2 [B+=MGA] 2016-05-09
'from explosion study

max_particles = 1000
dim dots(max_particles)
air_resistance = .95   'multiplicative factor
gravity = .25          'additive factor

sub NewDot(i)
  local angle
  angle = rnd * 2 * pi
  dots(i).x = xmax / 2 + rnd * 30 * cos(angle)
  dots(i).y = ymax / 2 + rnd * 30 * sin(angle)
  dots(i).dx = rnd * 45 * cos(angle)
  dots(i).dy = rnd * 45 * sin(angle)
  dots(i).size = rnd * 7
  dots(i).colr = rgb(10 + rnd * 100, 5 + rnd * 50, 3 + rnd * 25)
  dots(i).tf = (rnd * 2) \ 1
end

sub DrawSky
  local i
  for i = 0 to ymax / 2
    line 0, i step  xmax, 0, rgb(0, 0, 95 * i \ (ymax / 2) + 160)
  next
end

sub DrawBomb
  local i, x1, y1, rad_angle, cx, cy, radius, angle
  cx = xmax / 2 : cy = ymax / 2 - 70 : radius = 10
  
  for i = 60 to 0 step - 1 'main body
    circle cx, ymax / 2, i, 1, rgb(240 - 4 * i, 180 - 3 * i, 120 - 2 * i) filled 'brown round
  next

  for angle = 0 to 180 'fuse shaft
    rad_angle = rad(angle)
    x1 = cx + radius * cos(rad_angle)
    y1 = cy + radius *.25 * sin(rad_angle)
    line x1, y1 step 0, 20, rgb(127 + 127 * cos(rad_angle), 127 + 127 * cos(rad_angle), 127 + 127*cos(rad_angle))
  next
  
  circle cx, cy, radius, .25, 0 filled 'fuse shaft cover
end 

sub DrawFuse(length)
  local i, x1, x2, y1, y2, rad_angle, cx, cy, rn
  
  cx = xmax / 2 : cy = ymax / 2 - 70
  if length <= 0 then exit sub
  rect cx, cy - (5 + 2 * length) step 2, 5, 14 filled
  circle cx, cy - (1 + 2 * length), 2, 1, 14 filled
  rn = (rnd * 5) \ 1 + 3
  for i=1 to rn
    rad_angle = rnd * pi + pi
    x1 = cx + 7 * cos(rad_angle) : x2 = cx + 14 * cos(rad_angle)
    y1 = cy - (1 + 2 * length) + 9 * sin(rad_angle) : y2 =cy - (1 + 2 * length) + (rnd * 13 + 9) * sin(rad_angle)
    line x1, y1, x2, y2, 15 
  next
  for i = 1 to length
    rad_angle = rnd * 2 * pi
    x1 = 3 * cos(rad_angle)
    y1 = 3 * .25 * sin(rad_angle)
    line cx, cy - 2 * i step x1, y1, rgb(rnd * 65 + 190, rnd * 65 + 190, rnd * 20 + 235)
  next
end

sub DrawGround
  local i
  for i = ymax/2 to ymax
    line 0, i step  xmax, 0, rgb(0, 160 - 96 * (i - ymax / 2) \ (ymax / 2) , 0)
  next
end
 
while 1 'blowup again
  for i = 1 to 100
    NewDot(i)
  next
  rounds = 100
  for i = 12 to 0 step -1
    cls
    DrawSky
    DrawGround
    DrawBomb
    DrawFuse i
    showpage
    if i = 0 then delay rnd * 3000 else delay 100
  next
  color 15, 15
  cls
  showpage
  delay 20
  for loop_count = 0 to 150
    DrawSky
    DrawGround
    if loop_count < 4 then 
      brown = rgb(64 - 8 * loop_count , 40 - 4 * loop_count, 32 - 4 * loop_count) 
      if loop_count < 8 then circle xmax/2, ymax/2, 30 * (1-loop_count*.25), 1, brown filled
    fi
    for i = 1 to rounds
      dots(i).x += dots(i).dx
      dots(i).y += dots(i).dy
      if rnd < .2 and rounds> 10 and dots(i).y > ymax / 2 then dots(i).dx = 0 : dots(i).dy = 0
      dots(i).dx *= air_resistance
      if dots(i).dy <> 0 then dots(i).dy = air_resistance * dots(i).dy + .4 'air resistance and gravity
      if dots(i).TF then 
        rect dots(i).x, dots(i).y step dots(i).size, dots(i).size, dots(i).colr filled
      else
        circle dots(i).x, dots(i).y, dots(i).size/2, 1, dots(i).colr filled
      fi
    next
    if rounds < max_particles then
      for i = 1 to 100
        NewDot(rounds + i)
      next
      rounds += 100
    end if
    color 0 : locate 0,0 : ? loop_count
    showpage
    delay 1
  next
wend
