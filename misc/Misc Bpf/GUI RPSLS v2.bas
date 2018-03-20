'GUI RPSLS v2.bas 2015-08-08 for Rock Paper Scissors Lizard Spock
'v2 edit or add+ comment out themes in data statements
'v2 added exit box and code
'v2 new summary for tie

' some set up --------------------------------------------------------------------
'the 5 nouns from data
dim nn(4)
for i=0 to 4
   read noun
   ln=len(noun)
   temp= spc((12-ln)/2) + noun
   nn(i)=temp+spc(12-len(temp))
next
'the nouns colors
read nc0,nc1,nc2,nc3,nc4

'test
'for i=0 to 4:? nn(i):next:print nc0,nc1,nc2,nc3,nc4:input "OK";t
 
' the 10 verb relations over noun bests noun   
dim bt(0 to 9)
for i=0 to 9 
   read bests
   bt(i)=bests
next

'screen map points
xc=xmax/2 
yc=ymax/2 
toff=-pi/2
side=ymax/2.5
color 15,0:cls

'pentagram nodes
dim px(5), py(5)      
for i=0 to 4
   t=cos(i*2*pi/5+toff)
   px(i)=xc+t*side
   t=sin(i*2*pi/5+toff)
   py(i)=yc+t*side
next

'mouse borders
mxborder=xmax-60
myborder=30
mby1=(py(1)-py(0))/2 +py(0)
mby2=(py(2)-py(1))/2 +py(1)
pscore=0 : cscore=0 : refresh=1
'-----------------------------------main game loop
pen on
repeat
   k=inkey
   if refresh then drawScreen
   refresh=0
   x=pen(4)
   y=pen(5)
   if pen(3) then playRound x,y
until lower(k)="q" or (len(k)=1 and asc(k)=27)
pen off
at 10,10:? "Bye"

'---------------------------------------------------------
sub cbox(x,y,c,itxt)
   local s
   s=(txtw(nn(itxt))+10)/2
   rect x-s,y-s,x+s,y+s,c filled
   at x-txtw(nn(itxt))/2,y-txth(nn(itxt))/2:print nn(itxt)
end

sub tline(x1,y1,x2,y2,txt,pm,os)
   local dx,dy,i
   dx=(x2-x1)/20
   dy=(y2-y1)/20
   for i=os to os+len(txt)-1
      at x1+dx*i,y1+dy*i+pm*txth(txt):print mid(txt,i-os+1,1)
   next    
end

sub playRound(mx,my)
   local player,computer,winner,total,bts,dr
   
   'exit clicked?
   if mx>mxborder and y<myborder then k="q" : exit sub
   
   'which was clicked mz 0-4
   if my<mby1 then
      player=0
   elseif my<mby2 
      if mx>xc then player=1 else player=4
   else
      if mx>xc then player=2 else player=3
   endif
   
   'isolate players choice
   cls : drawBox player
   delay 500
   
   'now what does computer choose
   computer=int(rnd*5)
   
   'who won, update score
   if player=computer then
      winner="T" 'we don't have to show more 
   elseif ((player+1) mod 5 = computer) or ((player+2) mod 5 = computer)
      winner="P" : pscore=pscore+1
   elseif ((player-1+5) mod 5 = computer) or ((player-2+5) mod 5 = computer)
      winner="C" : cscore=cscore+1
   endif
   
   'find rule 0-9 or tie, once we know that we have all info to display
   if winner<>"T" then
      total=player+computer
      select case total
         case 1:dr=0
         case 2:dr=1
         case 3:if computer=1 or player=1 then dr=2 else dr=7
         case 4:if computer=1 or player=1 then dr=3 else dr=8
         case 5:if computer=2 or player=2 then dr=4 else dr=9
         case 6:dr=5
         case 7:dr=6
      end select
      drawRule dr
      drawBox player
      drawbox computer
      delay 1500
   endif
   if winner="T" then
      bts="Both chose same, 'Great minds think alike.' "
   else
      if winner="P" then
         bts="Player "+bt(dr)+" Computer"
      else
         bts="Computer "+bt(dr)+" Player"
      endif
   endif
   cls : at xc-txtw(bts)/2,yc-txth(bts)/2 : print bts
   delay 2200
   cls
   refresh=1
