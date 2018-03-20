
'''mandel v 3.0 
''Carsten 
''based on 
''>mandel v 2.0 
''>#jfox@airmail.net 
st=TIMER 
CLS 
maxcolor=16 
leftside=-2 
top=1.25 
xside=2.5 
yside=-2.5 
xscale=xside/xmax 
yscale=yside/ymax 
FOR y=1 to ymax/2 
mc=0 
mx=1 
FOR x=1 to xmax 
cx=x*xscale+leftside 
cy=y*yscale+top 
zx=0 
zy=0 
zxx=0 
zyy=0 
colorcounter=0 
WHILE (zxx+zyy<4 and colorcounter<maxcolor) 
tempx=zxx-zyy+cx 
zy=2*zx*zy+cy 
zx=tempx 
colorcounter++ 
zxx=zx*zx 
zyy=zy*zx 
WEND 
IF (colorcounter<>mc OR x=xmax) 
hy=ymax-y 
LINE mx,y,x,y color mc 
LINE mx,hy,x,hy color mc 
mc=colorcounter 
mx=x 
FI 
NEXT 
NEXT 
et=TIMER 
BEEP 
PEN ON 
REPEAT:UNTIL PEN(0) 
PEN OFF 
?"Runtime ";et-st'
