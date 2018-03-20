'bpf1.bas in SmallBASIC (not MS), B+ 2015-04-02 
wc=ymax/2:div=32:color 0,15:cls:locate 23,45:? "Enter"
while k="":k=inkey:wend:color 15,9:cls
for i=1 to div
  c=0 :r= wc*(div-i+1)/div 
  if i mod 2 then
    for phi=0 to pi/2 step 0.1
      c=c+1 
      x2=int(wc+r*sin(phi)):y2=int(wc+r*cos(phi))
      x1=int(wc-r*sin(phi)):y1=int(wc-r*cos(phi))
      if  c mod 2 then c1=11 else c1=15
      rect x1,y1,x2,y2,c1 filled
    next phi
  else
    for phi=0 to pi/2 step 0.1
      c=c+1
      x2=int(wc+r*sin(phi)):y2=int(wc+r*cos(phi))
      x1=int(wc-r*sin(phi)):y1=int(wc-r*cos(phi))
      if c mod 2 then c1=14 else c1=10 
      rect x1,y1,x2,y2,c1 filled
    next phi
  endif 
next i
bpf$="BASIC programming forum"
locate 1,3:? bpf$:locate 1,70:? bpf$
locate 43,3:? bpf$:locate 43,70:? bpf$