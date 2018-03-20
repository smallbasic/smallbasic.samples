
'#sec:Main
100 input "Ganancia? (10)",kp:if (kp=0) then kp=10
110 input "Integracion?(5) ",ti:if (ti=0) then ti=5
120 input "Factor Derivativo? (1) ",td:if (td=0) then td=1
121 input "Ancho Disturbac.? (80) ",wd:if (ancho=0) then wd=80
122 kp=kp/10:ti=ti/10:td=td/10
180 rf=40:x=0:ra=40
190 rao=40:amo=40
200 cls
201 a$=str$(kp*10)
202 a$=a$+" "+str$(ti*10)+"  "
203 a$=a$+str$(td*10)
204 locate 0,0:print a$
210 cx=0:ci=0
230 t=2:s=0
240 ea=rf-ra:e=rf-ra
250 s=e+s
255 x=x+1:if (x>159) then goto 358
260 u=kp*(e+(s/ti)+((e-ea)/t)*td)
282 if (u>150) then u=150
284 if (u<-150) then u=-150
290 ea=e
310 xu=(u*0.1)
320 rao=ra:ra=ra+xu
330 uu=int(u*10)/10
332 rr=int(ra*10)/10
350 a$=str$(int(u))+" "+str$(int(rf))
352 a$=a$+"        "
355 at 1,0:print a$
357 color 9:line x,159-ra,x-1,159-rao
358 g$=inkey$:color 0
360 if g$="k" then input "Nuevo kp?",kp:kp=kp/10:goto 180
362 if g$="a" then input "Nuevo ancho?",wd:goto 180
364 if g$="i" then input "Nuevo ti?",ti:ti=ti/10:goto 180
368 if g$="d" then input "Nuevo td?",td:td=td/10:goto 180
375 if g$="a" then goto 180
380 if g$="q" then goto 100
390 mx=40+wd
400 if ((x<40) or (x>mx)) then amo=40:amp=40:goto 420
405 ang=(x-40)*(180/wd)
406 ang=ang/57.29578
410 se=sin(ang)
415 amo=amp:amp=(80*se)+40
416 color 12
420 line x,159-amp,x-1,159-amo
421 color 0
430 rf=amp
500 goto 240

             
'
