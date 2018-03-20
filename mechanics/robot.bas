
'#sec:Main
'' robot.bas
'' 17/02/2002
dim car(30)
pen on
cr=chr$(13)
esc=chr$(27)

for i=1 to 24
read car(i)
next i

bo=chr$(27)+"[1m"
uo=chr$(27)+"[4m"
ro=chr$(27)+"[7m"
bf=chr$(27)+"[21m"
uf=chr$(27)+"[24m"
rf=chr$(27)+"[27m"
open "COM1:19200" AS #1

label menug
gosub maind
label menul
gosub pantamain
if a=1 then goto lrn
if a=2 then print #1,chr$(03);:for i=1 to 5000:next i:print #1,"P0"+cr;
if a=3 then print #1,chr$(03);:for i=1 to 5000:next i:print #1,"PASO"+cr+"01"+cr;
if a=4 then print #1,chr$(03);:for i=1 to 5000:next i:print #1,"P3"+cr;
if a=5 then print #1,chr$(03);:for i=1 to 5000:next i:print #1,"LOOP"+cr;
if a=6 then t="21":goto mint
if a=7 then t="88":goto mint
if a=8 then close #1:cls:stop
goto menul

label mint
print #1,chr$(03);
for i=1 to 3000:next i
print #1,"MINT"+cr;
for i=1 to 3000:next i
gosub inbyte
a$=str$(ib)
print #1,t$+a$+cr+esc+esc;
goto menug

data 1,Q,2,W,3,E,4,R,5,T,6,Y
data F,V,G,B,H,N,A,Z,S,X,D,C


#sec:inbyte
'' inbyte

label inbyte
cls:ib=0
rect 1,1,80,80 color 9 filled
rect 80,1,159,80 color 10 filled
rect 1,80,80,159 color 12 filled
rect 80,80,159,159 color 14 filled
rect 140,1,159,20 color 5 filled 
rect 140,1,159,20 color 15

label iby
locate 8,16
print "   "+ib+"   "
gosub pantaib
if a=1 then ib=ib+1
if a=2 then ib=ib-1
if a=3 then ib=ib+10
if a=4 then ib=ib-10
if a=5 then return
goto iby


label pantaib
a=0
if not pen(0) then return
px=pen(4):py=pen(5)
if px>140 and py<20 then a=5:return
if py>80 then
if px>80 then
a=2:return
else
a=4:return
fi
else
 if px>80 then
a=1:return
else
a=3:return
fi
fi

#sec:learn
'' learn

label lrn
print #1,chr$(03);:for i=1 to 5000:next i
print #1,"LRN"+cr;
motor=1
rect 1,1,50,40 color 10 filled
rect 50,1,100,40 color 11 filled
rect 1,40,50,80 color 12 filled
rect 50,40,100,80 color 13 filled
rect 100,1,159,80 color 14 filled
rect 1,80,50,120 color 10 filled
rect 50,80,105,120 color 10 filled
rect 105,80,159,120 color 10 filled
rect 1,120,50,159 color 12 filled
rect 50,120,105,159 color 12 filled
rect 105,120,159,159 color 12 filled
rect 140,1,159,20 color 5 filled 

rect 140,1,159,20 color 15
rect 1,1,50,40 color 16 
rect 50,1,100,40 color 16 
rect 1,40,50,80 color 16 
rect 50,40,100,80 color 16 
rect 100,1,159,80 color 16
rect 1,80,50,120 color 16 
rect 50,80,105,120 color 16 
rect 105,80,159,120 color 16 
rect 1,120,50,159 color 16 
rect 50,120,105,159 color 16 
rect 105,120,159,159 color 16 
locate 2,6:print "4";
locate 6,6:print "3";
locate 2,16:print "1";
locate 6,16:print "2";
locate 4,25:print "ENTER";
locate 10,6:print "+";
locate 14,6:print "-";
locate 10,16:print "+";
locate 14,16:print "-";
locate 10,27:print "+";
locate 14,27:print "-";


label mainlrn
gosub pantalrn
if mov<>0 then caa=car(((motor- 1)*6)+mov): locate 1,1:print #1,caa:mov=0
if enter<>0 then  locate 1,2:print #1,""+cr;:enter=0
goto mainlrn

label pantalrn
if not pen(0) then goto segend
px=pen(4):py=pen(5)
if px>140 and py<20 then print #1,chr$(27);:goto menug
if py>40 then goto seg2
if px>50 then goto seg12
motor=4:goto segend
label seg12
if px>105 then goto seg13
motor=1:goto segend
label seg13
enter=1:goto segend
label seg2
if py>80 then goto seg3
if px>50 then goto seg22
motor=3:goto segend
label seg22
if px>105 then goto seg23
motor=2:goto segend
label seg23
enter=1:goto segend
label seg3
if py>120 then goto seg4
if px>50 then goto seg32
mov=1:goto segend
label seg32
if px>105 then goto seg33
mov=3:goto segend
label seg33
mov=5:goto segend
label seg4
if px>50 then goto seg42
mov=2:goto segend
label seg42
if px>105 then goto seg43
mov=4:goto segend
label seg43
mov=6
label segend
return

#sec:pantamain
'' pantamain

label pantamain
a=0
if not pen(0) then goto msegend
px=pen(4):py=pen(5)
if py>40 then goto mseg2
if px>80 then goto mseg12
a=1:goto msegend
label mseg12
a=5:goto msegend
label mseg2
if py>80 then goto mseg3
if px>80 then goto mseg22
a=2:goto msegend
label mseg22
a=6:goto msegend
label mseg3
if py>120 then goto mseg4
if px>80 then goto mseg32
a=3:goto msegend
label mseg32
a=7:goto msegend
label mseg4
if px>80 then goto mseg42
a=4:goto msegend
label mseg42
a=8
label msegend
return
#sec:maindraw
'' maindraw
label maind
cls
rect 1,1,80,40 color 1 filled
rect 80,1,159,40 color 6 filled
rect 1,40,80,80 color 9 filled
rect 80,40,159,80 color 10 filled
rect 1,80,80,120 color 11 filled
rect 80,80,160,120 color 12 filled
rect 1,120,80,159 color 13 filled
rect 80,120,159,159 color 14 filled
rect 1,1,80,40 color 16
rect 80,1,160,40 color 16
rect 1,40,80,80 color 16
rect 80,40,159,80 color 16
rect 1,80,80,120 color 16
rect 80,80,159,120 color 16
rect 1,120,80,159 color 16
rect 80,120,159,159 color 16
for i=1 to 2000:next i
locate 2,6:print "LRN";
locate 6,6:print "P0";
locate 10,6:print "PASO 01";
locate 14,6:print "P3";
locate 2,25:print "LOOP";
locate 6,26:print "KP";
locate 10,25:print "VEL";
locate 14,24:print "SALIDA";
return
'
