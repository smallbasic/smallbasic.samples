
'aquarium v2.bas SmallBASIC Bpf 2015-10-15 MGA/B+
'v2 the plasma color is set at initialization and stays with fish
'v2 the fish swim and are drawn both ways
option base 1
n=30
dim x(n),y(n),l(n),dx(n),dy(n),rr(n),gg(n),bb(n)
for i=1 to n
   x(i)=rnd*xmax:y(i)=rnd*ymax:l(i)=rnd*xmax*.0625+18
   d=int(rnd*2)
   if d then dx(i)=rnd*8+1 else dx(i)=-1*(rnd*8)-1
   r+=.2:g+=.005:b+=.010
   if r>.5 then r=.02
   if g>.5 then g=.005
   if b>.5 then b=.01
   rr(i)=r:gg(i)=g:bb(i)=b
next

while 1
   for i=0 to ymax
      line 0,i,xmax,i,rgb(0,0,255-(i/ymax)*255)
   next
   for i=1 to n
      x(i)=x(i)+dx(i)
      if x(i)+1.25*l(i)<0 then dx(i)=-1*dx(i)
      if x(i)-1.25*l(i)>xmax then dx(i)=-1*dx(i)
      y(i)=y(i)+int(rnd*5)-2
      for ra=1 to l(i)
         plasma=RGB(127+127*sin(rr(i)*ra),127+127*sin(gg(i)*ra),127+127*sin(bb(i)*ra))
         if dx(i)<0 then
            line x(i)+ra,y(i)-ra,x(i)+ra,y(i)+ra,plasma
         else
            line x(i)-ra,y(i)-ra,x(i)-ra,y(i)+ra,plasma
         end if
      next
      for ra=5 to .3*l(i)
         plasma=RGB(127+127*sin(rr(i)*ra),127+127*sin(gg(i)*ra),127+127*sin(bb(i)*ra))
         if dx(i)<0 then
            line x(i)+l(i)+ra,y(i)-ra,x(i)+l(i)+ra,y(i)+ra,plasma
         else
            line x(i)-l(i)-ra,y(i)-ra,x(i)-l(i)-ra,y(i)+ra,plasma
         end if
      next
      if dx(i)<0 then
         circle x(i)+.25*l(i),y(i),.1*l(i),1,0 filled
         circle x(i)+.25*l(i),y(i),.06*l(i),1,14
      else
         circle x(i)-.25*l(i),y(i),.1*l(i),1,0 filled
         circle x(i)-.25*l(i),y(i),.06*l(i),1,14
      end if
   next  
   delay 10
   showpage
wend
