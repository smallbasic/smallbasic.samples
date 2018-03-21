'another look at doodlebot.bas SmallBASIC 0.12.6 [B+=MGA] 2016-05-17
' inspired by Rick's doodlebot!

sub recursive(size) 
  local i 'x, y, angle need to be global
  for i = 1 to 3
    x2 = x + cos(angle) * size
    y2 = y - sin(angle) * size
    line x, y, x2, y2
    x = x2 : y = y2
    angle += A120
    if size > 15 then recursive size / 2  
  next
end

const A120 = 2 * pi / 3 : x = xmax / 2 : y = ymax / 2
start = min( (xmax - 20) / 2, (ymax - 20) / 2  )
? "press any to quit..."
while len(inkey) = 0
  colormode ++ : colormode = colormode % 6
  for i = 1 to 12
    recursive start 
    angle  = i * pi / 6
    if colormode <= 2 then 
      color (rnd * 15) \ 1 + 1
    else
      select case (i mod 4)
      case 0 : color 9
      case 1 : color 14
      case 2 : color 12
      case 3 : color 11
      end select
    fi
    showpage
'   delay 24
  next
wend