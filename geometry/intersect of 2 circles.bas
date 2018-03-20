
'intersect of 2 circles.bas for SmallBASIC 2015-09-12 MGA/B+
? "Click for origin of Circle 1."
? "Click screen again for radius."
? "Do again for Circle 2."

pen on
o1x=-100
while o1x=-100
   if pen(3) then o1x=pen(4):o1y=pen(5)
wend
delay 300
circle o1x,o1y,2,1 filled
?:? "Circle 1 origin: ";o1x;", ";o1y

r1x=-100
while r1x=-100
   if pen(3) then r1x=pen(4):r1y=pen(5)
wend
delay 300
r1=int(((o1x-r1x)^2+(o1y-r1y)^2)^.5)
circle o1x,o1y,r1
? "Circle 1 radius: ";r1

o2x=-100
while o2x=-100
   if pen(3) then o2x=pen(4):o2y=pen(5)
wend
delay 300
circle o2x,o2y,2,1 filled
?:? "Circle 2 origin: ";o2x;", ";o2y

r2x=-100
while r2x=-100
   if pen(3) then r2x=pen(4):r2y=pen(5)
wend
delay 300
r2=int(((o2x-r2x)^2+(o2y-r2y)^2)^.5)
circle o2x,o2y,r2
? "Circle 2 radius: ";r2
?
pen off

d=((o1x-o2x)^2+(o1y-o2y)^2)^.5
if r1+r2< d then ? "The circles are too far apart to intersect.":end
if d< 2 then
   if abs(r1-r2)> 3 then 
      ? "No intersect, same center (or nearly so) and different radii (or seemingly so).":end
   else
      ? "Infinite intersect, the circles are the same (or nearly so).":end
   end if
end if

'results
a=(r1^2-r2^2+d^2)/(2*d)
Px=o1x+a*(o2x-o1x)/d
Py=o1y+a*(o2y-o1y)/d
h=(r1^2-a^2)^.5
x1=int(Px-h*(o2y-o1y)/d)
y1=int(Py+h*(o2x-o1x)/d)
circle x1,y1,2,1 filled
?:? "Intersect pt1: ";x1;", ";y1
x2=int(Px+h*(o2y-o1y)/d)
y2=int(Py-h*(o2x-o1x)/d)
circle x2,y2,2,1 filled
?:? "Intersect pt2: ";x2;", ";y2
line x1,y1,x2,y2
