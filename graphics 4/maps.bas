'City Maps.bas for SmallBASIC 0.12.9 (B+=MGA) 2017-11-21
'mod of Chris mod of one-liner, now with button mod
'some map reading music?
'  https://www.youtube.com/watch?v=tv3qoIy5V9Q

maxX = 1100 : maxY = 700 : j = 128 : jj = 15 : m = 5
px = 10 : dpy = 60 : xo = 150 : py = dpy : c = 3 : dpy1 = 20
color 15, 0 : at 35, 30 : ? "CITY MAPS"
while py < 6 * dpy
  for i = 1 to 15
    rect px + i, py + i, 150 - i, py + dpy - i, rgb(15 * i, 15 * i, 15 * i) filled
  next
  color  0, RGB(225, 225, 225)
  at px + 30, py + 20
  ? mid("color   zoom in zoom outjj minusjj plus  ", 8 * py / dpy - 7, 8)
  py += dpy
wend
showpage
while 1
  t = ticks
  while ticks - t < 500 'wait .5 sec for mouse click
    if pen(3) = 1 then 
      my = pen(5) : delay 100 'to avoid multi-click results
      if dpy < my and my < 2 * dpy then
        c= rgb(100 + rnd * 154, 100 + rnd * 154, 100 + rnd * 154)
      elif 2 * dpy < my and my < 3 * dpy 
        if m + 1 < 11 then m += 1      
      elif 3 * dpy < my and my < 4 * dpy
        if m-1 > 0 then m -= 1 
      elif 4 * dpy < my and my < 5 * dpy
        jj = max(jj - 5, 3)
      elif 5 * dpy < my and my < 6 * dpy   
        jj += 5
      fi
      my = 0
      exit loop
    fi
  wend
  X = maxX / m : Y = maxY / m
  rect 150, 0, maxX + 150, maxY, c filled
  for yy = 0 to Y
    for xx = 0 to X
      if (xx  XOR yy XOR j) MOD jj = 0 then
        rect m * xx + xo, m * yy step m, m, 0 filled
      end if
    next
  next
  rect 10, 240 + 8 * dpy1, 150, 240 + 11 * dpy, 0 filled
  color 7, 0
  at px, 240 + 7 * dpy1  : ? "STATUS:"
  at px, 240 + 8 * dpy1  : ? "  zoom = ";m
  at px, 240 + 9 * dpy1  : ? " j Mod = ";j
  at px, 240 + 10 * dpy1 : ? "jj Mod = ";jj
  showpage
'  delay 
  j = (j + 1) mod 255
wend
