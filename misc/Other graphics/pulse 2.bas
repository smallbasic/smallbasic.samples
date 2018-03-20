'pulse 2.bas for SmallBASIC 2015-08-15 MGA/B+ one less parameter one more color variation
'note: variables are automatic global unless declared local, here cycle is known to sub
sq=729
rect 0,0 step sq,sq,15 filled
while 1
   PlusX4 0,0,sq
   pause 1
   cycle+=1
wend
sub PlusX4(x,y,side)
   local s,cc,level
   s=side/3
   level=6
   while 3^level>=side
      level-=1
   wend
   if cycle mod 2 then cc=rgb(level*50,0,0) else cc=rgb(0,0,level*50)
   rect x+s,y step s,s,cc filled
   rect x,y+s,x+3*s,y+2*s,cc filled
   rect x+s,y+2*s step s,s,cc filled
   if side<10 then exit sub
   PlusX4 x,y,s
   PlusX4 x+2*s,y,s
   PlusX4 x,y+2*s,s
   PlusX4 x+2*s,y+2*s,s
end