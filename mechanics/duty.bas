
'#sec:Main
'' Time.bas
'' 18/01/2002
cls
c=0
label rep
k=inkey
if len(k)<>2 then goto rep
if c=0 then t1=ticks:cls:c=1:? t1:goto sue
if c=1 then t2=ticks:c=2:? t2:goto sue
if c=2 then t3=ticks:c=0:? t3:goto cal
label sue
k2=inkey:if len(k2)=2 then goto sue
goto rep
label cal
om=(t2-t1)/100
olf=(t3-t2)/100
tot=(t3-t1)/100
du=(om/tot)*100
?
? "On=",om
? "Off=",olf
? "Duty cycle=",du
goto rep
'
