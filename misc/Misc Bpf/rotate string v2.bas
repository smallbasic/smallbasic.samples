'rotate string v2.bas 2015-06-07 B+
'   my kata is to make this practice interesting
phrase="She sells seashells by the seashore."
phrase=phrase+" See the shells she sells off a silly shelf."
phrase=phrase+" Surely she sells seashore shells...  "
phrase=ucase(phrase)
d=len(phrase)
banner="Hi Richey and Bpf! This is *rotate string v2.bas* SmallBasic 2015-06-06 B+   "
lb=len(banner)
bx=(680-txtw(banner))/2
xc=680/2 : yc=680/2 : r=.9*yc
color 14,0
acc=.75 : cut=lb
repeat
   cls
   print "to quit: <q> <esc> or <spacebar>"
   color 11,0
   at bx,yc:print mid(banner+left(banner,cut),cut+1)
   color 14,0
   cut+=1
   cut=(cut mod lb) +1
   dim x(d)
   dim y(d)
   dm=d-1
   for i=0 to dm
      t=cos((i/d+acc)*2*pi)
      x(i)=xc+t*r
      t=sin((i/d+acc)*2*pi)
      y(i)=yc+t*r
   next
   for i=0 to dm
      at x(i),y(i): print mid(phrase,i+1,1)
   next
   acc=acc-.85/d
   delay 90
   k=inkey
until (len(k)=1 and asc(k)=27) or k="q" or k=" "
locate 0,0:? space(33)
locate 0,0:? "Goodbye!"