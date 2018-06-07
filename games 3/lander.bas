' Lander update.bas SmallBASIC 0.12.11 (B+=MGA) 2018-06-01

'modified code from my 2nd mod of:
'Lander mod 2.txt for JB v2 B+ 2018-05-29 big mod of
'Lander by Carl mod Rod mod B+.txt for JB v2 started 2018-05-26
'where I rewired controls and changed physics of Lander Model.

'This will further depart from Carls's original by hand drawing Lander
'at different angles instead of using sprites and, alas, landscape will
'have to be updated each frame because there is no drawing on top of images
'in SmallBASIC.

' INSTRUCTIONS:
   'Use the left or right arrow keys to rotate Lander left or right.
   'Use the up arrow for thruster burst. These moves cost fuel!
   'The Fuel Gage is Red Horizontal line below landscape.
   'The fuel level is Yellow.
   
   'You must make a VERY gentle and level landing 
   'on one of the flat areas!
   
   'Horizontal location, speed in green.
   '  Vertical location, speed in blue


definekey 0xFF04, moveLeft   'press left arrow rotate craft
definekey 0xFF05, moveRight  'press right arrow, rotate craft
definekey 0xFF09, moveUp     'press up arrow, for forward thrust
definekey 27, quit           'press esc to quit

const d2r = pi/180

'stars
ns = 125
dim sx(ns), sy(ns), sr(ns), sc(ns)
for i = 0 to ns
 sx(i) = rnd * xmax
 sy(i) = rnd * ymax
 r = rnd
 if r < .8 then
   sr(i) = 1
 elif r < .95
   sr(i) = 2
 else
   sr(i) = 3
 fi
 sc(i) = rgb(rnd*74 + 180, rnd*74 + 180, rnd*74 + 180)
next

' ground profile with flat zones for landing
dim terraH(xmax), terraC(xmax)
rate1 = rnd / (rnd * 10 + 15)
rate2 = rnd / (rnd * 5 + 5)
for x = 0 to xmax
 if x > 0 and rnd < 0.012 then
   xstop = min(xmax, x + 50)
   for lz = x to xstop
     terraH(lz) = y
     c = rnd * 50 + 50
     terraC(lz) = c
   next
   x = lz - 1
 else
   holder1 = holder1 + rate1
   holder2 = holder2 + rate2
   holder3 = holder3 + sin(holder2)/20
   y = 600 + sin(holder1) * 50 + cos(holder2) * 50 + cos(holder3) * 15
   terraH(x) = y
   c = rnd * 50 + 50
   terraC(x) = c
 end if
next

w = window()

label restart  'initialize
fuel = 500  'this is the space vehicle's fuel

'vda is vehicle degree angle = orientation of the vehicle, mainly it's thrusters
vda = 0     'the vehicle is traveling right across screen due East = 0 degrees = 0 Radians
speed = 6   'this is the speed the vehicle is moving in the vda direction
vx = 50     'this is current x position of vehicle 10 pixles from left side
vy = 10     'this is current y position of vehicle 10 pixels down from top of screen

'd stands for delta with stands for change dx = change in x, dy = change in y
'dg is change due to gravity (vertical)
'dat is change of acceleration due to thrust
dx = speed * cos(d2r * vda)  'this is the horizontal x change on screen due to speed and angle
dy = speed * sin(d2r * vda)  'this is the vertical y change on screen due to speed and angle
dg = .1     'this is the constant acceleration gravity applies to the vehicle
dat = 2     'this is burst of acceleration a thrust or reverse thrust will apply to speed and angle

