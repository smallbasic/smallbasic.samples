'pulse 4.bas SmallBASIC 15-08-16 MGA/B+ return to readable style
'make a proper screen saver with proper exit (cycle+=1 would eventually error out) 
sq=243 'might fit my future phone screen
rect 0,0 step sq,sq,15 filled
while len(inkey)=0
   PlusX4 0,0,1
   delay 1000
   if pulse then pulse=0 else pulse=1
wend
sub PlusX4(x,y,r)
   local s,cc:s=sq/3^r
   if pulse then cc=rgb(255-r*50,0,0) else cc=rgb(r*50,0,0)
   rect x+s,y step s,s,cc filled
   rect x,y+s,x+3*s,y+2*s,cc filled
   rect x+s,y+2*s step s,s,cc filled
   if r>4 then exit 
   PlusX4 x,y,r+1
   PlusX4 x+2*s,y,r+1
   PlusX4 x,y+2*s,r+1
   PlusX4 x+2*s,y+2*s,r+1
end
