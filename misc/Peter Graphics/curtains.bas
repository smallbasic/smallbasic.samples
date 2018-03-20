'ribbons.bas SmallBASIC Bpf 2015-04-16 B+
locate 5,90:? "Press and hold esc to quit"
locate 7,90:? "press any other for next curtain"
locate 9,90
while 1 
   for i=0 to 9
      a = 122:b=rnd^2:c=rnd^2:d=rnd^2
      for y=1 to 60:
         for x=1 to 600
            cl=RGB(a+a*sin(b*x),a+a*sin(c*x),a+a*sin(d*x))
            pset x,i*60+y,cl
         next x
      next y
   next i
   k=inkey:if asc(k)=27 then ? "esc detected, good bye":end
   pause 5
wend


