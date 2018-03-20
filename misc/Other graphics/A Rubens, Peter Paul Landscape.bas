'A Rubens, Peter Paul Landscape.bas for SmallBASIC 2015-08-13 MGA/B+
' inspired by a Master (or two or 3 or more)
' translated to SmallBASIC from Aurels code copied BPF 2015-08-13

width=xmax:height=ymax
while 1
color 0,15:cls
for i=0 to 128
   skycolor=rgb(120,120,200-i)
   line 0, i,xmax,i,skycolor
next
for i=129 to ymax
   lakecolor=rgb(0,rnd*20+100-.1*i,rnd*20+100-.1*i)
   line 0,i,xmax,i,lakecolor
next
start=100
rr=70:gg=90:bb=70
for mountains= 1 to 6
   offset=0
   y=start
   repeat
      factor = (RND*9-4)/2
      offrand=offset+rnd*7
      for x=offset to offrand
         y=y +factor
         txcolor=rgb(rr,gg,bb)
         line x,y,x,height,txcolor
      next
      offset=x
    until offset>=width
    rr=rr-20:gg=gg-10:bb=bb-19
    if rr<0 then rr=0
    if gg<0 then gg=0
    if bb<0 then bb=0
    start=start+(20+RND*40)
NEXT mountains
pause 5
wend
