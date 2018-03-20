
REM ss number 2.bas 2016-02-11 SmallBASIC 0.12.0 [B+=MGA]

randomize
n=200
dim x(n),y(n),r(n),c(n),dx(n),dy(n),dr(n)
mxr=60

label restart
for i=1 to n
  x(i)=(xmax+200)*rnd-100
  y(i)=(ymax+200)*rnd-100
  r(i)=1+rnd*(mxr-1) 
  dx(i)=10*rnd*rdir
  dy(i)=5*rnd*rdir
  dr(i)=2*rnd*rdir
  c1=int(rnd*2):c2=int(rnd*2):c3=int(rnd*2)
  c(i)=rgb(255*rnd*c1,255*rnd*c2,255*rnd*c3)
  if c(i)=0 then c(i)=rgb(255,0,0)
next
while 1
  if len(inkey) then goto restart
  cls
  for i=1 to n
    circle x(i)+rnd*6,y(i)+rnd*6,r(i),1,0 filled
    circle x(i),y(i),r(i),1,c(i) filled
    x(i)=x(i)+dx(i)
    if x(i)< -100 then dx(i)=dx(i)*-1
    if x(i)> xmax+100 then dx(i)=dx(i)*-1
    y(i)=y(i)+dy(i)
    if y(i)< -100 then dy(i)=dy(i)*-1
    if y(i)> ymax+100 then dy(i)=dy(i)*-1
    r(i)=r(i)+dr(i)
    if r(i)< 1 then dr(i)=dr(i)*-1
    if r(i)> mxr then dr(i)=dr(i)*-1
  next
  showpage
  delay 10
wend
func rdir()
  if int(rnd*2) then rdir=1 else rdir=-1
end
