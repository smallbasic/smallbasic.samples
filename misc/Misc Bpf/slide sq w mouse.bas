' slide sq w mouse.bas (SmallBASIC) MGA/B+ 2015-07-28

rem from Sliding Blocks Puzzle Game programmed by Hermang H. M. M. 
rem copied from BP.org 2015-07-26, his last changes on July 5, 2015 in YABasic.
rem 2015-07-26 simplified for SmallBASIC with Picture and Alphabet Modes removed.
rem 2015-07-27 adding TFsolved checker routine and mouse/graphics in YABasic.  
rem 2015-07-28 translated again to SmallBASIC for further improvement in SmallBASIC.

MaxSize = 15
print "SLIDING BLOCKS PUZZLE"
print : print "Select Board size from 3 up to "; MaxSize
print "(ie.  press 3 <enter>  for a 3X3 Puzzle)
print "(or   press 0 <enter>    to quit)
repeat
  input size
  if size=0 then print"goodbye!":end
until(size>=3 and size<=MaxSize)
dim board(size+1,size+1)
th=40    'text height, max expansion in SB 11.8
tlx=40   'top left x for board
tly=2*th 'top left y for board
sq=int((ymax-4*th)/size)  'board sq size
plx=3*tlx+sq*size         'for title and text right of board 
color 0,11:cls 'sets all print fore and back color, squares have to match
rect 0,0,2*tlx+sq*size,ymax,9 filled 'set board on blue left side
for i=0 to 3
   rect 0,0,2*tlx+sq*size-i,ymax-i,0
next
initBoard()
mixBlocks()
showBoard()
at plx,3*th:print "SLIDING BLOCKS PUZZLE:"
at plx,4*th:print "click block or press arrow key to move block into space,"
at plx,5*th:print "press Q to quit, escape key to remix blocks"
pen on
repeat
   if pen(3) then
      mx=bx(pen(4))
      my=by(pen(5))
      if emptyRow+1=mx and emptyCol=my then doleft
      if emptyRow-1=mx and emptyCol=my then doright
      if emptyRow=mx and emptyCol+1=my then doup
      if emptyRow=mx and emptyCol-1=my then dodown
   endif
   k=inkey
   if len(k)=2 then
      ak=asc(right(k,1))
      if ak=4 then:doleft
      elseif ak=5:doright
      elseif ak=9:doup
      elseif ak=10:dodown:endif
   elseif len(k)=1
      if asc(k)=27 then mixBlocks
   endif   
   if update=1 then showBoard
   if TFsolved then k="q"
until(k="q")
pen off
if TFsolved then s="Congratulations, Puzzle Solved!" else s="Goodbye!"
at plx,10*th:print s
end

'==========procedures

sub initBoard()
   count=0
   for j=0 to size+1
      for i=0 to size+1
         if i=0 or j=0 or i=(size+1) or j=(size+1) then
            board(i,j)=-1
         else
            count=count+1
            board(i,j)=count
         endif
      next
   next
   board(size,size)=0
   emptyRow=size
   emptyCol=size
end

sub showBoard()
   local x,y,c
   rect tlx-1,tly-1,tlx+sq*size+2,tly+sq*size+2,0 filled
   for y=1 to size
      for x=1 to size
         if board(x,y) then c=11 else c=0
         rect tlx+sq*(x-1),tly+sq*(y-1),tlx+sq*(x-1)+sq-2,tly+sq*(y-1)+sq-2,c filled
         if board(x,y) then 
            s=str$(board(x,y))
            at tlx+sq*(x-1)+sq/2-txtw(s)/2,tly+sq*(y-1)+sq/2-txth(s)/2
            print s;
         endif
      next
   next
   update=0
end

sub mixBlocks()
   repeat
      for i=1 to 7*size*size
         dir=1+int(rnd*4)
         if dir=1 then:doleft
         elseif dir=2:doright
         elseif dir=3:doup
         else:dodown:endif
      next
   until TFsolved=0
   update=1
end

sub swapp()
   board(emptyRow,emptyCol)=tag
   board(tr,tc)=0
   emptyRow=tr
   emptyCol=tc
   update=1
end

sub doleft()
   tr=emptyRow+1
   tc=emptyCol
   tag=board(tr,tc)
   if tag=-1 then exit
   swapp
end

sub doright()
   tr=emptyRow-1
   tc=emptyCol
   tag=board(tr,tc)
   if tag=-1 then exit
   swapp
end

sub dodown()
   tr = emptyRow
   tc = emptyCol-1
   tag = board(tr,tc)
   if tag=-1 then exit
   swapp
end

sub doup()
   tr=emptyRow
   tc=emptyCol+1
   tag=board(tr,tc) 
   if tag=-1 then exit
   swapp
end

func TFsolved()
   TFsolved=0:test=1
   for j=1 to size
      for i=1 to size 
         if board(i,j)<>0 then
            if test=board(i,j) then test=test+1 else exit sub
         endif   
      next
   next
   TFsolved=1
end

func bx(mx)
   rtn=int((mx-tlx)/sq+1)
   if rtn<size+1 and rtn>0 then bx=rtn else bx=0
end

func by(my)
   rtn=int((my-tly)/sq+1)
   if rtn<size+1 and rtn>0 then by=rtn else by=0
end
