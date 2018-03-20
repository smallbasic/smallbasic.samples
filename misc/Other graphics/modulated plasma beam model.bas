'modulated plasma beam model.bas SmallBASIC Bpf 2015-09-20 MGA/B+
color 15,0:cls
pen on
while 1
   cls
   'flying
   mx=pen(4):my=pen(5)
   'model
   circle mx,my-10,30,.1,8 filled
   for cr=10 to 1 step -1
      cc=rgb(255-25*cr,255-25*cr,255-25*cr)
      circle mx,my-10,cr,1,cc filled
   next
   'modulation
   r+=.2:g+=.005:b+=.010
   if r>.5 then r=.02
   if g>.5 then g=.005
   if b>.5 then b=.01
   'beam 
   for y=my to ymax
      plasma=RGB(127+127*sin(r*y),127+127*sin(g*y),127+127*sin(b*y))
      line mx-2*my/ymax*(y-my),y,mx+2*my/ymax*(y-my),y,plasma
   next
   delay 15
wend
pen off