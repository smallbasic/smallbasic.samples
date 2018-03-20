
'''mandel v 2.0
''jfox@airmail.net
CLS
maxcolor=16
leftside=-2
top=1.25
xside=2.5
yside=-2.5
xscale=xside/xmax
yscale=yside/ymax
FOR y=1 to ymax/2
	FOR x=1 to xmax
		cx=x*xscale+leftside
		cy=y*yscale+top
		zx=0
		zy=0
		colorcounter=0
		WHILE (zx*zx+zy*zy<4 and colorcounter<maxcolor)
			tempx=zx*zx-zy*zy+cx
			zy=2*zx*zy+cy
			zx=tempx
			colorcounter=colorcounter+1
		WEND
		PSET x,y color colorcounter
		PSET x,ymax-y color colorcounter
	NEXT
NEXT
BEEP

PEN ON
REPEAT:UNTIL PEN(0)
PEN OFF
'
