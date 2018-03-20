
'#sec:Main
100 input "Ganancia ? (10)",kp:if (kp=0) then kp=10
110 input "Integracion?(5) ",ti:if (ti=0) then ti=5
120 input "Factor Derivativo? (1) ",td:if (td=0) then td=1
121 input "Referencia? (50)",rf:if (rf=0) then rf=50
122 kp=kp/10:ti=ti/10:td=td/10
140 input "Acceleracion? (100)",ac:if (ac=0) then ac=100
150 input "Desaceleracion? (100)",de:if (de=0) then de=100
180 x=0:ra=0:rao=0:cn=0
181 color 9
182 cls:?"PID por J.MaturanaV":c=0
184 for y=159 to 59 step-10
185 color c
186 line 0,y,159,y:c=c+1
188 next y
200 color 0
201 a$=str$(kp*10)+" "+str$(ti*10)+"  "
202 a$=a$+str$(td*10)+" "+str$(rf)+" "
203 a$=a$+str$(ac)+" "+str$(de)+"    "   
204 at 0,0:print a$
206 mx=int(rf)
210 mi=int(rf):cx=0:ci=0
220 if (rf> ra) then let cb=1
225 if (rf< ra) then let cb=-1
230 t=1:s=0
240 ea=rf-ra:e=rf-ra
250 s=e+s:x=x+1:if (x> 159) then x=0:goto 200
251 if s> 128 then s=128
252  if s< -128 then s=-128
260 u=kp*(e+(s/ti)+((e-ea)/t)*td)
282 if (u> 128) then u=150
284 if (u< -128) then u=-150
290 ea=e
300 if (u> 0) then let xu=(u*0.1)*(ac/100) :goto 320
305 if (u< 0) then let xu=(u*0.1)*(de/100) :goto 320
310 xu=(u*0.1)
320 rao=ra:ra=ra+xu
321 if ((cb=1) and (ra> rf) and (cx=0)) then let cx=1
322 if ((cb=-1) and (ci=1) and (ra> rf)) then let cx=1
323 if ((cx=1) and (ra> rf) and (ra> mx)) then let mx=int(ra)
324 if ((cb=-1) and (ra< rf) and (ci=0)) then let ci=1
325 if ((cb=1) and (cx=1) and (ra< rf)) then let ci=1
326 if ((ci=1) and (ra< rf) and (ra< mi)) then let mi=int(ra)
330 uu=int(u*10)/10
332 rr=int(ra*10)/10
335 if ((rf-ra)> 0.3) then let cn=cn+1
336 if ((ra-rf)> 0.3) then let cn=cn+1
340 a$=str$(cn)+" "
350 a$=a$+str$(int(u))+" "+str$(int(mi))+"  "+str$(int(mx))+"    "
355 at 0,16:print a$
357 line x,159-ra,x-1,159-rao
358 g$=inkey$
360 if g$="k" then input "Nuevo kp?",kp:kp=kp/10:goto 180
361 if g$="h" then gosub 1000
364 if g$="i" then input "Nuevo ti?",ti:ti=ti/10:goto 180
368 if g$="d" then input "Nuevo td?",td:td=td/10:goto 180
370 if g$="a" then input "Nueva aceleracion?",ac:goto 180
374 if g$="b" then input "Nueva desaceleracion?",de:goto 180
375 if g$="c" then goto 180
380 if g$="e" then goto 100
383 g=val(g$)
384 if g< 1 or g> 9 then 240
385 rf=g*10
390 goto 240
1000 cls:color 9:?"Ayuda":color 0
1010 ?"K-ancho de banda"
1020 ?"I-factor integrativo"
1030 ?"D-derivativo"
1040 ?"A-aceleracion"
1050 ?"B-desaceleracion"
1060 ?"C-reinicia"
1070 ?"numeros 1 a 9 referencia"
1080 pause
1100 goto 180
'
