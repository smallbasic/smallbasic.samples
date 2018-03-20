'bubbles and triangles.bas for SmallBASIC MGA/B+ 2015-07-12
color 11,0:cls
bm=500:b1=bm-1
dim bx(bm),by(bm),bdx(bm),bdy(bm)
tm=250:t1=tm-1
dim tx(tm),ty(tm),tos(tm),tc(tm)
tx(0)=10:ty(0)=5
tstart=1
k="a"
pen on
while k<>"q"
   k=inkey
   cls
   for i=1 to 10
      nxt=rnd*bm
      newb(nxt)
   next
   for i=0 to b1
      if bdy(i) then
         circle bx(i),by(i),5,1,11
         bx(i)=bx(i)+bdx(i)
         by(i)=by(i)+bdy(i)
         if bx(i)<0 or bx(i)>xmax or by(i)<0 or by(i)>ymax then 
            bdy(i)=0
            if bx(i)>0 and bx(i)<xmax then
               tx(tstart)=bx(i)-bdx(i)
               ty(tstart)=5
               tos(tstart)=0
               rc=rnd
               if rc<.333 then 
                  tc(tstart)=12
               elseif rc<.667
                  tc(tstart)=9
               else
                  tc(tstart)=14
               endif   
               tstart=tstart+1
               if tstart>t1 then tstart=0
            endif   
         endif   
      end if
    next
    for i=0 to t1
       if tx(i)<>0 or ty(i)<>0 then
          tri tx(i),ty(i),tos(i),tc(i)
          if ty(i)< ymax-10 then
             ty(i)=ty(i)+7
             tos(i)=tos(i)+.18
          endif
       endif
    next  
    delay 5
wend
pen off
locate 0,0:? "done"
end 
sub newb(i)
   bx(i)=pen(4)
   by(i)=pen(5)
   bdx(i)=(rnd*11)-5
   bdy(i)=(-5*rnd)-1
end 
sub tri(xc,yc,toff,colr)
   local i,t,a,b,x,y
   dim x(3), y(3)      
   for i=0 to 2
      t=cos(i*2*pi/3+toff)
      x(i)=xc+t*10
      t=sin(i*2*pi/3+toff)
      y(i)=yc+t*10
   next
   for a=0 to 2
      b=a+1
      if b>2 then b=0
      line x(a),y(a),x(b),y(b),colr
   next
end