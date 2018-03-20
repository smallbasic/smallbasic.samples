'Circles Kalide v2.bas SmallBASIC 2015-08-29 MGA/B+
randomize
color 15,0:cls
const side=680
const sc=side/2
initialize
counter=1
repeat
   k=inkey$
   if len(k)=1 and asc(k)=27 then exit
   if counter>=650 then 
      cls
      initialize
      counter=1
   fi
   drawit
   changeit
   counter+=1
until hellfreezesover
locate 0,0:? "Goodbye"

sub initialize()
   x=int(rnd*sc)
   y=int(rnd*sc)
   r=rnd*40
   a=rnd*2
   cr=int(rnd*256)
   cb=int(rnd*256)
   cg=int(rnd*256)
   cc=rgb(cr,cg,cb)
end
sub drawit()
   circle sc-x,sc-y,r,a,cc filled
   circle sc+x,sc-y,r,a,cc filled
   circle sc-x,sc+y,r,a,cc filled
   circle sc+x,sc+y,r,a,cc filled
   'keep drawing framed in 680X680 square
   rect 681,0,xmax,ymax,0 filled
   rect 0,681,680,ymax,0 filled
end
sub changeit
   x+=((int(rnd*3) mod 3)-1)*20
   if x<0 or x>sc+20 then x=sc/2
   y+=((int(rnd*3) mod 3)-1)*20
   if y<0 or y>sc+20 then y=sc/2
   r+=((int(rnd*3) mod 3)-1)*3
   if r<1 or r>40 then r=20
   a+=((int(rnd*3) mod 3)-1)*.1
   if a<.1 or a>2 then a=1
   cr+=((int(rnd*3) mod 3)-1)*15
   if cr<1 or cr>254 then cr=128
   cg+=((int(rnd*3) mod 3)-1)*15
   if cg<1 or cg>254 then cg=128
   cb+=((int(rnd*3) mod 3)-1)*15
   if cb<1 or cb>254 then cb=128
   cc=rgb(cr,cg,cb)
end