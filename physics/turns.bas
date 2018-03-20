
'#sec:Main
'' turns.bas
'' 13/02/2002
cls
input"TAS";tas
input"Bank Angle";aob
rateone=57.3*atan(tas/362.1)
feet=tas^2/(11.23*tan(.01745*aob))
metres=feet*2.54*12/100

rate=96.7*tas/feet
acc=1/cos(aob/(180/pi))
nmile=round(metres*.539612/1000,1)
rateone=round(rateone)
feet=round(feet)
metres=round(metres)
rate=round(rate,1)
rateone=round(rateone,1)
acc=round(acc,1)
cls
locate 3,1
?"TAS"
?"Bank Angle"
?"Rate One "
?"Diameter"
?
?"Rate of Turn"
?"Accelleration"

locate 3,15
?tas
locate 4,15
?aob;" deg"
locate 5,15
?rateone;" deg"
locate 6,15
?feet*2;" ft   ";metres*2;" M"
locate 7,15
?nmile*2;" nm"
locate 8,15
?rate;" deg/sec"
locate 9,15
?acc;"G"

pause 30'
