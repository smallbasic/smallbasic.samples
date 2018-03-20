
'pi roll.bas SmallBASIC 0.12.6 [B+=MGA] 2016-05-21

pie="    3.141592653589793238462643383279502884197169399375105820974944592307816406286"
w = window() : w.setfont(8,"pt",0,0)
cx = xmax / 2 : cy = ymax / 2 : pIndex = 1 : n = 50
while (r * 6) < cy - 80 'the screen scolls when print large fonts near bottom of screen
  n += 10
  pIndex ++
  r = n ^ .6
  a += .33
  x = cx - r * 6 * cos(a)
  y = cy - r * 6 * sin(a)
  color val(mid(pie, pIndex, 1)) + 6
  w.setfont(80 - 1.45 * r , "pt", 0, 0)
  at x, y : ? mid(pie, pIndex, 1)
wend
pause
