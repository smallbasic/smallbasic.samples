
''' 17.06.2004
'' Save Screen Procedures v2.0 with simple Compression Algorithm
'' a very primitive but maybe usefull way to save screen areas to file
'' (C) 2004 by Carsten (contact: SMALLBasic Forum)

''Draw Testpicture
testpicture
?"Saving Screen Area"
rect 299,199,451,351

SaveScreenC "..\\testpicture.sbb",300,200,450,350

cls
?"Loading Screen Area"

LoadScreenC "..\\testpicture.sbb"

end




''***********************************************
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
'' Here are the Save and Load Routines
'' you can use in your programms
''********************************************

''********************************************
'' Save Compressed Screen
'' Needs: Filename, x, y, x1, y1
'' coordinates as in RECT
''********************************************
sub SaveScreenC (Filename,fromx,fromy,tox,toy)
local x,y,dx,dy,colcount,oldcol,h

if fromx>tox
swap fromx,tox
fi
if fromy>toy
swap fromy,toy
fi

dx=tox-fromx
dy=toy-fromy

open Filename for output as #1

print #1,"SBSCREENCOMP"
print #1,dx
print #1,dy

for y=fromy to toy
 colcount=1
 oldcol=point(fromx,fromy)
 for x=fromx+1 to tox
 h=point(x,y)
 if (h=oldcol and x<tox)
  colcount++
 else
 ?#1,colcount
 ?#1,oldcol
 colcount=1:oldcol=h
 fi
 next x
next y
close #1

'' this is done for windows ...
chmod Filename, 0o666
end

''********************************************
''Load Compressed Screen
''Needs: Filename
''********************************************

sub LoadScreenC(Filename)
local x,y,c,cc

open Filename for input as #1
input #1,name
''is it a sbscreen compressed file?
if name="SBSCREENCOMP"
input #1,xr
input #1,yr
for y=0 to yr
  x=0
  repeat
   input #1,cc
   input #1,c
   line x,y,x+cc,y,c
   x=x+cc
  until (x>=xr or eof(1))
 next y
fi
close #1
end


'
