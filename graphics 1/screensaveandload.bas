
''' 07.06.2004 11:00:27
'' Save Screen Procedures
'' a very primitive but maybe usefull way to save screen areas to file
'' (C) 2004 by Carsten (contact: SMALLBasic Forum)
''
testpicture
?"Saving Screen Area"
rect 300,200,600,400
SaveScreen "..\\testpicture.sbb",300,200,600,400
cls
?"Loading Screen Area"
LoadScreen "..\\testpicture.sbb"
end

''example picture
''Draw HEXAGON
'' hexagon.bas
'' 28/05/2000
sub testpicture
cls
sf=.95
x=(ymax/2)-10:y=0:cx=xmax/2:cy=ymax/2
c=cos(pi/3):s=sin(pi/3)
c1=cos(pi/36):s1=sin(pi/36)

cls

for j=1 to 30
	sx=x+cx:sy=cy-y
	pset sx,sy
	for i=0 to 6
		sx=x+cx:sy=cy-y
		line sx,sy color i*6
		xn=x*c-y*s
		y=x*s+y*c
		x=xn
	next
	xn=sf*(x*c1-y*s1)
	y=sf*(x*s1+y*c1)
	x=xn
next

end

''********************************************
'' Save Screen
'' Needs: Filename, x, y, x1, y1
'' coordinates as in RECT
''********************************************
sub SaveScreen (Filename,fromx,fromy,tox,toy)
local x,y

if fromx>tox
swap fromx,tox
fi
if fromy>toy
swap fromy,toy
fi

open Filename for output as #1
print #1,"SBSCREEN"
print #1,tox-fromx
print #1,toy-fromy
for y=fromy to toy
 for x=fromx to tox
  ?#1,point(x,y)
 next x
next y
close #1

'' this is done for windows ...
chmod Filename, 0o666
end

''********************************************
''Load Screen
''Needs: Filename
''********************************************

sub LoadScreen(Filename)
local x,y

open Filename for input as #1
input #1,name
input #1,xr
input #1,yr
for y=0 to yr
 for x=0 to xr
  input #1,c
  pset x,y,c
 next x
next y

close #1

end'
