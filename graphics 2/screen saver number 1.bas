
REM screen saver number 1.bas 2016-02-11 SmallBASIC 0.12.0 [B+=MGA]
' floating triangles
randomize
ntri=18
dim x1(ntri),x2(ntri),x3(ntri),y1(ntri),y2(ntri),y3(ntri),ct(ntri)
dim dx1(ntri),dx2(ntri),dx3(ntri),dy1(ntri),dy2(ntri),dy3(ntri)

label restart
for i=1 to ntri
  x1(i)=(xmax+200)*rnd-100:x2(i)=(xmax+200)*rnd-100:x3(i)=(xmax+200)*rnd-100
  y1(i)=(ymax+200)*rnd-100:y2(i)=(ymax+200)*rnd-100:y3(i)=(ymax+200)*rnd-100
  dx1(i)=10*rnd*rdir:dx2(i)=10*rnd*rdir:dx3(i)=10*rnd*rdir
  dy1(i)=5*rnd*rdir:dy2(i)=5*rnd*rdir:dy3(i)=5*rnd*rdir
  c1=int(rnd*2):c2=int(rnd*2):c3=int(rnd*2)
  ct(i)=rgb(255*rnd*c1,255*rnd*c2,255*rnd*c3)
  if ct(i)=0 then ct(i)=rgb(255,0,0)
next
while 1
  if len(inkey) then goto restart
  cls
  for i=1 to ntri
    ftriangle x1(i),y1(i),x2(i),y2(i),x3(i),y3(i),ct(i)
    x1(i)=x1(i)+dx1(i)
    if x1(i)< -100 then dx1(i)=dx1(i)*-1
    if x1(i)> xmax+100 then dx1(i)=dx1(i)*-1
    x2(i)=x2(i)+dx2(i)
    if x2(i)<-100 then dx2(i)=dx2(i)*-1
    if x2(i)> xmax+100 then dx2(i)=dx2(i)*-1
    x3(i)=x3(i)+dx3(i)
    if x3(i)< -100 then dx3(i)=dx3(i)*-1
    if x3(i)> xmax+100 then dx3(i)=dx3(i)*-1
    y1(i)=y1(i)+dy1(i)
    if y1(i)< -100 then dy1(i)=dy1(i)*-1
    if y1(i)> ymax+100 then dy1(i)=dy1(i)*-1
    y2(i)=y2(i)+dy2(i)
    if y2(i)< -100 then dy2(i)=dy2(i)*-1
    if y2(i)> ymax+100 then dy2(i)=dy2(i)*-1
    y3(i)=y3(i)+dy3(i)
    if y3(i)< -100 then dy3(i)=dy3(i)*-1
    if y3(i)> ymax+100 then dy3(i)=dy3(i)*-1
  next
  showpage
  delay 10
wend
func rdir()
  if int(rnd*2) then rdir=1 else rdir=-1
end

'modified Fast Filled Triangle Sub by AndyAmaya
sub ftriangle(x1, y1, x2, y2, x3, y3,tcolor)
   local x,y,slope1,length,slope2
   'triangle coordinates must be ordered: where x1 < x2 < x3
   if x2 < x1 then x  = x2 : y  = y2 : x2 = x1 : y2 = y1 : x1 = x  : y1 = y
   'swap x1, y1, with x3, y3
   if x3 < x1 then x  = x3 : y  = y3 : x3 = x1 : y3 = y1 : x1 = x  : y1 = y
   'swap x2, y2 with x3, y3
   if x3 < x2 then x  = x3 : y  = y3 : x3 = x2 : y3 = y2 : x2 = x  : y2 = y
   if x1 <> x3 Then slope1 = (y3-y1)/(x3-x1)
   'draw the first half of the triangle
   length = x2 - x1
   if length <> 0 then
      slope2 = (y2-y1)/(x2-x1)
      for x = 0 to length
         line int(x+x1),int(x*slope1+y1),int(x+x1),int(x*slope2+y1),tcolor
      next
   end if
   'draw the second half of the triangle
   y = length*slope1+y1 : length = x3-x2
   if length <> 0 then
      slope3 = (y3-y2)/(x3-x2)
      for x = 0 To length
         line int(x+x2),int(x*slope1+y),int(x+x2),int(x*slope3+y2),tcolor
      next
   end if
end
