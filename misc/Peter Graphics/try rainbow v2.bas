'try rainbow V2.bas SmallBasic (not M$) Bpf 2015-03-23 4:18 PM challenge PeterMaria and D
'PeterMaria checked me on the sloppy text overlapping the beautiful rainbow
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
color 0,10
locate 30,1: ? tic-toc;" ms";
locate 31,1: ? "In D units that's ";dtime