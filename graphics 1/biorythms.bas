
'#!/usr/local/bin/sbrun -g
rem Title: biorythms
rem Description: This program was written for the eBookman, but works well
rem on the windows 98 SmallBasic. 
rem Features: Portrait and Landscape Graphic Plotting with colors.
rem           Always plots 31 days from the 1st of the current plot month.
rem           Default mode prompts for Dates, but can program them in.
rem           For speed on the eBookman only 200 or 240 points are plotted
rem           per curve. This was a 10x speed improvement.  Date calculation
rem           is base on functions from TI-58 Master Library, 1977.
rem Version 1.10 fixed some axis color problems and added 4 more curves:
rem           Average, Mastery, Passion, Wisdom (based on averages of P, E,
rem           and I) plotted in individual colors.  You have the capability
rem           of selecting any or all 8 (default) plots or none.</u><br>
 
'' set ask to 
''    0 ask questions
''    1 to bypass questions - set defaults after LABEL start 
''    2 sets current date as birth date 
ask=0 
'' set pmode$ to 
''    "Portrait"  - portrait mode 
''    "Landscape" - landscape mode 
''     ""         - no plot 
pmode$="Landscape" 
pmode$="Portrait" 
''  Set plots$ for which curve
''  P=Physical; E=Emotional; I=Intellectual
''  i=Intutional A=(P+E+I)/3=Average; 
''  M=(I+P)/2=Mastery; p=(P+E)/2=Passion; W=(E+I)=Wisdom
plots$="PEIA"
plots$="PEIiAMpW"
goto start 
'' 8/20/04 9:49:41 PM  
 
LABEL Help 
PRINT "Dave La Rosa - 27 August 2004"
PRINT "             - Version 1.10" 
PRINT "" 
PRINT "   You are first asked to enter the Plot" 
PRINT "Year and Month. Defaults are the current" 
PRINT "Year and Month for the plot." 
PRINT "   Then you are asked Name,Brith-Year/" 
PRINT "Month/Day. You can ask for this help at" 
PRINT "any prompt. " 
PRINT "   After the plot press enter to exit" 
PRINT "program." 
PRINT "   Variables ask and pmode$ and plots$"
PRINT "control the program effects. The default" 
PRINT "plots$ is set to 4 of 8 curves."
PRINT program 
PRINT "" 
r$="" 
RETURN 
FUNC DBD(y,m,d) 
  '' Days Between Dates 
  '' This formula is good from March 1582 
  if m<=2 then 
    DBD=365*y + d + 31*(m-1)              + INT((y-1)/4) - INT(0.75*(INT((y-1)/100)+1)) 
  else  
    DBD=365*y + d + 31*(m-1) - INT(0.4*m+2.3) + INT(y/4) - INT(0.75*(INT((y-1)/100)+1)) 
  endif 
end 
 
LABEL start 
cls
'' Get current Date 
nd$=DATE$ 
''DATE$ - returns the current day as string "DD/MM/YYYY" 
nm=MID$(nd$,4,2)+0 
ny=MID$(nd$,7,4)+0 
nd=MID$(nd$,1,2)+0 
'' Birthday Default information 
bn$="Dave La Rosa" 
by=1582 
bm=3 
bd=17 
'' for testing 
if ask=2 then by=ny 
if ask=2 then bm=nm 
if ask=2 then bd=nd 
if ask!=0 then goto plot 
goto year 
 
LABEL yeare 
PRINT "Year Must be > 1581" 
PRINT "Default=";ny 
 
LABEL year 
PRINT "?=Help" 
PRINT "BioRhythm Enter Plot" 
PRINT "Year [";ny;"]" 
INPUT$ r$ 
if r$="?" then gosub Help 
if r$!="" then ny=INT(r$+0) 
IF ny<1582 THEN goto yeare 
goto nowm 
 
LABEL nowme 
PRINT "1 <= Month <= 12" 
 
LABEL nowm 
PRINT "Month (1-12)[";nm;"]" 
INPUT$ r$ 
if r$="?" then gosub Help 
if r$!="" then nm=INT(r$+0) 
IF nm<1 OR nm>12 THEN goto nowme 
 
LABEL bname 
PRINT "BioRhythm Enter Name" 
PRINT "Name [";bn$;"]" 
INPUT$ r$ 
if r$="?" then gosub Help 
if r$!="" then bn$=r$ 
PRINT "BioRhythm Enter Birth" 
 
LABEL byear 
PRINT "Year [";by;"]" 
INPUT$ r$ 
if r$="?" then gosub Help 
if r$!="" then by=INT(r$+0) 
IF by<1582 THEN goto byear 
 
