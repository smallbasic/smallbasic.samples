'squeaky mouse.bas SmallBASIC 2015-05-2 B+
randomize
xm=xmax:ym=ymax
while inkey$<>"."
   pen on
   x=pen(10)
   y=pen(11)
   pen off
   r=rnd*100
   rd=128+int((x/xm)*128)
   if rd>255 then rd=255
   gr=128+int((y/ym)*128)
   if gr>255 then gr=255
   c=rgb(rd,gr,128)
   circle x,y,r,1,c
   sound 100+y*10,180
wend
