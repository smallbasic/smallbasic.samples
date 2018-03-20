
'RGB match and chart.bas 2015-12-10 SmallBASIC 0.12.2 [B+=MGA]
'Idea for RGB key match from Keijo Koskinen, thank you
'Color chart added 2015 April/May
'2015-12-10 realigned for text width and height, mouse response added

th=txth("By")
tw=txtw("B")
s="***  RGB Color Values and Chart  ***"
at (15*4*tw-txtw(s))/2, .5*th:? s
r=125:g=125:b=125
rect 0,2*th,16*4*tw,6*th
rect 1,2*th+1,16*4*tw-2,6*th-2,15 filled
at 7*tw,8*th:? "e-/r+ for red  "
at 27*tw,8*th:?"f-/g+ for green"
at 47*tw,8*th:?"v-/+b for blue"
at 0,10*th:? "                    1 1 1 1 1 1"
at 0,11*th:? "0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5  col*16+15=C"
z=33.5*tw
at z,12*th:? "rgb(C,C,C)"
at z,13*th:? "rgb(C,0,0)"
at z,14*th:? "rgb(0,C,0)"
at z,15*th:? "rgb(0,0,C)"
at z,16*th:? "rgb(C,C,0)"
at z,17*th:? "rgb(C,0,C)"
at z,18*th:? "rgb(0,C,C)"
at z,19*th:? "rgb(255,C,0)"
at z,20*th:? "rgb(255,0,C)"
at z,21*th:? "rgb(C,255,0)"
at z,22*th:? "rgb(0,255,C)"
at z,23*th:? "rgb(C,0,255)"
at z,24*th:? "rgb(0,C,255)"

sqx=2*tw: sqy=th: yoff=12*th
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
                       
while 1
   at 13*tw,7*th:? "    "
   at 13*tw,7*th:? r
   at 33*tw,7*th:? "    "
   at 33*tw,7*th:? g
   at 53*tw,7*th:? "    "
   at 53*tw,7*th:? b
   rect 2,2*th+2,16*4*tw-2,6*th-2,rgb(r,g,b) filled
   k=inkey
   pen on
   if pen(3) then
     mx=pen(4):my=pen(5)
     if my>7*th and my<9*th then
       if mx<10*tw then 
         k="e"
       elif mx<20*tw 
         k="r"
       elif mx<30*tw
         k="f"
       elif mx<40*tw
         k="g"
       elif mx<50*tw
         k="v"
       elif mx<60*tw
         k="b"
       end if  
     end if
     delay 60
   end if
   pen off
   if k="e" then r=r-5:if r<0 then r=0  
   if k="r" then r=r+5:if r>255 then r=255
   if k="f" then g=g-5:if g<0 then g=0 
   if k="g" then g=g+5:if g>255 then g=255  
   if k="v" then b=b-5:if b<0 then b=0 
   if k="b" then b=b+5:if b>255 then b=255
wend
