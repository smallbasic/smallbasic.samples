sq=729:rect 0,0 step sq,sq,15 filled:while 1:PlusX4 0,0,1:pause 1:cycle+=1:wend
sub PlusX4(x,y,r):local s,cc:s=sq/3^r:if cycle mod 2 then cc=rgb(r*40,0,0) else cc=rgb(0,0,r*40)
rect x+s,y step s,s,cc filled:rect x,y+s,x+3*s,y+2*s,cc filled:rect x+s,y+2*s step s,s,cc filled
if r>5 then exit '== pulse 3.bas SmB 15-08-15 B+ 
PlusX4 x,y,r+1:PlusX4 x+2*s,y,r+1:PlusX4 x,y+2*s,r+1:PlusX4 x+2*s,y+2*s,r+1:end