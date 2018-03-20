'ying yang.bas - SmallBasic started 2015-05-14 MGA/B+
sub circ2BW(xc,yc,rc)
   local x1,y1,x2,y2,nr
   x1=xc+rc*sin(rad(i))
   y1=yc+rc*cos(rad(i))
   circle x1,y1,rc,1,15 filled
   circle x1,y1,rc/3,1,0 filled
   x2=xc+rc*sin(rad(i+180))
   y2=yc+rc*cos(rad(i+180))
   circle x2,y2,rc,1,0 filled
   circle x2,y2,rc/3,1,15 filled
end

'=========================main
sq=700
rect 0,0 step sq,sq,9 filled
i=0
while len(inkey)=0
   circ2BW sq/2,sq/2,sq/8
   'showpage
   i=i+10:if i>360 then i=i-360
wend