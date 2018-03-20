'fireworks.bas SmallBASIC 2015-07-13 MGA/B+
color 11,0:cls
bm=400:b1=bm-1
dim bx(bm),by(bm),bdx(bm),bdy(bm),bc(bm)

k="a"
pen on
while 1
   rndcycle=rnd*20 
   loopcount=0 
   rndcycle=rnd*20
   rx=.75*xmax*rnd+.125*xmax
   ry=.75*ymax*rnd+.125*ymax
   repeat
      cls
      for i=1 to 20
         nxt=rnd*bm
         bx(nxt)=rx
         by(nxt)=ry
         bdx(nxt)=(rnd*31)-15
         bdy(nxt)=(rnd*31)-15
         rc=int(rnd*3)
         if rc=0 then
            bc(nxt)=12
         elseif rc=1 
            bc(nxt)=9
         else
            bc(nxt)=15
         endif
      next
      for i=0 to b1
         if bdy(i) then
            line bx(i),by(i),bx(i)+bdx(i),by(i)+bdy(i),bc(i)
            circle bx(i)+bdx(i),by(i)+bdy(i),1.125,1,bc(i) filled
            bx(i)=bx(i)+bdx(i)
            by(i)=by(i)+bdy(i)
            if bx(i)<0 or bx(i)>xmax or by(i)<0 or by(i)>ymax then bdy(i)=0 
         end if
      next
      delay 2
      loopcount+=1
   until loopcount>rndcycle 
wend

