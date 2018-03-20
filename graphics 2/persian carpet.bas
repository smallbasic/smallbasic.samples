'Persian Carpet v2.bas for SmallBASIC 0.12.9 (B+=MGA)
'modified from copy from Retrogamecoding link 2016-02-09
' 2017-09-23 mod for brighter colors and centered
' alas, some blank screens but much brighter!

' 2017-09-24 eliminate radial symmetry and most blank screens

REM BASIC Code: Persian Carpet Designs
REM A modification of original concept from Anne Burns

colorborder = 0 : a = 1
xo = (xmax - 512) / 2 : yo = (ymax - 512) / 2
while 1
  CLS
  lft = 1 + xo : rght = 513 + xo : top = 1 + yo: bot = 513 + yo
  cb2 = rnd * 16 \ 1
  LINE lft, top, rght, top, cb2
  LINE lft, bot, rght, bot, cb2
  LINE lft, top, lft, bot, colorborder
  LINE rght, top, rght, bot, colorborder
  DetermineColor lft, rght, top, bot, a
  at 10, 10 : ? "colorboarder = ";colorborder;"  cb 2 = ";cb2;"  a = ";a
  showpage
  pause
  a = a + 1
  if a >= 16 then a = 1 : colorborder += 1
  if colorborder >= 16 then colorborder = 0
wend

rem Determine the color based on function f
sub DetermineColor(lft, rght, top, bot, a)
  local c, middlerow, middlecol
  IF (lft < rght - 2) THEN
    c = f(lft, rght, top, bot, a)
    middlecol = int((lft + rght) / 2)
    middlerow = int((top + bot) / 2)
    LINE lft + 1, middlerow,rght - 1, middlerow, c
    LINE middlecol, top + 1, middlecol, bot - 1, c
    DetermineColor lft, middlecol, top, middlerow, a
    DetermineColor middlecol, rght, top, middlerow, a
    DetermineColor lft, middlecol, middlerow, bot, a
    DetermineColor middlecol, rght, middlerow, bot, a
  else
    exit
  end if
end

func f(lft, rght, top, bot, a)
  local p, b
  p = point(lft, top) + POINT(rght, top) + POINT(lft, bot) + POINT(rght, bot)
  'Try values of b = 4 or b = 7
  b = 60
  f = int(p / b + a) mod 9 + 7
end
