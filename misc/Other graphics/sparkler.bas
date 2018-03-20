'sparkler.bas smallBASIC 2015-06-27 B+
randomize
color 15,0
pen on
quit=0
repeat
   k=inkey
   if k="q" or k=" " or (len(k)=1 and asc(k)=27) then quit=1
   mx=pen(4)
   my=pen(5)
   cls
   locate 0,0: print "mouse down ("; dx; ", "; dy; ")"
   locate 1,0: print "q, spacebar or esc to quit..."
   if pen(3) then dx=mx:dy=my else dx=0:dy=0
   drawsparks
   delay 10
until quit
pen off
locate 3,0: print "Thanks for playing!"
end
sub drawsparks
   if dx and dy then
      rc=rnd
      if rc<.333 then:c=12
      elseif rc<.666:c=15
      else:c=9:endif
      for i=1 to 100
         line dx,dy,rnd*(xmax),rnd*(ymax),c
      next
   endif
end  