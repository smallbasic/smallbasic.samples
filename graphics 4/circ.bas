REM SmallBASIC
REM created: 13/08/2019
option predef load modules
import android

android.sensor_on(0)
randomize ticks
x=xmax/2
y=ymax/2
np=60
gap=7
ar=[]

func mk(n)
  local r
  r.co=rgb(90-n,90-n,n)'rnd*15
  r.p1=rnd*360
  r.p2=rnd*360
  r.dr=iff(n mod 2==1,1,0)
  r.s=rnd*900
  r.n=n+5
  return r
end

sub sh(i,of,ac)
  local r,s,e,j
  j=iff(ar[i].dr==1, of, -of)
  s=rad(ar[i].p1+j+ar[i].s)
  e=rad(ar[i].p2+j+ar[i].s)
  r=ar[i].n*gap
  arc x,y,r,s,e,1,ar[i].co
  if i==ac then
    arc x,y,r+1,s,e,1,ar[i].co
    arc x,y,r-1,s,e,1,ar[i].co
    arc x,y,r+2,s,e,1,ar[i].co
    arc x,y,r-2,s,e,1,ar[i].co
  endif
end
 
for i = 0 to np - 1
  ar<<mk(i)
next i

of=0
ac=10
nn=1
t=10
while 1
  of=(of+10) mod 360
  nn=(nn+1) mod (np-1)
  s=android.sensor
  x+=s.y*100
  y+=s.x*100
  if x<0 then x=0
  if x>xmax then x=xmax
  if y<0 then y=0
  if y>ymax then y=ymax
  if ac>0 and s.y*s.x < 0 then ac-=1
  if ac<np-1 and s.y*s.x > 0 then ac+=1
'  if ac==0 then exit loop
  cls
  'print ac+ " "+s.z
  for i = 0 to np-1
    sh(i,of,ac)
  next i

  showpage
  delay t
wend


