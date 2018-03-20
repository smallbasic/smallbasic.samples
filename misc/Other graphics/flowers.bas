'flowers.bas SmallBASIC 2015-05-06 B+
sq=(ymax-100)^4
color 15,0
for i=0 to 100
   line 0,i,xmax,i,rgb(0,0,155+i)
next
locate 1,83:? " Happy Birthday! "
for i=100 to ymax
   line 0,i,xmax,i,rgb(0,210-.25*i,0)
next 
for i=1 to 125
   x=rnd*xmax:s=rnd*8:y=100-s:cc=rnd*75:col=rgb(cc,cc,cc)
   rect x,y step s,s,col filled
next  
repeat
   col=rnd*7+9
   'cc=int(rnd*12)*5+200
   'col = rgb(cc,cc,0)
   petals = (20 * rnd) + 5
   xoff = rnd*xmax
   yoff = ymax-(rnd*sq)^.25
   size = (yoff/100)^2
   for theta = 0 to 2*3.414159 step 0.001
      r = cos(petals*theta)
      for fil = 0 to size
         x = r * cos(theta) * fil + xoff
         y = r * sin(theta) * fil + yoff
         pset x, y, col
      next fil
   next theta
until inkey=" "