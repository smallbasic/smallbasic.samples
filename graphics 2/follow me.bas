
REM Me followers.bas 2015-11-30 SmallBASIC 0.12.1 [B+=MGA]
nfollowers=100
Dim xfollower(nfollowers),yfollower(nfollowers)
for i=0 to nfollowers
  xfollower(i)=xmax/2:yfollower(i)=ymax/2
next
B="Me"
thB=txth(B)*1.5
twB=txtw(B)/2
color 11,0
while 1
  cls
  pen on
  mx=pen(4):my=pen(5)
  pen off
  delay 30
  at mx-twB,my-thB:?B
  for i=nfollowers-1 to 0 step-1
    circle xfollower(i),yfollower(i),i,3,((i mod 8)+7)
    'rect xfollower(i),yfollower(i) step 5,i+5,((i mod 8)+7)
    xfollower(i+1)=xfollower(i)
    yfollower(i+1)=yfollower(i)
  next
  xfollower(0)=mx
  yfollower(0)=my
  showpage
  delay 10
wend
