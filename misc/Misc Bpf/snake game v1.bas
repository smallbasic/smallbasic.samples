'snake game v1.bas 2015-06-07 started from copy of Quite Basic game
'OK I have this working decent about same as original game
'OK now this game has a restart option 2015-06-08
sub Update()
   local x,y,c
   rect tlx-1,tly-1,tlx+B*sq,tly+B*sq,0 filled
   for x=1 TO B
      for y=1 TO B
         if board(x,y)>0 and board(x,y)<5 then
            c=10
         elif board(x,y)=5
            c=13
         else
            c=2
         endif
         rect tlx+sq*(x-1),tly+sq*(y-1) step sq-2,sq-2,c filled
      next
   next 
end sub
sub uv(direction)
   if direction=1 then
      u=0:v=-1
   elseif direction=2
      u=0:v=1
   elseif direction=3
      u=-1:v=0
   else
      u=1:v=0
   endif
end
sub startgame()
   dim board(1 to B,1 to B)
   p = 12:q = 6:board(p,q) = 2
   r = 12:s = 5:board(r,s) = 2
   board(20,20)=5
   u=0:v=1:quit=0:f=0:kd=0:d=2
   update
end
'=================================================================main
const B=25 'Board and array dimension BxB array and board
const title="SNAKE GAME key=move: w=up, z=down, a=left, s=right spacebar=(re)start"
const th=txth(title)
const tw=txtw(title)
const tly=2*th 
const sq=int((ymax-5*th)/B) 'decide square size according ymax (the smaller of xmax/ymax)
const tlx=(xmax-B*sq)/2
cls:Randomize 
at (xmax-tw)/2,0:print title
s1="Game over: crash into wall or snake, (reverse) direction, key=q or esc"
at (xmax-txtw(s1))/2,th: print s1
startgame
repeat
   k=inkey
   k=ucase(k)
   if (len(k)=1 and asc(k)=27) or k="Q" then quit=1
   if k="W" then kd=1
   if k="Z" then kd=2
   if k="A" then kd=3
   if k="S" then kd=4
   if k=" " then startgame
   d=board(p,q)
   if kd then
      uv kd
      d=kd
   else
      uv d
   endif
   board(p,q)=d 'do i need this line? YES!!!
   p=p+u
   q=q+v
   if p>B or p<1 or q>B or q<1 then exit 'game over we hit a wall
   if board(p,q)<5 and board(p,q)>0 then exit 'we hit ourself
   if board(p,q)=5 'we hit our morsel of food yeah! set up another morsel
      f+=1
      repeat
         a=int(rnd*(B)+1)
         rb=int(rnd*(B)+1)
      until board(a,rb)=0
      board(a,rb)=5
      board(p,q)=d
   else
      board(p,q)=d
      y=board(r,s)
      uv y
      board(r,s)=0
      r=r+u
      s=s+v
   end if
   update
   delay 500
until quit
s1="Your snake ate "+f+" morsels. Goodbye!"
at (xmax-txtw(s1))/2,3*th+sq*B:print s1
