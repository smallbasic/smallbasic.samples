'Pladz.bas SmallBASIC Bpf 2015-04-16 B+
locate 5,90:? "Press and hold esc to quit"
locate 7,90:? "press any other for next curtain"
locate 9,90
while 1 
   a = 122:b=rnd^2:c=rnd^2:d=rnd^2
   for y=1 to 600:
      for x=1 to 600
         cl=RGB(a+a*sin(b*x),a+a*sin(c*x),a+a*sin(d*x))
         pset x,y,cl
      next x
   next y
   for x=1 to 600 step 2
      for y=1 to 600
         cl=RGB(a+a*sin(b*y),a+a*sin(c*y),a+a*sin(d*y))
         pset x,y,cl
      next y
   next x  
   k=inkey:if asc(k)=27 then ? "esc detected, good bye":end
   pause 5
wend


