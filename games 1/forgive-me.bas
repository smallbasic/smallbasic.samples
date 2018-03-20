
CLS
VIEW 10 , 10 , 640 , 640, 2,0
at 10,10
print "Angelle (please do not go)"
Randomize 7343543 + 4340429 * (RND - 0.5)
for fls = 1 to 21
col = floor(rnd * 15) + 1

k = floor (25 * rnd) + 2
flx = rnd * 1.4 - 0.7
fly = rnd * 1.4 - 0.7

size = 60 * rnd + 20
for theta = 0 to 2*3.414159 step 0.001
  r = cos(k*theta)
  
  for fil = 0 to size
  x = r * cos(theta) * fil + 300 + 200*flx
  y = r * sin(theta) * fil + 300 + 200*fly
  
  pset x, y, col
  next fil

next theta

next fls
at 10,30
print "Honey"
pause 1
at 10,50
print "You were busy"
pause 1
at 10, 70
print "And I disrupted you"
pause 1
at 10, 90
print "I just wanted to say I am sorry"
pause 1
at 10, 110
print "You did not talk to me the whole time after that"
pause 1
at 10,130
print "You must be very upset"
pause 1
at 10, 150
print "Please forgive me"
pause 1
at 10, 170
print "You mean my everything"
pause 1
at 10, 190
print "I love you"

end

