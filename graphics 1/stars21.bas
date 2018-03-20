
''' Program: Stars.bas
'' Author: Alberto Fornasari
'' Version: 2.1
'' Date: 22/06/2002
'' =================

'' Useful constants
'' ===========
reset=chr$(27)+"[0m"
boldOn=chr$(27)+"[1m"
boldOff=chr$(27)+"[21m"

'' General introduction and main input
'' ========================
label Start
Frame=YMAX-16
gosub InitialFrame
at 35,20
? boldOn+"Program: STARS"+boldOff
at 17,50
? "--------- Version 2.1 ----------"
at 17,60
? "AlbertoFornasari@hotmail.com"
at 17,90
? "Draw stars with N sharp points."
at 17,100
? "With N  integer greater than 2."
at 17,110
? "After drawing, strike  any key."
at 17,YMAX-11
sound 440,100,25
N=0
input "Enter N to start or 0 to QUIT: ",N
N=int(N)
if N=0 then goto Quit
if N<3 then N=3

'' Central circle drawing
'' ===============
Frame=YMAX-1
gosub InitialFrame
Xc=int((XMAX-1)/2)
Yc=int((YMAX-1)/2)
Ofset=11
Radius=Yc-Ofset
circle Xc,Yc,Radius color 15 filled
circle Xc,Yc,Radius color 0

''Analysis and drawing
'' ==============
if (N MOD 2)=0 then
	N=N/2
	Sign=-1
	gosub DrawStar
	endif
Sign=1
gosub DrawStar

'' Ending and waiting for restart
'' ====================
sound 880,100,25
pause
goto Start

'' Quiting
'' =====
label Quit
? reset
cls
stop

'' === Subroutines ===

'' Soubroutine InitialFrame
'' =================
Label InitialFrame
? reset
cls
rect 0,0,XMAX-1,Frame color 9 filled
rect 0,0,XMAX-1,Frame color 0
return

''Soubroutine DrawStar
'' ===============
Label DrawStar
'' Initial conditions (loop preparation)
A=PI/2/N
B=A
Q=2*Radius*cos(A)
X=Xc
Y=Yc-Sign*Radius 
line X,Y,X,Y
'' Lines drawing loop
for i=1 to N
	X=X+Sign*Q*sin(B)	
	Y=Y+Sign*Q*cos(B)
	line round(X),round(Y)
	B=B+PI+2*A
	next i
return

'' ======
end
'
