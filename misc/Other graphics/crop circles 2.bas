'crop circles 2.bas 2015-09-19 MGA/B+
cx=xmax/2:cy=ymax/2:ga=137.5:bn=800
br=9.5:lr=.5:r=br:dr=(br-lr)/bn
hc=180:lc=120:cr=(hc-lc)/bn
rect 0,0,xmax,ymax,rgb(0,lc,0) filled
for n=1 to bn 
   x=cx+10*sqr(n)*cos(rad(n*ga))
   y=cy+10*sqr(n)*sin(rad(n*ga))
   r-=dr
   cc+=cr
   c=rgb(0,cc+lc+1,0)
   circle x,y,r,1,c filled
next
