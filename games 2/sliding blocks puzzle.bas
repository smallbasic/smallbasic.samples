
'Classic sliding block puzzle.bas 2015-12-04 SmallBASIC 0.12.1 [B+=MGA]
' modified from  Sliding Blocks Puzzle Game programmed by Hermang H. M. M. 
' copied from BP.org 2015-07-05 in YABasic.
' updated to work in an Android NOOK from On-line samples 

if xmax> ymax then ssq=ymax else ssq=xmax
MaxSize = 10
th=txth("By")+4   'text height
label start
myline=0
color 0,11:cls 'sets all print fore and back color, squares have to match
at 0,th*1:? "           SLIDING BLOCKS PUZZLE"
for i=3 to MaxSize
  at 0,th*i:? "Tap/click this line for board size ";i;"x";i
next
at 0,th*(MaxSize+1):? "Tap/click this line to quit"
pen on
repeat
  if pen(3) then myline=int(pen(5)/th): delay 60
until myline> 2 and myline< MaxSize+2
pen off
if myline=MaxSize+1 then cls:end else size=myline

'============================================ and we are off to play a game
dim board(size+1,size+1)
tlx=40   'top left x for board
tly=3*th 'top left y for board
sq=int((ssq-4*th)/size)  'board sq size
cls 
rect 0,0,2*tlx+sq*size,ssq,9 filled 'set board on blue left side
for i=0 to 3
   rect 0,0,2*tlx+sq*size-i,ssq-i,0
next
initBoard()
mixBlocks()
showBoard()
s=" SLIDING BLOCKS PUZZLE: r resets, q quits "
at (ssq-txtw(s))/2,0*th+2:? s
s=" tap block or arrow key to move block "
at (ssq-txtw(s))/2,1*th+2:? s 
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
      if k="r" then mixBlocks
   endif   
   if update=1 then showBoard
   if TFsolved then k="q"
until(k="q")
pen off
if TFsolved then 
  for i=1 to 20
    if i mod 2 then 
      s=" Congratulations, Puzzle Solved! "
    else
      s=space(32)
    end if
    at (ssq-txtw(s))/2,2*th+2:? s
    delay 200
  next  
  goto start
end if

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
         if board(i,j)<> 0 then
            if test=board(i,j) then test=test+1 else exit sub
         endif   
      next
   next
   TFsolved=1
end

func bx(mx)
   rtn=int((mx-tlx)/sq+1)
   if rtn< size+1 and rtn> 0 then bx=rtn else bx=0
end

func by(my)
   rtn=int((my-tly)/sq+1)
   if rtn< size+1 and rtn> 0 then by=rtn else by=0
end

