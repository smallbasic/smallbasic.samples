'I am a fan 2.bas SmallBASIC 2015-04-21 B+
'of Peter's vacuum that sucks!
rect 0,0,800,400,0 filled
while 1  
   for i=1 to 18 
      if i mod 2 then
         circle 200 + cos(i+a)*i*10,200 + sin(i+a)*i*10,i,1,9 filled
         circle 600 + cos(i+a1)*i*10,200 + sin(i+a1)*i*10,i,1,9 filled
      else
         circle 200 + cos(i+a)*i*10,200 + sin(i+a)*i*10,i,1,12 filled
         circle 600 + cos(i+a1)*i*10,200 + sin(i+a1)*i*10,i,1,12 filled
      fi   
   next
   delay .5
   a+=.1 '.1 fan, .01 fan2, 1.0 fan3
   a1+=.04
   rem another fine thing is: a = a+0.01
   if a >=360 then a = -a
   k=inkey
   if asc(k)=27 then locate 20,120: ? "Goodbye" :end
wend