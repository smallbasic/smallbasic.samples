'T tile.bas smallBASIC 2015-04-27 B+    
sub t1(x,y)
   rect x,y step 50,50,12 filled
   rect x,y+20 step 10,10,9 filled
   rect x+20,y step 10,50,9 filled
   rect x+40,y+20 step 10,10,9 filled
end
sub t2(x,y)
   rect x,y step 50,50,12 filled
   rect x,y+20 step 50,10,9 filled
   rect x+20,y step 10,10,9 filled
   rect x+20,y+40 step 10,10,9 filled
end
for x=0 to 750 step 50
   for y=0 to 550 step 50
      if rnd<.5 then t1 x,y else t2 x,y
   next
next      
