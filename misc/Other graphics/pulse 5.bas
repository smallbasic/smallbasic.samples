'pulse 5.bas SmallBASIC 15-08-16 MGA/B+ for pulse snapshot
sq=243 
rect 0,0 step sq,sq,15 filled
while len(inkey)=0
   cm=0:PlusX4   0,  0,1:cm=1:PlusX4 250,  0,1:cm=0:PlusX4 500,  0,1
   cm=1:PlusX4   0,250,1:cm=1:PlusX4 250,250,1:cm=1:PlusX4 500,250,1
   cm=0:PlusX4   0,500,1:cm=1:PlusX4 250,500,1:cm=0:PlusX4 500,500,1
   delay 1000
   if pulse then pulse=0 else pulse=1
wend
sub PlusX4(x,y,r)
   local s,cc:s=sq/3^r
   if cm then
      if pulse then cc=rgb(255-r*63,0,0) else cc=rgb(r*63,0,0)
   else
      if pulse then cc=rgb(r*63,0,0) else cc=rgb(255-r*63,0,0)
   endif
   rect x+s,    y step        s,    s,cc filled
   rect   x,  y+s,        x+3*s,y+2*s,cc filled
   rect x+s,y+2*s step        s,    s,cc filled
   if r>3 then exit 
   PlusX4     x,    y,r+1
   PlusX4 x+2*s,    y,r+1
   PlusX4     x,y+2*s,r+1
   PlusX4 x+2*s,y+2*s,r+1
end
