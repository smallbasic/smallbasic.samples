'pulse.bas for SmallBASIC 2015-08-14 MGA/B+
sq=729
rect 0,0 step sq,sq,15 filled
while 1
   PlusX4 0,0,sq,cycle mod 2
   pause 1
   cycle+=1
wend
sub PlusX4(x,y,side,level)
   local s,cc
   s=side/3
   cc=rgb(255-level*50,0,0)
   rect x+s,y step s,s,cc filled
   rect x,y+s,x+3*s,y+2*s,cc filled
   rect x+s,y+2*s step s,s,cc filled
   if side<10 then exit sub
   PlusX4 x,y,s,level+1
   PlusX4 x+2*s,y,s,level+1
   PlusX4 x,y+2*s,s,level+1
   PlusX4 x+2*s,y+2*s,s,level+1
end