'T tile 4.bas smallBASIC 2015-04-27 B+    
sub t1(x,y,sc,c1,c2) 'down
   rect x,y step sc,sc,c1 filled
   rect x,y+.4*sc step .2*sc,.2*sc,c2 filled
   rect x+.4*sc,y step .2*sc,sc,c2 filled
   rect x+.8*sc,y+.4*sc step .2*sc,.2*sc,c2 filled
end
sub t2(x,y,sc,c1,c2) 'hori
   rect x,y step sc,sc,c1 filled
   rect x,y+.4*sc step sc,.2*sc,c2 filled
   rect x+.4*sc,y step .2*sc,.2*sc,c2 filled
   rect x+.4*sc,y+.8*sc step .2*sc,.2*sc,c2 filled
end
sub t3(x,y,sc,c1,c2) 'ends
   rect x,y step sc,sc,c1 filled
   rect x,y+.4*sc step .2*sc,.2*sc,c2 filled
   rect x+.4*sc,y step .2*sc,.2*sc,c2 filled
   rect x+.4*sc,y+.8*sc step .2*sc,.2*sc,c2 filled
   rect x+.8*sc,y+.4*sc step .2*sc,.2*sc,c2 filled
end
sub t4(x,y,sc,c1,c2) 'cross
   rect x,y step sc,sc,c1 filled
   rect x,y+.4*sc step sc,.2*sc,c2 filled
   rect x+.4*sc,y step .2*sc,sc,c2 filled
end
sub meta_t1(xoff,yoff)
   local sc,c1,c2,x,y,flip
   sc=5:c1=rgb(0,64,0):c2=rgb(0,220,220)
   for x=xoff to xoff+4*sc step sc
      for y=yoff to yoff+4*sc step sc
         flip=rnd
         if flip<.1 then 
            t4 x,y,sc,c1,c2
         elif flip<.5
            t3 x,y,sc,c1,c2
         elif flip<.75
            t2 x,y,sc,c1,c2
         else
            t1 x,y,sc,c1,c2   
         fi     
      next 
   next  
end   
sub meta_t2(xoff,yoff)
   local sc,c1,c2,x,y,flip
   sc=5:c1=rgb(255,0,0):c2=15
   for x=xoff to xoff+4*sc step sc
      for y=yoff to yoff+4*sc step sc
         flip=rnd
         if flip<.05 then 
            t4 x,y,sc,c1,c2
         elif flip<.2
            t3 x,y,sc,c1,c2
         elif flip<.6
            t2 x,y,sc,c1,c2
         else
            t1 x,y,sc,c1,c2   
         fi      
      next
   next  
end
sub meta_t3(xoff,yoff)
   local sc,c1,c2,x,y,flip
   sc=25:c1=9:c2=15
   for x=xoff to xoff+4*sc step sc
      for y=yoff to yoff+4*sc step sc
         flip=rnd
         if flip<.1 then 
            t4 x,y,sc,c1,c2
         elif flip<.2
            t3 x,y,sc,c1,c2
         elif flip<.9
            t2 x,y,sc,c1,c2
         else
            t1 x,y,sc,c1,c2   
         fi      
      next
   next  
end   
sub meta_t4(xoff,yoff)
   local sc,c1,c2,x,y,flip
   sc=25:c1=9:c2=15
   for x=xoff to xoff+4*sc step sc
      for y=yoff to yoff+4*sc step sc
         flip=rnd
         if flip<.1 then 
            t4 x,y,sc,c1,c2
         elif flip<.2
            t3 x,y,sc,c1,c2
         elif flip<.3
            t2 x,y,sc,c1,c2
         else
            t1 x,y,sc,c1,c2   
         fi      
      next
   next  
end
'========================= main 
for i= 1 to 4
   read omx,omy,p
   mx=omx:my=omy
   for j=1 to 25
      if mid(p,j,1)="0" then
         meta_t1 mx,my
      else
         meta_t2 mx,my
      fi
      mx=mx+25 
      if mx mod 125=0 then my=my+25: mx=omx      
   next
next
meta_t3 125,0
meta_t3 125,250
meta_t4 0,125
meta_t4 250,125
t4 125,125,125,15,12
while asc(inkey)<>27
  flip=rnd
  c1=int(rnd*16):c2=15-c1
  if flip<.25 then
     t1 375,0,375,c1,c2
  elif flip<.5 
     t2 375,0,375,c1,c2
  elif flip<.75 
     t3 375,0,375,c1,c2
  else
     t4 375,0,375,c1,c2
  fi
  pause 3
wend
end
data 0,0,"0010000100111110010000100"
data 250,250,"0010000000100010000000100"
data 250,0,"0010000000111110000000100"
data 0,250,"0010000100101010010000100"