'sierpinski forest.bas 2015-12-13 SmallBASIC 0.12.2 [B+=MGA]

randomize timer

color 12,0
?"Seasons Greetings, please wait..."
showpage
delay 10
maxfactor=xmax*ymax
horizon=.65*ymax:ntrees=.063*xmax:land=ymax-horizon
dim xt(ntrees),yt(ntrees),wt(ntrees),ht(ntrees),ct(ntrees)

f=xmax/ntrees 'need to spread trees out, no groups
for i=1 to ntrees 'random placement in zones
  xt(i)=int(f*i-1.5*f*rnd)
next
for i=ntrees to 2 step -1  'now shuffle them
  r=int(rnd*i)+1
  swap xt(i),xt(r)
next

f=land/ntrees:d=(land-20)^(1/ntrees)
for i=1 to ntrees
  yt(i)=horizon+d^i
  ht(i)=((d^i)/land)*.9*ymax+rnd*.09*ymax
  yt(i)=yt(i)-ht(i)
  wt(i)=(.35+rnd*.35)*ht(i)
  ct(i)=rgb(0,int(rnd*40+80),0)
next

for i=0 to horizon 'sky
  line 0,i,xmax,i,rgb(i/horizon*128,i/horizon*32,64)
next
for i=horizon to ymax 'snow covered land
  cc=128+(i-horizon)/land*127
  line 0,i,xmax,i,rgb(cc,cc,cc)
next
stars=maxfactor*10^-4
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
color 6,0
at 0,0:?"When you see the forest, 
color 14,0
at 0,1.5*txth("By"):?"move pointer horizontally to see the trees"
showpage
delay 10
for i=1 to ntrees
  sier xt(i),yt(i),wt(i),ht(i),ct(i)
next
  
pen on   
while 1 
  mx=pen(4)
  far=2500
  for i=1 to ntrees
    if (mx-(xt(i)+.5*wt(i)))^2< far then ifar=i:far=(mx-(xt(i)+.5*wt(i)))^2
  next
  if lastfar then sier xt(lastfar),yt(lastfar),wt(lastfar),ht(lastfar),ct(lastfar)
  sier xt(ifar),yt(ifar),wt(ifar),ht(ifar),0
  lastfar=ifar 
  showpage
  delay 10
wend
pen off

sub sier(tlx,tly,width,height,c)
  ax = tlx
  ay = tly+height
  bx = tlx+width
  by = tly+height
  cx = tlx+width/2
  cy = tly
  px = tlx
  py = tly+height
  top=width*height*.25
  for n=0 to top
    if c=0 then pset px,py,int(rnd*16) else circle px,py,1,1,c filled
    select Case int(rnd*3)
    case 0
      px = (px + ax) / 2.0
      py = (py + ay) / 2.0
    case 1
      px = (px + bx) / 2.0
      py = (py + by) / 2.0
    case 2
      px = (px + cx) / 2.0
      py = (py + cy) / 2.0
    end select         
  next
  showpage
end