LABEL bmonth 
PRINT "Month (1-12)[";bm;"]" 
INPUT$ r$ 
if r$="?" then gosub Help 
if r$!="" then bm=INT(r$+0) 
IF bm<1 OR bm>12 THEN goto bmonth 
 
LABEL bday 
PRINT "Day (1-31)[";bd;"]" 
INPUT$ r$ 
if r$="?" then gosub Help 
if r$!="" then bd=INT(r$+0) 
IF bd<1 OR bd>31 THEN goto bday 
 
LABEL plot 
'' double check for ask cases 
IF ny<1582 THEN goto yeare 
IF nm<1 OR nm>12 THEN goto nowme 
IF by<1582 THEN goto byear 
IF bm<1 OR bm>12 THEN goto bmonth 
IF bd<1 OR bd>31 THEN goto bday 
'' set up graph 
cls 
PRINT "" 
PRINT "" 
PRINT "" 
PRINT " ";bn$;" BioRhythm ";nm;"/";nd;"/";ny 
days=DBD(ny,nm,nd)-DBD(by,bm,bd) 
'' calculate current day values for display
   ph= sin(2*PI*(days   )/23)  
   em= sin(2*PI*(days   )/28) 
   il= sin(2*PI*(days   )/33) 
   it= sin(2*PI*(days   )/38) 
   av=(ph+em+il)/3
   ma=(ph+il)/2
   pa=(ph+em)/2
   wi=(em+il)/2
'' flags to check which signals to plot/print
hph=0
hem=0
hil=0
hit=0
hav=0
hma=0
hpa=0
hwi=0
nplots=hph+hem+hil+hit+hav+hma+hpa+hwi
if INSTR(plots$,"P") > 0 then hph=1
if INSTR(plots$,"E") > 0 then hem=1
if INSTR(plots$,"I") > 0 then hil=1
if INSTR(plots$,"i") > 0 then hit=1
if INSTR(plots$,"A") > 0 then hav=1
if INSTR(plots$,"M") > 0 then hma=1
if INSTR(plots$,"p") > 0 then hpa=1
if INSTR(plots$,"W") > 0 then hwi=1
if ymax=239 AND pmode$="Landscape"  then print "" 
color 1 
'' alwasy print Physical/Emotional/Intellectual
s$="" 
if ph>=0 then s$="+" 
PRINT " Physcial     = ";s$;ROUND(ph ,2)
color 2 
s$="" 
if em>=0 then s$="+" 
PRINT " Emotional    = ";s$;ROUND(em ,2)
color 6
if ymax=239 AND pmode$="Portrait" then print "" 
s$="" 
if il>=0 then s$="+" 
PRINT " Intellectual = ";s$;ROUND(il ,2)
color 5 
if hit=0 then goto printa
s$="" 
if it>=0 then s$="+" 
PRINT " Intuituional = ";s$;ROUND(it ,2)
LABEL printa
color 3
s$="" 
if av>=0 then s$="+" 
if hav then PRINT " Average      = ";s$;ROUND(av,2)
color 4
s$="" 
if ma>=0 then s$="+" 
if hma then PRINT " Mastery      = ";s$;ROUND(ma,2)
color 7
s$="" 
if pa>=0 then s$="+" 
if hpa then PRINT " Passion      = ";s$;ROUND(pa,2)
color 8
s$="" 
if wi>=0 then s$="+" 
if hwi then PRINT " Wisdom       = ";s$;ROUND(wi,2)
color 0
if plots$="" then stop
if pmode$="" then stop
 
LABEL plotter 
'' now for plot 
days=DBD(ny,nm,1)-DBD(by,bm,bd) 
x0=xmax/2 
y0=ymax/2 
'' for eBookman a speed up 
xstep=0.1 
ystep=0.1 
if nplots <=2 then goto qplot
if xmax=199 AND OSNAME="EBM" then xstep=1 
if ymax=239 AND OSNAME="EBM" then ystep=1 .
goto cplot
LABEL qplot
xstep=0.75
ystep=0.75
LABEL cplot
if pmode$="Portrait"  then goto portrait 
if pmode$="Landscape" then goto landscape 
''pause 
''stop 
 
LABEL portrait 
'' X-axis 
line 0,y0,xmax,y0 
for i = 1 to 31 
   x=xmax*i/31 
   y1=y0-.01*ymax 
   y2=y0+.02*ymax 
   if (i%5)=0 then y1=y0-.03*ymax 
   if (i%5)=0 then y2=y0+.04*ymax 
   if i=31 then x=xmax-0.01 
   '' highlight todays date 
   if i=nd then line x,0,x,ymax 
   line x,y1,x,y2 
   if (i%5)=0 then AT x-TXTW(i)/2,y2+TXTH(i) 
   if (i%5)=0 then PRINT i 