end

sub drawRule(rnum)
   'draw a number of lines between nodes/noun vrs noun verbs
   local i
   select case rnum
   case 0
      for i=0 to 3:line px(0)-i,py(0),px(1)-i,py(1),nc0:next
      tline px(0),py(0),px(1),py(1),bt(0),-1,5
   case 1
      for i=0 to 2:line px(0)-i-2,py(0),px(2)-i-2,py(2),nc0:next
      tline px(0),py(0),px(2),py(2),bt(1),-1,3
   case 2
      for i=0 to 2:line px(1)-i,py(1),px(2)-i,py(2),nc1:next
      tline px(1),py(1),px(2),py(2),bt(2),1,3
   case 3
      for i=0 to 4:line px(1)+i,py(1),px(3)+i,py(3),nc1:next
      tline px(3),py(3),px(1),py(1),bt(3),.5,11
   case 4
      for i=0 to 2:line px(2),py(2)+i,px(3),py(3)+i,nc2:next
      tline px(3),py(3),px(2),py(2),bt(4),.5,9
   case 5
      for i=0 to 4:line px(2)+i,py(2),px(4)+i,py(4),nc2:next
      tline px(4),py(4),px(2),py(2),bt(5),.5,11
   case 6
      for i=0 to 2:line px(3)+i,py(3),px(4)+i,py(4),nc3:next
      tline px(4),py(4),px(3),py(3),bt(6),1.5,6
   case 7
      for i=0 to 2:line px(3)+i,py(3),px(0)+i,py(0),nc3:next
      tline px(0),py(0),px(3),py(3),bt(7),-3,14
   case 8
      for i=0 to 3:line px(4)+i,py(4),px(0)+i,py(0),nc4:next
      tline px(4),py(4),px(0),py(0),bt(8),-1.5,5
   case 9
      for i=0 to 2:line px(4),py(4)+i,px(1),py(1)+i,nc4:next
      tline px(4),py(4),px(1),py(1),bt(9),-1,3
   end select
end

sub drawBox(bnum)
   'x,y center of box then noun color, then noun index
   select case bnum
   case 0:cbox px(0),py(0),nc0,0
   case 1:cbox px(1),py(1),nc1,1
   case 2:cbox px(2),py(2),nc2,2
   case 3:cbox px(3),py(3),nc3,3
   case 4:cbox px(4),py(4),nc4,4
   end select
end

sub drawScreen
   local i,s,cexit
      
   'exit button
   cexit=rgb(190,0,0)
   rect xmax-60,10,step 51,21,0 filled
   rect xmax-60,10 step 50,20,cexit filled
   for i=0 to 2
      line xmax-40+i,15,xmax-33+i,25,15
      line xmax-40+i,25,xmax-33+i,15,15
   next i
   
   'rules lines with beats word
   for i=0 to 9
      drawRule i
   next i
   
   'nouns box, nodes of graph
   for i=0 to 4
      drawBox i
   next i
   
   'scores
   s="Player "+right(spc(3)+str$(pscore),3)
   at px(0)-txtw(s)-140,py(0)-txth(s)/2 :? s
   s="Computer "+right(spc(3)+str$(cscore),3)
   at px(0)+140,py(0)-txth(s)/2 :? s
end

'starter theme --------------------------------------- no upper or lower case adjustments
'5 nouns, 5 colors for nouns, 10 bests relation rules
'data "ROCK","SCISSORS","LIZARD","PAPER","SPOCK" 
'data 12,7,10,15,9
'data "Blunts","Bashes","Beheads","Cuts","Eats","Beats","Disproves","Covers","Blasts","Breaks"

'2nd test less violent more constructive theme ----------------------------------------------
data "PLANET","SWORD","MIND","DRAGON","COLOR"
data 9,7,13,10,15
data "Metals","Nourishes","Defends","Scares","Outwits","Enjoys","Scales","Walks","Reflects","Shines"
