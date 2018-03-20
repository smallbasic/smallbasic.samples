
'#sec:Main
'' Time.bas
'' 18/01/2002
cls
c=0
label rep
k=inkey
if len(k)<>2 then goto rep
c1=c2
c2=ticks
d1=60/((c2-c1)/100)
at 0,16:print d1;" Golpes x min                            "
label sue
k2=inkey:if len(k2)=2 then goto sue
goto rep
'
