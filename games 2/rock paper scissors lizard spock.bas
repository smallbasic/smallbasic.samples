
'GUI RPSLS.bas 2015-08-09 for Rock Paper Scissors Lizard Spock
'for SmallBASIC RT 11.8 version MGA/B+

'some set up
dim bt(0 to 9)
for i=0 to 9 
   read beats$
   bt(i)=beats$
next
xc=xmax/2 
yc=ymax/2 
toff=-pi/2
side=ymax/2.5
color 15,0:cls
dim px(5), py(5)      
for i=0 to 4
   t=cos(i*2*pi/5+toff)
   px(i)=xc+t*side
   t=sin(i*2*pi/5+toff)
   py(i)=yc+t*side
next
mby1=(py(1)-py(0))/2 +py(0)
mby2=(py(2)-py(1))/2 +py(1)
pscore=0 : cscore=0 : refresh=1
'-----------------------------------main game loop
pen on
repeat
   if refresh then drawScreen
   refresh=0
   x=pen(4)
   y=pen(5)
   if pen(3) then playRound x,y
   k=inkey
until lower(k)="q" or (len(k)=1 and asc(k)=27)
pen off
at 10,10:? "Bye"

'---------------------------------------------------------
sub cbox(x,y,c,txt)
   local s
   s=(txtw(txt)+10)/2
   rect x-s,y-s,x+s,y+s,c filled
   at x-txtw(txt)/2,y-txth(txt)/2:print txt
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
   'which was clicked mz 0-4
   if my<mby1 then
      player=0
   elseif my<mby2 
      if mx> xc then player=1 else player=4
   else
      if mx> xc then player=2 else player=3
   endif
   
   'isolate players choice
   cls : drawBox player
   showpage
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
   if winner<> "T" then
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
      showpage
      delay 1500
   endif
   if winner="T" then
      bts="Player Ties Computer"
   else
      if winner="P" then
         bts="Player "+bt(dr)+" Computer"
      else
         bts="Computer "+bt(dr)+" Player"
      endif
   endif
   cls : at xc-txtw(bts)/2,yc-txth(bts)/2 : print bts
   showpage
   delay 2200
   cls
   refresh=1
end

sub drawRule(rnum)
   select case rnum
   case 0
      line px(0),py(0),px(1),py(1),12
      line px(0)-1,py(0),px(1)-1,py(1),12
      line px(0)-2,py(0),px(1)-2,py(1),12
      line px(0)-3,py(0),px(1)-3,py(1),12
      line px(0)-4,py(0),px(1)-4,py(1),12
      tline px(0),py(0),px(1),py(1),bt(0),-1,5
   case 1
      line px(0),py(0),px(2),py(2),12
      line px(0)-1,py(0),px(2)-1,py(2),12
      line px(0)-2,py(0),px(2)-2,py(2),12
      tline px(0),py(0),px(2),py(2),bt(1),-1,3
   case 2
      line px(1),py(1),px(2),py(2),7
      line px(1)-1,py(1),px(2)-1,py(2),7
      line px(1)-2,py(1),px(2)-2,py(2),7
      tline px(1),py(1),px(2),py(2),bt(2),1,3
   case 3
      line px(1),py(1),px(3),py(3),7
      line px(1)-1,py(1),px(3)-1,py(3),7
      line px(1)+1,py(1),px(3)+1,py(3),7
      tline px(3),py(3),px(1),py(1),bt(3),.5,13
   case 4
      line px(2),py(2),px(3),py(3),10
      line px(2),py(2)+1,px(3),py(3)+1,10
      tline px(3),py(3),px(2),py(2),bt(4),.5,12
   case 5
      line px(2),py(2),px(4),py(4),10
      line px(2)+1,py(2),px(4)+1,py(4),10
      line px(2)+2,py(2),px(4)+2,py(4),10
      tline px(4),py(4),px(2),py(2),bt(5),.5,11
   case 6
      line px(3),py(3),px(4),py(4),15
      line px(3)+1,py(3),px(4)+1,py(4),15
      tline px(4),py(4),px(3),py(3),bt(6),1.5,6
   case 7
      line px(3),py(3),px(0),py(0),15
      line px(3)+1,py(3),px(0)+1,py(0),15
      tline px(0),py(0),px(3),py(3),bt(7),-3,14
   case 8
      line px(4),py(4),px(0),py(0),9
      line px(4)+1,py(4),px(0)+1,py(0),9
      line px(4)+2,py(4),px(0)+2,py(0),9
      line px(4)+3,py(4),px(0)+3,py(0),9
      tline px(4),py(4),px(0),py(0),bt(8),-1.5,5
   case 9
      line px(4),py(4),px(1),py(1),9
      line px(4),py(4)+1,px(1),py(1)+1,9
      tline px(4),py(4),px(1),py(1),bt(9),-1,3
   end select
end

sub drawBox(bnum)
   select case bnum
   case 0:cbox px(0),py(0),12,"    ROCK    "
   case 1:cbox px(1),py(1), 7,"  SCISSORS  "
   case 2:cbox px(2),py(2),10,"   LIZARD   "
   case 3:cbox px(3),py(3),15,"    PAPER   "
   case 4:cbox px(4),py(4), 9,"   SPOCK!   "
   end select
end

sub drawScreen
   local i,s
   for i=0 to 9
      drawRule i
   next i
   for i=0 to 4
      drawBox i
   next i
   s="Player "+right(spc(3)+str$(pscore),3)
   at px(0)-txtw(s)-140,py(0)-txth(s)/2 :? s
   s="Computer "+right(spc(3)+str$(cscore),3)
   at px(0)+140,py(0)-txth(s)/2 :? s
   showpage
end

data "BLUNTS","CRUSHES","DECAPITATES","CUTS","EATS","POISONS","DISPROVES","COVERS","VAPORIZES","BREAKS"
