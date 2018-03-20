
'square elimination v3.bas SmallBASIC 2015-05-31 MGA/B+
'Chris recommended Repeat until Pen(0) for mouse up wait, does not work the way i tried it.
' plus we want something different/more than highlite mouse down square
'2015-06-05 today I found an alternate way to get mouse down and up for Naalaa and translated 
'back to SmallBASIC let's use that version (mouse trap v NaaLaa.bas) in here for version 3
sub Update()
   local x,y,c
   rect tlx-1,tly-1,tlx+10*sq,tly+10*sq,0 filled
   for x=1 TO 10
      for y=1 TO 10
         if board(x,y)="R" then
            c=12
         elif board(x,y)="B"
            c=9 
         else
            c=0
         endif
         rect tlx+sq*(x-1),tly+sq*(y-1) step sq-2,sq-2,c filled
      next
   next 
end sub
func bx(mx)
   local rtn
   rtn=int((mx-tlx)/sq +1)
   if rtn< 11 and rtn> 0 then
      bx=rtn
   else 
      bx=0
   endif
end
func by(my)
   local rtn
   rtn=int((my-tly)/sq +1)
   if rtn< 11 and rtn> 0 then
      by=rtn
   else 
      by=0
   endif
end
func moved(x1,y1,x2,y2)
   if x1 and y1 and x2 and y2 then
      if board(x1,y1)=board(x2,y2) then 'same color
         if x1=x2 then
            if y1-y2=1 then
               moved=1
            elseif y2-y1=1
               moved=3
            else
               moved=0
            endif               
         elseif y1=y2
            if x1-x2=1 then 'left
               moved=4
            elseif x2-x1=1 'right
               moved=2
            else
               moved=0
            endif
         else
            moved=0
         endif
      endif
   else 'one is 0
      moved=0
   endif
end
'=================================================================main
const title="Square Elimination: q or <esc> to quit with score."
const th=txth(title)
const tw=txtw(title)
const tly=2*th 
const sq=int((ymax-5*th)/10) 'decide square size according ymax (the smaller of xmax/ymax)
const tlx=(xmax-10*sq)/2
at (xmax-tw)/2,0:print title
s1="Mouse down on sq to move, mouse up over adjacent similar color sq."
at (xmax-txtw(s1))/2,th: print s1
dim board(1 to 10,1 to 10)
for y=1 TO 10
   for x=1 TO 10
      board(x,y)= MID("RB",int(rnd*2)+1,1)
   next
next

dx=0:dy=0:ux=0:uy=0:flagupdate=0
pen on:quit=0
repeat
   mx=pen(4)
   my=pen(5)
   k=inkey
   if (len(k)=1 and asc(k)=27) or k="q" then quit=1
   update
   showpage
   if mx> tlx and mx< tlx+10*sq and my> tly and my< tly+10*sq then
      if pen(3) then
         if dx<> 0 and dy<> 0 and board(dx,dy)<> " " then
            rect tlx+sq*(dx-1)-1,tly+sq*(dy-1)-1 step sq-1,sq-1,15
            showpage
         endif
         if dx=0 and dy=0 then
            dx=bx(mx):dy=by(my)
            ux=0:uy=0
         endif
      else 'not pen(3)
         if dx and dy then
            ux=bx(mx)
            uy=by(my)
            moov=moved(dx,dy,ux,uy)
            if moov then
               if moov=1 then ' Moved up
                  for i=dy TO 10
                     board(dx,i-1)= board(dx,i)
                  next
                  board(dx,10)=" "
               elseif moov=2  ' Moved right
                  for i=dx TO 1 step -1
                     board(i+1,dy)= board(i,dy)
                  next
                  board(1,dy)=" "
               elseif moov=3 ' Moved down
                  for i=dy TO 1 step -1
                     board(dx,i+1)= board(dx,i)
                  next
                  board(dx,1)=" "
               elseif moov=4 ' Moved left
                  for i=dx to 10  
                     board(i-1,dy)= board(i,dy)
                  next
                  board(10,dy)=" "
               endif 'moov #
            endif 'if moov
            dx=0:dy=0
         endif 'dx and dy
      endif 'pen 3 or not  
   endif 'mouse on board
until quit
pen off
for i=1 to 10
   for j=1 to 10
      if board(i,j)<> " " then lcount=lcount +1
   next
next
s1="You have left "+str(lcount)+" squares of 100 on board."
at (xmax-txtw(s1))/2,2*th+sq*10:print s1
s1="Thanks for playing!"
at (xmax-txtw(s1))/2,3*th+sq*10:print s1
showpage 
pause 5
