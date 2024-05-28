w = window()
w.setfont(8,"px",0,0)

'' form.bas
''''27/02/2002
''sean.nixon(@xtra.co.nz)
''Got the formulas from.......
''http://williams.best.vwh.net/
''

''		Sets Initial Variables (NZWN, NZAA)
fromlat="41 19.8"
fromlon="174 48.6"
tolat="37 00.0"
tolon="174 46.9"
fmns=-1
fmew=-1
tons=-1
toew=-1
kmtoggle= 1
kmnm="NM"
def omod(a,b)=a-b*(a\b)

gosub screen

label peninput

pen on
while pen(0)=0
wend
x=pen(4)
y=pen(5)
pen off

''		N S E W Toggle
if x>=125:if x<=140
  if y>=20:if y<=35
    fmns=fmns*-1
  endif:endif
  if y>=40:if y<=55
    fmew=fmew*-1
  endif:endif
  if y>=60:if y<=75
    tons=tons*-1
  endif:endif
  if y>=80:if y<=95
    toew=toew*-1
  endif:endif
endif:endif
''		Lat / Lon input
if x>=80:if x<=120
  if y>=20:if y<=35
    rect 40,140,120,155
    at 43,142
    ?"";
    input fromlat
  endif:endif
  if y>=40:if y<=55
    rect 40,140,120,155
    at 43,142
    ?"";
    input fromlon
  endif:endif
  if y>=60:if y<=75
    rect 40,140,120,155
    at 43,142
    ?"";
    input  tolat
  endif:endif
  if y>=80:if y<=95
    rect 40,140,120,155
    at 43,142
    ?"";
    input tolon
  endif:endif
endif:endif
''		KM/NM, Help, End buttons
if x>=10:if x<=30
  if y>=20:if y<=35
    gosub helpscreen
  endif:endif
  if y>=40:if y<=55
    kmtoggle=kmtoggle*-1
    if kmtoggle=-1:kmnm="KM":endif
    if kmtoggle=1:kmnm="NM":endif
  endif:endif
  if y>=60:if y<=75
  end
  endif:endif
endif:endif

gosub screen
goto peninput


label screen
gosub calculate
cls''		Form Layout
rect 80,20,120,35
rect 125,20,140,35
rect 80,40,120,55
rect 125,40,140,55
rect 80,60,120,75
rect 125,60,140,75
rect 80,80,120,95
rect 125,80,140,95
line 40,15,120,15
at 40,3
?"   Great Circle Nav"
at 55,33
?"FROM"
at 60,73
?"TO"
''to/from border
line 75,65,50,65
line 50,65,50,90
line 50,90,75,90
line 75,25,50,25
line 50,25,50,50
line 50,50,75,50

line 5,115,155,115
line 5,135,155,135
at 5,102
?"INITIAL COURSE  ";round(deg(TC),1);" deg. ";round(dist,1);" ";kmnm
at 5,122
?"RHUMBLINE ";round(deg(TCR),1);" deg. ";round(rhumbdist,1);" ";kmnm


rect 10,20,40,35
at 13,23
?"HELP"
rect 10,40,40,55
at 13,43:?"K/NM"

rect 10,60,40,75
at 14,63
?" End"

''fills to/from feilds
at 85,23
?fromlat
at 85,43
?fromlon
at 85,63
?tolat
at 85,83
?tolon

''fills N/S E/W feilds
at 130,23
if fmns=-1
  ?"S"
  elseif fmns=1
  ?"N"
endif
at 130,43
if fmew=-1
  ?"E"
  elseif fmew=1
  ?"W"
endif
at 130,63
if tons=-1
  ?"S"
  elseif tons=1
  ?"N"
endif
at 130,83
if toew=-1
  ?"E"
  elseif toew=1
  ?"W"
endif

return

label helpscreen
cls
?"NSEW buttons tap to toggle"
?
?"KM/NM button toggles"
?"current measure"
?
?"LAT/LON format DD MM.M"
?"Tap feild to enter"

?"e.g. for 40S the valid inputs are"
?"40 00.0, 40 00, 40 0."

?"you must include the space after"
?"the degrees"
?
?"tap tap to exit"

pause 10
return


label calculate

latone=rad(fmns*(leftof(fromlat," ")+rightof(fromlat," ")/60))

lonone=rad(fmew*(leftof(fromlon," ")+rightof(fromlon," ")/60))

lattwo=rad(tons*(leftof(tolat," ")+rightof(tolat," ")/60))

lontwo=rad(toew*(leftof(tolon," ")+rightof(tolon," ")/60))

''greatcircle
gcdist=acos(sin(latone)*sin(lattwo)+cos(latone)*cos(lattwo)*cos(lonone-lontwo))
dist=60*deg(gcdist)
if kmnm="KM" then dist=dist/.539612

tc=omod((atan2(sin(lonone-lontwo)*cos(lattwo),cos(latone)*sin(lattwo)-sin(latone)*cos(lattwo)*cos(lonone-lontwo))), (2*pi))
if tc<=0 
  tc=tc+2*pi
endif

''rhumbline

dlonw=omod((lontwo-lonone), (2*pi))
if dlonw<0 
  dlonw=dlonw+2*pi
endif
dlone=omod((lonone-lontwo), (2*pi))
if dlone<0 
  dlone=dlone+2*pi
endif
dphi=log(tan(lattwo/2+pi/4)/tan(latone/2+pi/4))

if abs(lattwo-latone)<sqr(.0000001)
  q=cos(latone)
  else
  q=(lattwo-latone)/dphi
endif

if dlonw<dlone 
  tcr=omod((atan2(-dlonw,dphi)), (2*pi))
  dr=sqr(q^2*dlonw^2+(lattwo-latone)^2)
  else
  tcr=omod((atan2(dlone,dphi)),(2*pi))
  dr=sqr(q^2*dlone^2+(lattwo-latone)^2)
endif
if tcr<0
  tcr=tcr+2*pi
endif
rhumbdist=60*deg(dr)
if kmnm="KM" then rhumbdist=rhumbdist/.539612
return'
