'sliding blocks.bas for SmallBASIC 2015-07-27 MGA/B+
'translated and simplified (no picture or alphabet option) from:
rem Sliding Blocks Puzzle Game (for Yabasic) 2015-07-26 copy from BP.org
rem programmed by Hermang H. M. M. last changes on July 5, 2015
'added more coloring to blocks and a check to see if numbers puzzle is solved
'bp.org post 2015-07-27
MaxSize = 5
dim board( MaxSize+1, MaxSize+1 )
dim dirty( MaxSize+1, MaxSize+1 )
dim bm$( MaxSize*MaxSize )

print "Sliding blocks puzzle"
print : print "Select Board size from 3 upto "; MaxSize
repeat
  input s$
  size = val(s$)
until( size>=3 and size<=MaxSize )

color 0,11:cls
initBoard
mixBlocks
showBoard
 
repeat
  update = 0
  k = inkey
  if len(k)=2 then
     ak=asc(right(k,1))
     if ak=4 then 
        doleft
     elif ak=5
        doright
     elif ak=9
        doup
     elif ak=10
        dodown
     endif
  elseif len(k)=1
     ak=asc(k)
     if ak=27 then
        mixBlocks()
        update = 1
     endif
  endif
  if update = 1 then showBoard
  if TFsolved then 
      print:print "  Puzzle Solved, Congratulations!"
      k="q"
   end if
until(k = "q")
print:print "   Goodbye!"

'================================= subs no local variables all global
sub initBoard()
   count = 0
   for j=0 to size+1
      for i=0 to size+1
         if i=0 or j=0 or i=(size+1) or j=(size+1) then
            board( j, i ) = -1
         else
            count = count + 1
            board( j, i ) = count
            dirty( j, i ) = 1
         endif
      next
   next
   board(size, size) = 0
   emptyRow = size
   emptyCol = size
end

sub showBoard()
   color 0,11:cls
   print "press Q to quit, arrow keys to move, escape key to mix blocks"
   print
   for j=1 to size
      for i=1 to size
         tag = board( j, i )
         if tag<>0 then
            color 0,15
            print "[ "+ right(" "+str(tag),2)+ " ]";
            color 0,11
         else
            color 15,0
            print "[    ]";
            color 0,11
         end if
         print " ";
      next
      print:print
   next
end

sub mixBlocks()
   for i = 1 to 7*size*size
      update = 0
      'repeat 'is this loop needed?
         dir = 1 + int(rnd*4)
         if dir = 1 then doleft
         if dir = 2 then doright
         if dir = 3 then doup
         if dir = 4 then dodown
      'until update = 1 
      print ".";
   next
   print
end

sub swapp()
   board(emptyRow, emptyCol) = tag
   board( tr, tc ) = 0
   dirty(emptyRow, emptyCol) = 1
   dirty( tr , tc ) = 1
   emptyRow = tr
   emptyCol = tc
   update = 1
end

sub doleft()
 tr = emptyRow
 tc = emptyCol + 1
 tag = board( tr, tc ) 
 if tag = -1 then exit
 swapp
end

sub doright()
 tr = emptyRow
 tc = emptyCol - 1
 tag = board( tr, tc ) 
 if tag = -1 then exit
 swapp
end

sub dodown()
 tr = emptyRow - 1
 tc = emptyCol
 tag = board( tr, tc ) 
 if tag = -1 then exit
 swapp
end

sub doup()
 tr = emptyRow + 1
 tc = emptyCol
 tag = board( tr, tc ) 
 if tag = -1 then exit
 swapp
end

func TFsolved()
   TFsolved=0
   test=1
   for j=1 to size
      for i=1 to size
         tag = board( j, i )
         if tag<>0 then
            if test=tag then test=test+1 else exit sub
         end if 
      next
   next
   TFsolved=1
end 