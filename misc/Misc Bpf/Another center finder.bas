'Another center finder.bas in SmallBASIC 2015-09-12 MGA/B+
'Thanks to ScriptBasic for posting 1968 Dartmouth Code
'different center, can't circumcribe or inscribe

? "To find a center of triangle, click 3 points to draw Triangle."

pen on
p1x=-100
while p1x=-100
   if pen(3) then p1x=pen(4):p1y=pen(5)
wend
circle p1x,p1y,2,1 filled
? "one"
delay 200

p2x=-100
while p2x=-100
   if pen(3) then p2x=pen(4):p2y=pen(5)
wend
circle p2x,p2y,2,1 filled
? "two"
line p1x,p1y,p2x,p2y
mp1x=p1x+(p2x-p1x)/2
mp1y=p1y+(p2y-p1y)/2
delay 200

p3x=-100
while p3x=-100
   if pen(3) then p3x=pen(4):p3y=pen(5)
wend
circle p3x,p3y,2,1 filled
? "three"
pen off
'draw triangle
line p2x,p2y,p3x,p3y
line p3x,p3y,p1x,p1y
mp2x=p2x+(p3x-p2x)/2
mp2y=p2y+(p3y-p2y)/2
mp3x=p3x+(p1x-p3x)/2
mp3y=p3y+(p1y-p3y)/2

circle mp1x,mp1y,2,1 filled
circle mp2x,mp2y,2,1 filled
circle mp3x,mp3y,2,1 filled

line mp1x,mp1y,p3x,p3y
line mp2x,mp2y,p1x,p1y
line mp3x,mp3y,p2x,p2y

ABCs4StdFrm mp1x,mp1y,p3x,p3y
A=U:B=V:C=W
ABCs4StdFrm mp2x,mp2y,p1x,p1y
D=U:E=V:F=W
Solve4XY
circle X,Y,2,1 filled

func slope(q1x,q1y,q2x,q2y)
   slope=(q2y-q1y)/(q2x-q1x)
end

sub ABCs4StdFrm(r1x,r1y,r2x,r2y)
   'takes two points that define line and gets A,B,C's for Standard Form of line
   local m
   m=slope(r1x,r1y,r2x,r2y)
   U=-m:V=1:W=r2y-m*r2x    'U,V,W are global 
end 

sub Solve4XY()
   'globals A,B,C,D,E,F
   local G
   G=A*E-B*D
   IF G=0 THEN PRINT "NO UNIQUE SOLUTION":exit
   X=(C*E-B*F)/G
   Y=(A*F-C*D)/G
end