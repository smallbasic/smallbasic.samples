
'#sec:Main
'' Mach IAS.bas
'' 13/02/2002
cls
?"MACH NUMBER, IAS, TAS"
?
input "OAT deg C";oat
input"P Alt (flt lev)";palt
palt=palt*100
input"IAS kts";ias
dp=29.92*((1+0.2*(ias/661.67)^2)^3.5-1)
p=29.92*(1-6.87535*10^-6*palt)^5.2561
cs=38.9793*sqr(oat+273.15)
mach=(5*((dp/p+1)^(2/7)-1))^0.5
tas=mach*cs
tat=oat+.999*tas^2/7592
machone=cs
stdtmp=15-.0019812*palt
cls

?"MACH NO.  IAS/TAS"
locate 3,1

?"OAT "
?"P Alt "
?"IAS "
?"TAT="
?"MACH NO="
?"TAS="
?"MACH 1="
?"STD TMP="

LOCATE 3,12
?ROUND(OAT,1);" deg C"
LOCATE 4,12
?palt;" ft"
LOCATE 5,12
?ias;" kts"
LOCATE 6,12
?ROUND(tat,1);" deg C"
LOCATE 7,12
?ROUND(mach,3);" M"
LOCATE 8,12
?ROUND(tas,1);" kts"
LOCATE 9,12
?ROUND(machone,1);" kts"
LOCATE 10,12
?ROUND(stdtmp,1);" deg C"

pause 30
'
