
'#sec:Main
'' rena.bas
'' 04/05/2002
 ? CHR$(27)+"[8"+chr$(54)+"m";
for i=1 to 1000
color c
c=c+1
if c=16 then c=0
print i;''    '';
''beep
for j= 1 to 100:next j
next i
'
