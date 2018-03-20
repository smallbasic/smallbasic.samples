'color chart.bas SmallBASIC modified 2015-04-27
'2015-04-28 completely overhauled MGA/B+
locate 0,19:?"***  RGB Color Values and Chart  ***"
r=125:g=125:b=125
rect 30,20,455,100
rect 31,21,454,99,15 filled
locate 8,7:? "e-/r+ for red  "
locate 8,27:?"f-/g+ for green"
locate 8,47:?"v-/+b for blue" 
locate 10,0:? " 0   1   2   3   4   5   6   7   8   9   10  11  12  13  14  15   col*16+15 = c"
locate 12,66:? "rgb(c,c,c)"
locate 14,66:? "rgb(c,0,0)"
locate 16,66:? "rgb(0,c,0)"
locate 18,66:? "rgb(0,0,c)"
locate 20,66:? "rgb(c,c,0)"
locate 22,66:? "rgb(c,0,c)"
locate 24,66:? "rgb(0,c,c)"
locate 26,66:? "rgb(255,c,0)"
locate 28,66:? "rgb(255,0,c)"
locate 30,66:? "rgb(c,255,0)"
locate 32,66:? "rgb(0,255,c)"
locate 34,66:? "rgb(c,0,255)"
locate 36,66:? "rgb(0,c,255)"

sqx=28: sqy=30: yoff=173
for i = 0 to 207
   row=int(i/16):col=i mod 16 
   cx=sqx*col:cy=sqy*row+yoff
   c=col*16+15 
   if i>-1 and i<16 then c=rgb(c,c,c)
   if i>15 and i<32 then c=rgb(c,0,0)
   if i>31 and i<48 then c=rgb(0,c,0)
   if i>47 and i<64 then c=rgb(0,0,c)
   if i>63 and i<80 then c=rgb(c,c,0)
   if i>79 and i<96 then c=rgb(c,0,c)
   if i>95 and i<112 then c=rgb(0,c,c)
   if i>111 and i<128 then c=rgb(255,c,0)
   if i>127 and i<144 then c=rgb(255,0,c)
   if i>143 and i<160 then c=rgb(c,255,0) 
   if i>159 and i<176 then c=rgb(0,255,c)
   if i>175 and i<192 then c=rgb(c,0,255)
   if i>191 and i<208 then c=rgb(0,c,255)
   rect cx,cy step sqx-1,sqy-1, c filled 
next 
                        
while asc(k)<>27
   locate 7,13:? "    "
   locate 7,13:? r
   locate 7,33:? "    "
   locate 7,33:? g
   locate 7,53:? "    "
   locate 7,53:? b
   c=rgb(r,g,b)
   rect 40,30,445,90,c filled
   k=inkey
   if k="e" then r=r-5:if r<0 then r=0  
   if k="r" then r=r+5:if r>255 then r=255
   if k="f" then g=g-5:if g<0 then g=0 
   if k="g" then g=g+5:if g>255 then g=255  
   if k="v" then b=b-5:if b<0 then b=0 
   if k="b" then b=b+5:if b>255 then b=255
wend
locate 39,26:? "*****************"
locate 40,26:? "***  goodbye! ***"
locate 41,26:? "*****************"