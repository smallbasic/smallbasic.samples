
'current file title: mouse circle sounds.bas
'original title squeaky mouse.bas SmallBASIC 2015-04-27 B+
'old on-line title: circles
'now more sound effects, color contrast, c=cls screen option

randomize
while 1
  locate 0,0
  ?"press c to clear screen clutter"
  if inkey="c" then cls
  delay 60
  pen on
  x=pen(10)
  y=pen(11)
  delay 10
  pen off
  r=rnd*100
  rd=(x/xmax)*255
  if rd>255 then rd=255
  if rd<0 then rd=0
  gr=255-(y/ymax)*255
  if gr>255 then gr=255
  if gr<0 then gr=0
  sound 150+y/ymax*5000,x/xmax*1500
  circle x,y,r,1,rgb(rd,gr,0)
  showpage
  delay 10
wend