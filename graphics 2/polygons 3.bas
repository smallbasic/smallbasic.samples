
' poly3.bas SmallBASIC modified from samples 2015-04-23 MGA/B+
' 2nd modification for SmallBASIC 0.12.0 05-11-2015 for On-line sample

xc=xmax/2 : yc=ymax/2 : d=3 :sq=yc-10
color 15,0
while 1
   cls
   ? "press any quit,":?
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
         delay 10
         if len(inkey) then 99
      next
   next
   ? "sigh, rest 2 secs...":?
   delay 2000
   if len(inkey) then 99
   d=d+1
wend
99 ? "Goodbye!"
