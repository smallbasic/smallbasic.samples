
'#sec:Main
2000 cls:color 9
2010 print "RESTAS SOLO PARA INTELIGENTES":color 0
3005 for i=1 to rnd(1)*10 : j=rnd(1) :  next i
3040 m=rnd(5)+3
3050 t=rnd(20)+15
3052 gosub 3700:if t=n then 3050
3053 print "Restas entre 1 y ";m
3320 a$="te gane !!!"
3330 b$="tu ganas."
3332 print "SubTotal=";:color 12:? t:color 0
3340 for i=10 to 100
3342 x=100
3350 input  "tu? ";p
3354 if p=0 then gosub 3700:print  "Recomiendo ";r:goto 3350
3364 if p>=1 and p<=m and p<t then 3380
3365 if m<t then let x=m :goto 3367
3366 x=t
3367 if p=t then 3380
3368 gosub 3600:goto 3350
3380 t=t-p
3390 if t=0 then c$=a$ :  goto 3480
3400 c=t-((m+1)*int((t-1)/(m+1))+1)
3410 if c=0 then c=int(1+rnd(m))
3420 if t=1 then c=1
3430 t=t-c
3432 print "Yo=";c
3440 print "SubTotal=";:color 12:? t:color 0
3460 if t=0 then let c$=b$ :  goto 3480
3470 next i
3480 color 9: print c$:pause:color 0
3490 if c$=a$ then g=g+1
3495 if c$=b$ then g=0
3500 if g=10 then print "Seguro quieres seguir jugando?"
3510 if g=20  then print "No te aburres de perder?"
3520 if g=40  then print "Cabreate ya!"
3530 if g=60  then print "No te rindes jamas!"
3540 goto 2000
3600 ? "Entre 1 y ";m; " porfavor!"
3610 return
3700 n=1
3710 n=n+m+1
3720 if n=t then 3750
3730 if n<t then 3710
3740 n=n-m-1
3750 r=t-n
3760 return
'
