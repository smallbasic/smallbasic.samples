'Circle trap.bas SmallBasic 2015-05-04 B+
color 15,0 
repeat
   cls:t=timer
   for i=1 to 360
      c=rgb(255-255/360*i,15,31) 
      circle xmax/2 + sin(i*90+t)*200,ymax/2 + cos(i*90+t)*200,20+i,1,c
   next
   while timer=t:wend
until inkey=" "