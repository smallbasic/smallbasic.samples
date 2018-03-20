'XY intersect.bas in SmallBASIC 2015-09-18 MGA/B+

option base 1
dim px(4),py(4) 

? "To find intersect of 2 lines, click 2 end points of line 1, then again for line 2."
pen on
XYclick 1 'point 1 recorded into arrays
XYclick 2 'point 2 recorded into arrays
'2 points make a line 
line px(1),py(1),px(2),py(2)
points2std px(1),py(1),px(2),py(2),1

XYclick 3 
XYclick 4 
line px(3),py(3),px(4),py(4)
pen off
points2std px(3),py(3),px(4),py(4),2
solve4XY
for r=6 to 1 step -1
   if r mod 2 then cc=15 else cc=12
   circle iX,iY,r,1,cc filled
next

sub points2std(r1x,r1y,r2x,r2y,row)
   'takes two points that define line and gets A,B,C's for Standard Form of line
   local m
   m=(r2y-r1y)/(r2x-r1x)
   if row =1 then
      A=-m:B=1:C=r2y-m*r2x
   elseif row=2
      D=-m:E=1:F=r2y-m*r2x
   end if
end 

sub XYclick(PointIndex)
   local ptx, pty
   ptx=-100
   while ptx=-100
      if pen(3) then ptx=pen(4):pty=pen(5)
   wend
   circle ptx,pty,2,1 filled
   px(pointindex)=ptx
   py(pointindex)=pty
   delay 200
end

sub Solve4XY()
   'globals A,B,C,D,E,F
   local G
   G=A*E-B*D
   IF G=0 THEN PRINT "NO UNIQUE SOLUTION":exit
   IX=(C*E-B*F)/G
   IY=(A*F-C*D)/G
end