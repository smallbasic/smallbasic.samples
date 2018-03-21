' Electric Lissajous.bas for SmallBASIC 0.12.8 [B+=MGA] 2017-02-22

randomize timer
sc = min(xmax, ymax)/3
xc = xmax/2
yc = ymax/2

m = 1 : n = 1 : p = 1 : q = 1
while 1
  m = (rnd * 28)\1
  n = q
  p = q
  q = (rnd*28)\1 + 1
  for s = 0 to sc*1.05 step .05*sc
    cls
    color 11
    locate 1, 1: ? " m = ";str(m); "   n = ";str(n);"  p = ";str(p);"  q = ";str(q) 
    lastX = xc : lastY = sc + yc
    for t = 0 to 2*pi*(1 + pi/360) step pi/720
      x = (sc-s)*sin(m*t) + 2*s*sin(p*t) + xc
      y = (sc-s)*cos(n*t) + s*cos(q*t) + yc
      Lightning lastX, lastY, x, y, 30
      lastX = x : lastY = y
    next
    showpage 
  next
  delay 800
wend

sub Lightning(x1,y1,x2,y2,d)
  'Lightning.bas copied from Bpf aurel
  'fixed 2017-02-22
  local mx, my  'local fix stopped the jagged lines
  if d < 5 then 
     line x1,y1,x2,y2,rgb(200,200,230)
  else 
    mx = (x2+x1)/2
    my = (y2+y1)/2
    'with or without??
    'mx += rnd*.5*d  'fixed the line from turning back on itself
    my += (rnd-.5)*d
    Lightning x1,y1,mx,my,d/2
    Lightning x2,y2,mx,my,d/2
  fi
end
