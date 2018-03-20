
''' Mira fractals
'' Martin Latter
'' Converted to SB from my old 1992 version in Archimedes BASIC - SB and modern computers thankfully plot a bit faster.
'' (Run/f9 to replot)

dim ca(6)
randomize
a=rnd
b=0.9998
c=2-2*a
dots=12000
x=j=0
y=rnd*12+0.1
col=2

for pc=0 to 5
	ca(pc)=round(rnd*15)
next

for i=0 to dots
	
	z=x
	x=b*y+j
	j=a*x+c*(x^2)/(1+x^2)
	y=j-z

	xp=(x*20)+300
	yp=(y*20)+300

	if i>1000 then col=ca(0)
	if i>3000 then col=ca(1)
	if i>5000 then col=ca(2)
	if i>7000 then col=ca(3)
	if i>9000 then col=ca(4)
	if i>11000 then col=ca(5)

	pset xp,yp,col
	
next i
'
