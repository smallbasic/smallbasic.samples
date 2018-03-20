'sparkler v2.bas smallBASIC 2015-06-27 MGA/B+
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
   digress=1
   drawsparks dx,dy,digress
   delay 10
until quit
pen off
locate 3,0: print "Thanks for playing!"
end
sub drawsparks(x,y,level)
   local i,rc,c,rl,ra,rx,ry
   if x and y and level<3 then
      if level=1 then 
         ri=50
      elseif level=2
         ri=30
      else
         ri=5
      endif   
      for i=1 to ri
         rc=int(rnd*(4))
         if rc=1 then
            c=rgb(0,0,255)
         elseif rc=2
            c=rgb(255,255,255)
         else
            c=rgb(255,0,0)
         endif
         rl=(rnd*(100)+40)/(.666*level)
         ra=rnd*(361)
         rx=x+rl*cos(rad(ra))
         ry=y+rl*sin(rad(ra))
         rl2=.5*rl
         rx2=x+rl2*cos(rad(ra))
         ry2=y+rl2*sin(rad(ra))
         line x,y,rx2,ry2,c
         drawsparks rx,ry,level+1
      next
   else
      exit 
   endif
end sub