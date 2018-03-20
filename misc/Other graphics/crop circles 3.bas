'crop circles 3.bas 2015-09-19 MGA/B+
cx=xmax/2:cy=ymax/2
hc=rgb(0,180,0):lc=rgb(0,120,0)
n=12:stp=-40
rect 0,0,xmax,ymax,lc filled
for br=360 to 100 step stp
   shft=shft+720/(n*n)
   for i=1 to n 
      x=cx+br*cos(rad(i*360/n+shft))
      y=cy+br*sin(rad(i*360/n+shft))
      drawc x,y
   next
next
circle cx,cy,100,1,lc filled
ga=-30.5:bn=100
br=9.5:lr=.5:r=br:dr=(br-lr)/bn
for n=1 to bn 
   x=cx+10*sqr(n)*cos(rad(n*ga))
   y=cy+10*sqr(n)*sin(rad(n*ga))
   r-=dr
   circle x,y,r,1,hc filled
next
sub drawc(mx,my)
   local m,cr,dx,dy,dr,i,cc      
   m=20:cr=100 
   dx=(mx-cx)/m:dy=(my-cy)/m:dr=cr/m
   for i=m to 0 step -1 
      if i mod 2 then cc=hc else cc=lc
      x=cx+dx*(m-i):y=cy+dy*(m-i):r=dr*i
      circle x,y,r,1,cc filled
   next
end