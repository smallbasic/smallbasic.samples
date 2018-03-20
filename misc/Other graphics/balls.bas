'balls.bas smallBASIC 2015-05-04 B+
pen on
rect 0,0,xmax,ymax,9 filled
while inkey$<>" "
   x=pen(10)
   y=pen(11)
   if pen(12) and x<xmax and y<ymax and x>0 and y>0 then
      sound x*5+100, 150   
      for r=0 to 50
         z=rgb(255-5*r,0,0)
         circ x,y,r,z
      next
      sound 4000-y*5,150
   fi
wend
pen off
end
sub circ(x,y,r,c)
   local i,xps,yps
i=-pi
repeat
   xps = sin(i) * r
   yps = cos(i) * r
   pset xps+x,yps+y,c
   i = i + 0.01
until i>pi
end