
'AI.bas
''AI.bas
'' 16/09/2002
''Author:Robert Blennerhed
dim ctxt(1000) ''memory
dim btxt(1000) ''memory
antal=0
F=Freefile
rem test if memory.dat exist
if exist("memory.dat") then 
goto 10
else 
goto 20
fi
10 rem load memory
OPEN "memory.dat" FOR INPUT AS #F
INPUT #F, antal
for aa=1 to antal
input #F,ctxt(aa)
input #F,btxt(aa)
next aa
CLOSE #F
goto 15
''***
20 ?"HELP!I HAVE NO MEMORY!CHAT WITH ME":goto 30
15 rem
print" (:-/) HI AGAIN"
110 rem
30 REM
?
input"YOU";atxt:atxt=upper(atxt)
if atxt="BYE" then ?"Ok..SEE YOU":end
if atxt="" then ?"(:-/) WHAT''S UP!":goto 110
for xxx=1 to antal
if atxt=ctxt(xxx) then 180
next xxx
?"(:-/) I DON''T UNDERSTAND YOU!":ctxt(xxx)=upper(atxt)
pause 2
input."(:-/) HOW SHOULD I RESPOND TO THAT?";btxt(xxx):btxt(xxx)=upper(btxt(xxx)):goto 190    
180 ?"(:-/) ";btxt(xxx):btxt(xxx)=upper(btxt(xxx)):goto 110
190 if antal=1000 then
goto 500
else
antal=antal+1
open"memory.dat"for output as #F
print #F,antal
for aa=1 to antal
print #F,ctxt(aa)
print #F,btxt(aa)
next aa
close#F
cls
?"(:-/) OK..THANKS"
pause 2
goto 110
fi
500 rem ''memory.dat'' is filled.
print"I CAN''T LEARN NO MORE"
pause 2
goto 110'
