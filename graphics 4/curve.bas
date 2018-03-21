
' Morph Curve on Plasma.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-04-11
'from SpecBAS version Paul Dunn Dec 2, 2015 
'https://www.youtube.com/watch?v=j2rmBRLEVms
' mods draw lines segments with drawpoly, add plasma, play with numbers

pts = 1200 : interps = 30
dim p(pts + 1, 1), q(pts + 1, 1), s(pts + 1, 1), i(interps)
l = 0 : cx = xmax/2 : cy = ymax/2 : sc = cy*.5 : st = 2*pi/pts
for n = 1 to interps
  i(n) = sin(n/interps*(pi/2))
next
while 1
  resetPlasma
  n = int(rnd*75) + 2 : m = int(rnd*500) - 250 : c = 0 
  for t = 0 to 2*pi step st
    q(c, 0) = cx + sc*(cos(t) + cos(n*t)/2 + sin(m*t)/3)
    q(c, 1) = cy + sc*(sin(t) + sin(n*t)/2 + cos(m*t)/3)
    setPlasma
    if t > 0 then pline lastx, lasty, q(c, 0), q(c, 1), 10
    lastx = q(c, 0) : lasty = q(c, 1) 
    c += 1
  next
  q(c, 0) = q(0, 0) : q(c, 1) = q(0, 1)
  if l = 0 then 
    'drawpoly q 
    l += 1
    showpage 
    'delay 2000
  else
    for t = 1 to interps
      cls
      for n = 0 to pts 
        s(n, 0) = q(n, 0) * i(t) + p(n, 0) *(1 - i(t))
        s(n, 1) = q(n, 1) * i(t) + p(n, 1) *(1 - i(t))
        setPlasma
        if n > 0 then pline lastx, lasty, s(n, 0), s(n, 1), 10
        lastx = s(n, 0) : lasty = s(n, 1) 
      next
      s(n, 0) = s(0, 0) 
      s(n, 1) = s(0, 1)
      'drawpoly s
      showpage 
      'delay 40  
    next
  fi
  p = q
  'drawpoly p
  showpage
  delay 3000
wend

'fast thick line!!!
sub pline(x1, y1, x2, y2, thick) 'this draws a little rectangle
  local arr, r, dx, dy, perpA1, perpA2
  dim arr()
  r = thick/2
  dx = x2 - x1
  dy = y2 - y1
  perpA1 = atan2(dy, dx) + pi/2
  perpA2 = perpA1 - pi
  arr << x1 + r * cos(perpA1) 'corner 1
  arr << y1 + r * sin(perpA1) 
  arr << x2 + r * cos(perpA1) 'corner 2
  arr << y2 + r * sin(perpA1) 
  arr << x2 + r * cos(perpA2) 'corner 3
  arr << y2 + r * sin(perpA2) 
  arr << x1 + r * cos(perpA2) 'corner 4
  arr << y1 + r * sin(perpA2)
  arr << x1 + r * cos(perpA1) 'back to first corner
  arr << y1 + r * sin(perpA1)
  drawpoly arr 'filled   'filled or not ?
end

sub resetPlasma() 'all globals
    plasmaR = rnd ^ 2 : plasmaG = rnd ^ 2 : plasmaB = rnd ^ 2 : plasmaN = 0
end

sub setPlasma() 'all globals
    plasmaN += .37
    color rgb(120+84*sin(plasmaR*plasmaN), 120+84*sin(plasmaG*plasmaN), 120+84*sin(plasmaB*plasmaN))
end
