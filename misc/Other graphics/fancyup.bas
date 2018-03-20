'fancyup.bas SmallBASIC 2015-04-19 B+
side=600:x0=side/2:s=side/2:dx=14
rect 0,0,side,side,0 filled
for i=1 to 8
   lo=x0-s:hi=x0+s
   fancy lo,hi,dx
   's=s/2:dx=dx-2 'first fancyup
   s=s-50:dx=dx-1
   if dx=0 then dx=1
next i
end
sub fancy(low,high,dx)
   local i
   interations=(high-low)/dx
   FOR i=0 TO interations
      line low+i*dx,low,high,low+i*dx,9
      line high,low+i*dx,high-i*dx,high,12
      line high-i*dx,high,low,high-i*dx,9
      line low,high-i*dx,low+i*dx,low,12
   NEXT i
   line high,low,high,high,9
   line high,high,low,high,12
   line low,high,low,low,9
   line low,low,high,low,12
end