next i 
'' Y Axis 
line 0,0,0,ymax 
'' Top Tick 
line 0,0.04,xmax/50,0.04 
at xmax/40,0.04+TXTH("+1") 
PRINT "+1" 
line 0,ymax/4,xmax/100,ymax/4 
at xmax/90,ymax/4-TXTH("+0.5")/2 
PRINT "+0.5" 
'' Bottom tick 
line 0,3*ymax/4,xmax/100,3*ymax/4 
at xmax/90,3*ymax/4-TXTH("-0.5")/2 
PRINT "-0.5" 
line 0,ymax-0.04,xmax/50,ymax-0.04 
at xmax/30,ymax-0.04-1.4*TXTH("-1") 
PRINT "-1";
'' 0 black 
'' 1 red 
'' 2 green 
'' 3 brown 
'' 4 blue 
'' 5 magenta 
'' 6 cyan 
'' 7 white 
for x=0 to xmax-1 step xstep 
   i=x*31/xmax 
   age=i-1+days
   ''Physical 
   ph= sin(2*PI*age/23)  
   if hph then pset x,y0-ph*y0 color 1 
   ''Emotional 
   em= sin(2*PI*age/28) 
   if hem then pset x,y0-em*y0 color 2 
   ''Intellectual 
   il= sin(2*PI*age/33) 
   if hil then pset x,y0-il*y0 color 6 
   ''Intuitional 
   it= sin(2*PI*age/38) 
   if hit then pset x,y0-it*y0 color 5 
   ''print age,i,ph,em,il,it 
   av=(ph+em+il)/3
   ma=(ph+il)/2
   pa=(ph+em)/2
   wi=(em+il)/2
   if hav then pset x,y0-av*y0 color 3
   if hma then pset x,y0-ma*y0 color 4
   if hpa then pset x,y0-pa*y0 color 7
   if hwi then pset x,y0-wi*y0 color 8
next i 
pause 
stop 
 
LABEL landscape 
'' This makes top of screen the y axis 
'' X-axis 
line x0,0,x0,ymax 
for i = 1 to 31 
   y=ymax*i/31 
   x1=x0-.01*xmax 
   x2=x0+.02*xmax 
   if (i%5)=0 then x1=x0-.03*xmax 
   if (i%5)=0 then x2=x0+.04*xmax 
   if i=31 then y=ymax-0.01 
   '' highlight todays date 
   if i=nd then line 0,y,xmax,y 
   line x1,y,x2,y 
   if (i%5)=0 then AT x2+TXTW(i),y-TXTH(i)/2 
   if (i%5)=0 then PRINT i;
next i 
'' Y Axis 
line 0,0,xmax,0 
'' Top Tick 
line xmax-0.04,0,xmax-0.04,10 
at xmax-0.04-TXTW("+1"),TXTH("+1")/2 
print "+1";
line 3*xmax/4,0,3*xmax/4,5 
at 3*xmax/4-TXTW("+0.5")/2,TXTH("+0.5")/2
print "+0.5"; 
'' Bottom tick 
line xmax/4,0,xmax/4,5 
at xmax/4-TXTW("-0.5")/2,TXTH("-0.5")/2 
print "-0.5";
line 0,0,0,10 
at 0+TXTW("-1")/2,TXTH("-1")/2 
print "-1";
for y=0 to ymax-1 step ystep 
   i=y*31/ymax 
   age=i-1+days
   ''Physical 
   ph= sin(2*PI*age/23)  
   if hph then pset x0+ph*x0,y color 1 
   ''Emotional 
   em= sin(2*PI*age/28) 
   if hem then pset x0+em*x0,y color 2 
   ''Intellectual 
   il= sin(2*PI*age/33) 
   if hil then pset x0+il*x0,y color 6 
   ''Intuitional 
   it= sin(2*PI*age/38) 
   if hit then pset x0+it*x0,y color 5 
   ''print i,ph,em,il,it 
   av=(ph+em+il)/3
   ma=(ph+il)/2
   pa=(ph+em)/2
   wi=(em+il)/2
   if hav then pset x0+av*x0,y color 3
   if hma then pset x0+ma*x0,y color 4
   if hpa then pset x0+pa*x0,y color 7
   if hwi then pset x0+wi*x0,y color 8
next i 
pause 
'
