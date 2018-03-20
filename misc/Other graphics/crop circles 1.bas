'crop circles 1.bas SmallBASIC 2015-09-19 MGA/B+
cx=xmax/2:cy=ymax/2:cr=cy-60:m=20:OK=1
pen on
rect 0,0,xmax,ymax,rgb(0,128,0) filled
while OK
   k=inkey
   if len(k)=1 and asc(k)=27 then OK=0
   if k="c" then rect 0,0,xmax,ymax,rgb(0,128,0) filled
   mx=pen(4):my=pen(5)
   dx=(mx-cx)/m:dy=(my-cy)/m:dr=cr/m
   for i=m to 0 step -1 
      if i mod 2 then cc=rgb(0,160,0) else cc=rgb(0,128,0)
      x=cx+dx*(m-i):y=cy+dy*(m-i):r=dr*i
      circle x,y,r,1,cc filled
   next
   delay 200
wend
pen off
