'try rainbow.bas SmallBasic (not M$) Bpf 2015-03-23 challenge PeterMaria and D

toc=ticks
color 0,9:cls
midx=int(xmax/2)
midy=int(ymax/2)

for rbcolor=15 to 0 step -1
  r=Int(((rbcolor+1)/16)*midy)
  circle midx,midy,r color rbcolor filled
next
rect 1,midy,xmax,ymax,10 filled
tic=ticks
? tic-toc;" ms"
? "In D units that's ";dtime