while 1
 cls
 scene
 'fuel line
 rect 20, ymax - 25, xmax - 20, ymax - 5, 12 filled
 ff = fuel/500 * (xmax - 40)
 rect 20, ymax - 20, ff + 20, ymax - 10, 14 filled
 color 10
 at 10, ymax/2 :      ? "Horizontal: ";int(vx);", ";int(dx)
 color 9
 at 10, ymax/2 + 20 : ? "  Vertical: ";int(vy);", ";int(dy)

 'vehicle falls faster and faster, because gravity effects the vertical speed
 dy = dy + dg  'speed up falling due to gravity acceleration

 'new position = last postion plus the horizontal and vertical changes from momentum
 vx = vx + dx
 vy = vy + dy

 if vx < 0 or vx > xmax or vy < -50 then
   w.alert("You have drifted off screen.")
   goto playAgain
 end if
 if vy <= terraH(vx) and fuel > 0 then
   Lander vx, vy, d2r * vda
 else
   crash$ = ""
   if vda <> 270 then crash$ = crash$ + "Vehicle not upright. "
   if dy > 4 then crash$ = crash$ + "Came down too fast. "
   if dx > 4 then crash$ = crash$ + "Still moving hoizontally too fast. "
   if fuel <= 0 then crash$ = crash$ + "Ran out of fuel. "
   if terraH(vx -10) <> terraH(vx + 10) then crash$ = crash$ + "Did not land on level site. "
   if crash$ <> "" then
     w.alert(crash$,  "You crashed!")
   else
     w.alert("Nice job!", "Successful landing!")
   end if
   goto playAgain
 end if
 showpage
 delay 100
wend

label playAgain
w.ask("", "Play Again?")
if w.answer = 0  then goto restart
stop

sub scene
 for i = 0 to ns
   circle sx(i), sy(i), sr(i), 1, sc(i) filled
 next
 for i = 0 to xmax
   line i, terraH(i) , i, ymax, rgb(terraC(i), terraC(i), terraC(i))
 next
end
'                              arrow + esc key
sub moveUp
 'here is the vertical and horizontal change from a burst of fuel for thrust
 thrustx = dat * cos(d2r * vda )
 thrusty = dat * sin(d2r * vda )

 'now change the horizontal and vertical momentums from the thrust
 dx = dx + thrustx
 dy = dy + thrusty

 'update the position

 vx = vx + dx
 vy = vy + dy
 circle vx, vy, 5, 1, 14 filled
 showpage

 'the thrust cost fuel
 fuel = fuel - 10
end

sub moveLeft
 local x1, y1
 x1 = vx + 10 * cos(d2r * vda + .5 * PI)
 y1 = vy + 10 * sin(d2r * vda + .5 * PI)
 circle x1, y1, 5, 1, 14 filled
 showpage
 vda = vda - 22.5
 if vda < -0.01 then vda = 360
 fuel = fuel - 10
end

sub moveRight
 local x1, y1
 x1 = vx + 10 * cos(d2r * vda - .5 * PI)
 y1 = vy + 10 * sin(d2r * vda - .5 * PI)
 circle x1, y1, 5, 1, 14 filled
 showpage
 vda = vda + 22.5
 if vda > 337.51 then vda = 0
 fuel = fuel - 10
end

sub quit
 stop
end

sub Lander(x0, y0, rAngle) 'rebuilt from ground up literally!
 'x0, y0 are at the base of the lander, the rocket will point rAngle up when landing
 local pangle, x1, x2, y1, y2, x3, y3, x4, y4, i, arr
 color rgb(195, 195, 225)

 x1 = x0 + 10 * cos(rAngle - .5 * PI)
 y1 = y0 + 10 * sin(rAngle - .5 * PI)
 x2 = x0 + 10 * cos(rAngle + .5 * PI)
 y2 = y0 + 10 * sin(rAngle + .5 * PI)
 x3 = x0 + 10 * cos(rAngle)
 y3 = y0 + 10 * sin(rAngle)
 x4 = x0 + 25 * cos(rAngle)
 y4 = y0 + 25 * sin(rAngle)
 'legs/fins
 line x3, y3, x1, y1
 line x3, y3, x2, y2
 line x4, y4, x1, y1
 line x4, y4, x2, y2
 x5 = x0 + 20 * cos(rAngle)
 y5 = y0 + 20 * sin(rAngle)
 pangle = 2 * pi / 8
 dim arr(2 * 8 + 1)
 for i = 0 to 8
     x1 = x4 + 15 * cos(i * pangle + rAngle)
     y1 = y4 + 15 * sin(i * pangle + rAngle)
   arr(2 * i) = x1
   arr(2 * i + 1) = y1
 next
 drawpoly arr filled
end
