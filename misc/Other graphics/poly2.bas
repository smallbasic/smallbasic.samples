' poly3.bas SmallBASIC modified from samples 2015-04-23 MGA/B+
' modified for new SB Windows 0.11.17 release 2015-05-09
xc=xmax/2 : yc=ymax/2 : d=3 :sq=yc-10
color 15,0
repeat
   cls
   ? "press space bar or esc to quit,":?
   ? "Here is "+d+" point poly.":?
   dim x(d)
   dim y(d)
   dm=d-1
   for i=0 to dm
      t=cos(i*2*pi/d)
      x(i)=xc+t*sq
      t=sin(i*2*pi/d)
      y(i)=yc+t*sq
   next
   c=8
   for a=dm to 0 step -1
      c=c+1 : if c>15 then c=8
      for b=dm to 0 step -1
         circle x(b),y(b),2 color c filled
         line x(a),y(a),x(b),y(b) color c
         delay 30
      next
   next
   ? "sigh, rest 3 secs...":?
   pause 3
   d=d+1
until asc(inkey)=32 or asc(inkey)=27
? "Goodbye!"