'ripples.bas smallBASIC 2015-05-04 B+
randomize
pen on
rect 0,0,xmax,ymax,9 filled
while inkey$<>" "
   x=pen(10)
   y=pen(11)
   if pen(12) and x<xmax and y<ymax and x>0 and y>0 then
      circle x, y, rnd*60
      sound x*5+100, 150
      circle x, y, rnd*60 color 15
      sound 4000-y*5,150
   fi
wend
pen off
end