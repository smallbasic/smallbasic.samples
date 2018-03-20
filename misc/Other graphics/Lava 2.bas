'Lava B+ style.bas SmallBASIC 2015-04-24
'another glitch with Paint found, fix is to exit program and restart
'first job was to contain paint to drawing area turns out the circles
' were poking holes on borders of black
RANDOMIZE TIMER
rect 0,0,640,480,0
REPEAT
   k=k+1:if k>1000 then k=0
   dCircles
   s = int(rnd*64)+192
   n=k mod 6
   if n=0 then
      c=rgb(s,0,0)
   elif n=1
      c=rgb(s,255-s,0)
   elif n=2
      c=0
   elif n=3
      c=rgb(s,0,0) 
   elif n=4
      c=rgb(s,255-s,0)
   elif n=5 or n=5
      c=rgb(s,255,0)
   fi   
   xp = INT(RND * 635)+1
   yp = INT(RND * 475)+1
   PAINT xp, yp, c, 0           
   IF xp =  50 THEN PAINT xp, yp, 0, 0    
   IF xp =  55 THEN PAINT xp, yp, 0, 0
   IF xp =  51 THEN PAINT xp, yp, 0, 0
   IF xp =  52 THEN PAINT xp, yp, 0, 0
   IF xp = 150 THEN PAINT xp, yp, 0, 0
   IF xp = 151 THEN PAINT xp, yp, 0, 0
   IF xp = 152 THEN PAINT xp, yp, 0, 0
   IF xp = 155 THEN PAINT xp, yp, 0, 0
   IF xp = 250 THEN PAINT xp, yp, 0, 0
   IF xp = 450 THEN PAINT xp, yp, 0, 0
   IF xp = 550 THEN PAINT xp, yp, 0, 0
   IF xp = 255 THEN PAINT xp, yp, 0, 0
   IF xp = 355 THEN PAINT xp, yp, 0, 0
   IF xp = 455 THEN PAINT xp, yp, 0, 0
   IF xp = 555 THEN PAINT xp, yp, 0, 0
   IF xp = 251 THEN PAINT xp, yp, 0, 0
   IF xp = 351 THEN PAINT xp, yp, 0, 0
   IF xp = 451 THEN PAINT xp, yp, 0, 0
   IF xp = 551 THEN PAINT xp, yp, 0, 0
   IF xp = 252 THEN PAINT xp, yp, 0, 0
   IF xp = 352 THEN PAINT xp, yp, 0, 0
   IF xp = 452 THEN PAINT xp, yp, 0, 0
   IF xp = 552 THEN PAINT xp, yp, 0, 0
UNTIL LEN(INKEY$)
END
sub dCircles()
   local k,x,y,s,c
   for k = 1 to 110
      x = int(rnd*580)+30
      y = int(rnd*450)+15
      r = int(rnd*10)
      a = rnd*.5
      s = int(rnd*64)+192
      n=k mod 6
      if n=0 then
         c=rgb(s,0,0)
      elif n=1
         c=rgb(s,255-s,0)
      elif n=2
         c=0
      elif n=3
         c=rgb(s,0,0) 
      elif n=4
         c=rgb(s,255-s,0)
      elif n=5 or n=5
         c=rgb(s,255,0)
      fi   
      circle x,y,r,a,c filled  
   next k
end

