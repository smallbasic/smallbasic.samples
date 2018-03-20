'turtle like bpf 2015-04-17 tomaaz in Yabasic
'
rect 0,0,600,600,0 filled

lenght = 500
angle = 1
x = 50
y = 550
difference = 2
angle_difference = 4681
dc=2
cv1=RGB(255,0,0)
cv2=RGB(0,0,255)

y2 = y - lenght
line x, y, x, y2,cv2
delay 500
lenght = lenght - difference
y = y2
counter = 0
'color_value = 7

while (counter < 62)
   'color 0, color_value, color_value
   a = int (sin (angle * pi / 180) * lenght)
   b = int (cos (angle * pi / 180) * lenght)
   x2 = x + b
   y2 = y + a
   line x, y, x2, y2,cv1

   angle = angle + angle_difference
   lenght = lenght - difference
   a = int (sin (angle * pi / 180) * lenght)
   b = int (cos (angle * pi / 180) * lenght)
   x = x2 - a
   y = y2 + b
   line x2, y2, x, y,cv2
   
   angle = angle + angle_difference
   lenght = lenght - difference
   a = int (sin (angle * pi / 180) * lenght)
   b = int (cos (angle * pi / 180) * lenght)
   x2 = x - b
   y2 = y - a
   line x, y, x2, y2,cv1

   angle = angle + angle_difference
   lenght = lenght - difference
   a = int (sin (angle * pi / 180) * lenght)
   b = int (cos (angle * pi / 180) * lenght)
   x = x2 + a
   y = y2 - b
   line x2, y2, x, y,cv2

   lenght = lenght - difference
   angle = angle + angle_difference
   counter = counter + 1
   'color_value = color_value + 3
   cv = RGB(255-dc,0,dc)
wend
