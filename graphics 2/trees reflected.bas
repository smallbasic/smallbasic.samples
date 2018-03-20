
'trees reflected v2.bas for SmallBASIC 0.12.2 [B+=MGA] 2016-04-02
'overhaul wave maker section

const yshore=(ymax*.8)\1
const secwide=xmax
const sechigh=ymax-yshore
dim sect(secwide,sechigh)

const ang2rad=pi/180
color 15,0
for i=0 to ymax
  line 0,i,xmax,i,rgb(70,20,i/ymax*160)
next
stars=xmax*ymax*10^-4.35
horizon=.67*ymax
for i=1 to stars 'stars in sky
  pset rnd*xmax,rnd*horizon,11
next
stars=stars/2
for i=1 to stars
  circle rnd*xmax,rnd*horizon,1,1,11 filled
next
stars=stars/2
for i=1 to stars
  circle rnd*xmax,rnd*horizon,2,1,11 filled
next
for i=.67*ymax to .8*ymax
  gc=max(0,100-(i-.67*ymax)*.5)
  line 0,i,xmax,i,rgb(gc,gc,gc)
next 
branch xmax*.6+rnd*.3*xmax,ymax*.75-.07*ymax,6,90,xmax/20,0
branch rnd*.3*xmax,ymax*.75-.05*ymax,7,90,xmax/18,0
branch xmax/2,ymax*.77,8,90,xmax/16,0
rect  0,.8*ymax,xmax,.8*ymax+1,rgb(70,70,70) filled
for y=.8*ymax to ymax
  for x=0 to xmax
    yy=.8*ymax-(y-.8*ymax)*4
    pset x,y,point(x,yy)
  next
next
showpage
getsec 0,yshore

ylead=ymax-6
while 1
  ytrail=ylead+5
  if ytrail> ymax then ytrail=yshore+ytrail-ymax-1
  ysect=ytrail-yshore
  for x=0 to xmax
    pset x,ylead,point(x,ytrail+1) - 10*(1+256^2)
    pset x,ytrail,sect(x,ysect)
  next
  showpage
  delay 60
  ylead=ylead-1
  if ylead< yshore then ylead=ymax-6
wend

sub branch(x,y,startr,angD,length,lev)
  local x2,y2,dx,dy,bc,i
  x2 = x+ cos(ang2rad*angD) * length
  y2 = y- sin(ang2rad*angD) * length
  dx = (x2-x)/length
  dy = (y2-y)/length
  bc = rgb(10+lev,15+lev,10)
  for i=0 to length
    circle x+dx*i,y+dy*i,startr,1,bc filled
  next
  if startr-1< 0 or lev> 11 or length< 5 then exit sub
  lev+=1
  branch x2,y2,startr-1,angD+10+30*rnd,.8*length+.2*rnd*length,lev
  branch x2,y2,startr-1,angD-10-30*rnd,.8*length+.2*rnd*length,lev
end

sub getsec(xstart,ystart)
  local x,y
  'these are all global
  for y=0 to sechigh
    for x=0 to secwide
      sect(x,y)=POINT(xstart+x,ystart+y)
    next
  next
end

