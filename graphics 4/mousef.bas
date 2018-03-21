
' mouse fun.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-07-03

'Fast Filled Triangle Sub by AndyAmaya
sub filltri(x1, y1, x2, y2, x3, y3)
  local x, y, length, slope1, slope2, slope3
  'triangle coordinates must be ordered: where x1 < x2 < x3
  if x2 < x1 then x = x2 : y = y2 : x2 = x1 : y2 = y1 : x1 = x : y1 = y
  'swap x1, y1, with x3, y3
  if x3 < x1 then x = x3 : y = y3 : x3 = x1 : y3 = y1 : x1 = x : y1 = y
  'swap x2, y2 with x3, y3
  if x3 < x2 then x = x3 : y = y3 : x3 = x2 : y3 = y2 : x2 = x : y2 = y
  if x1 <> x3 then slope1 = (y3 - y1) / (x3 - x1)
  'draw the first half of the triangle
  length = x2 - x1
  if length <> 0 then
    slope2 = (y2 - y1) / (x2 - x1)
    for x = 0 to length
      line int(x + x1), int(x * slope1 + y1), int(x + x1), int(x * slope2 + y1)
    next
  end if
  'draw the second half of the triangle
  y = length * slope1 + y1 : length = x3 - x2
  if length <> 0 then
    slope3 = (y3 - y2) / (x3 - x2)
    for x = 0 To length
      line int(x + x2), int(x * slope1 + y), int(x + x2), int(x * slope3 + y2)
    next
  end if
  line x1, y1, x2, y2
  line x2, y2, x1, y1
  line x2, y2, x3, y3
  line x3, y3, x2, y2
  line x1, y1, x3, y3
  line x3, y3, x1, y1
end

sub drawRat(leftX, topY, width, height, heading)
  local bcX = leftX + .5 * width
  local bcY = topY + .5 * height
  local bR : bR = .5 * .5 * min(width, height) 
  local noseX : noseX = bcX + 2 * bR * cos(rad(heading))
  local noseY : noseY = bcY + 2 * bR * sin(rad(heading))
  local neckX : neckX = bcX + .75 * bR * cos(rad(heading))
  local neckY : neckY = bcY + .75 * bR * sin(rad(heading))
  local tailX : tailX = bcX + 2 * bR * cos(rad(heading + 180))
  local tailY : tailY = bcY + 2 * bR * sin(rad(heading + 180))
  local earLX : earLX = bcX + bR * cos(rad(heading - 30))
  local earLY : earLY = bcY + bR * sin(rad(heading - 30))
  local earRX : earRX = bcX + bR * cos(rad(heading + 30))
  local earRY : earRY = bcY + bR * sin(rad(heading + 30))
  
  circle bcX, bcY, .65 *bR filled
  circle neckX, neckY, bR * .3 filled
  fillTri(noseX, noseY, earLX, earLY, earRX, earRY)
  circle earLX, earLY, bR * .3 filled
  circle earRX, earRY, bR * .3 filled
  
  local wX = .7 * bR * cos(rad(heading - 90 - 20))
  local wY = .7 * bR * sin(rad(heading - 90 - 20))
  line noseX + wX, noseY + wY, noseX - wX, noseY - wY
  wX = .7 * bR * cos(rad(heading - 90 + 20))
  wY = .7 * bR * sin(rad(heading - 90 + 20))
  line noseX + wX, noseY + wY, noseX - wX, noseY- wY
  line bcx, bcy, tailX, tailY
end

w = 230 : h = 230
color 12
pen on
oldmx = 0 : oldmy = 0
color rgb(185,145,125)
while 1
  cls
  ? "Move your mouse..."
  mx = pen(4):my = pen(5)
  dx = mx -oldmx : dy = my -oldmy
  if dx <> 0 then a = deg(atan(dy / dx))
  if dx < 0 then a = a+180
  if a = 0 then a = olda
  drawRat mx-.5*w, my-.5*h, w, h, a
  showpage
  delay 1
  oldmx= mx : oldmy = my 
  if a <> 0 then olda = a
wend
