'Lava 3.bas SmallBASIC 2015-04-25
dm=220
dim xr(1 to dm), yr(1 to dm), rr(1 to dm), ar(1 to dm),cr(1 to dm)
RANDOMIZE TIMER
for k = 1 to dm
     xr(k) = int(rnd*580)+10
     yr(k) = int(rnd*390)+5
     rr(k) = int(rnd*4)+3
     ar(k) = rnd*.6
     s = int(rnd*64)+192
     n=int(rnd*7)
     if n=0 then
        c=rgb(0,0,0)
     elif n=1
        c=rgb(s,255-s,0)
     elif n=2
        c=0
     elif n=3
        c=rgb(s,0,0) 
     elif n=4
        c=rgb(s,255-s,0)
     elif n=5 or n=5
        c=rgb(0,255,0)
     elif n=6
        c=rgb(255,0,0)
     fi
     cr(k)=c
next k     
rect 0,0,600,400,0
REPEAT 
   s = int(rnd*64)+192
   n=Int(rnd*7)
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
   elif
      c=rgb(255,0,0)
   fi   
   xp = INT(RND * 598)+1
   yp = INT(RND * 398)+1
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
   for k=1 to dm
      n=Int(rnd*7)
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
      elif n=5
         c=rgb(s,255,0)
      elif n=6
         c=rgb(255,255-s,0)
      fi
      circle xr(k),yr(k),rr(k),ar(k),c filled
      xr(k)=xr(k)+Int(rnd*10)
      if xr(k)>590 then xr(k)=10
      ud=int(rnd*2)
      if ud=0 then yr(k)=yr(k)-int(rnd*5)-3 :if yr(k)<5 then yr(k)=395
      if ud=1 then yr(k)=yr(k)+int(rnd*5)+3: if yr(k)>395 then yr(k)=5
      circle xr(k),yr(k),rr(k),ar(k),cr(k) filled
   next k   
UNTIL LEN(INKEY$)

  