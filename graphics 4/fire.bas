' flame on.bas SmallBASIC 0.12.9 (B+=MGA) 2017-11-22

xxmax = 140 : yymax = 55  'pixels too slow 
xstep = xmax/xxmax : ystep = ymax/yymax
dim p(300)  'pallette
for i = 1 to 100
  fr = 240*i/100 + 15
  p(i) = rgb(fr, 0, 0)
  p(i+100) = rgb(255, fr, 0)
  p(i+200) = rgb(255, 255, fr)
next
dim f(xxmax, yymax) 'fire array and seed
for x = 0 to xxmax
  f(x, yymax-1) = int(rnd*2)*300
  f(x, yymax) = 300
next
while 1  'main fire
  for x = 1 to xxmax-1 'shift fire seed a bit
    r = rnd
    if r < .15 then 
      f(x, yymax-1) = f(x-1, yymax-1)
    elif r < .3 then
      f(x, yymax-1) = f(x+1, yymax-1)
    elif r < .35 then
      f(x, yymax-1) = int(rnd*2)*300
    end if
  next
  for y = 0 to yymax-2  'fire based literally on 4 pixels below it like cellular automata
    for x = 1 to xxmax-1
      f(x, y) = max( (f(x-1, y+1) + f(x, y+1) +f(x+1, y+1) +f(x-1, y+2) )/4 - 7, 0)
      rect x*xstep, y*ystep, step xstep+1, ystep+1, p(f(x, y)) filled
    next
  next
  showpage
  delay 10
wend