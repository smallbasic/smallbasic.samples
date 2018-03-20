'bpf2.bas in SmallBASIC (not MS), B+ 2015-04-02 
wc=ymax/2:div=32:color 0,15:cls:locate 23,45:? "Enter"
cl1=rgb(255,255,255):cl2=rgb(200,255,0)
cl3=rgb(255,255,0):cl4=rgb(255,155,0)
while k="":k=inkey:wend:color 15,0:cls
for i=1 to div
  c=0 :r= wc*(div-i+1)/div 
  if i mod 2 then
    for phi=0 to pi/2 step 0.1
      c=c+1 
      x2=int(wc+r*sin(phi)):y2=int(wc+r*cos(phi))
      x1=int(wc-r*sin(phi)):y1=int(wc-r*cos(phi))
      if  c mod 2 then c1=cl1 else c1=cl2
      rect x1,y1,x2,y2,c1 
    next phi
  else
    for phi=0 to pi/2 step 0.1
      c=c+1
      x2=int(wc+r*sin(phi)):y2=int(wc+r*cos(phi))
      x1=int(wc-r*sin(phi)):y1=int(wc-r*cos(phi))
      if c mod 2 then c1=cl3 else c1=cl4 
      rect x1,y1,x2,y2,c1 
    next phi
  endif 
next i
bpf$="BASIC programming forum"
locate 1,3:? bpf$:locate 1,70:? bpf$
locate 43,3:? bpf$:locate 43,70:? bpf$