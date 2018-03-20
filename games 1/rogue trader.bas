
'#sec:Main
''  ROGUE-TRADER BY GARY BREINHOLT  |

siz=1+(xmax>300)
dim FAV(10,3),TURN$(4),CW(10),WAN(10),g(2),FV$(3),SYST$(10),SDET(10,5),SHIP(7),HYPE(10),frgh(10),frs(10),what$(10),who$(10),ecc(10,2),kno(10,2)

for A=1 to 4 : read TURN$(A) : next A
for A=1 to 3 : read FV$(A) : next A
for A=1 to 10 : read SYST$(A),HYPE(A),What$(A),who$(A): next A
11 data "Morning","Afternoon","Evening","Night","Business","Political","Criminal"
data "DAGGER",1,"Alien Items","Leonardo","SWORD",2,"Antique Clocks","Dreyfus","MACE",3,"Archaic Weapons","Sebastian","AXE",3,"Period Costume","Jameson","CAPITAL",4,"Old Books","Miller","VERDANT",5,"Memorabilia","Reynard","DESERT",5,"Rare Crystals","Marlow","DRYAD",6,"Delicacies","Haymer","PIXIE",7,"Vintage Wines","Hodekin","HAVEN",8,"Coffee Beans","Carter"

REPAY=10 : DAY=fix (rnd*365) : TRN=1 : YEAR=2517 : AWAKE=1 : REP=100 : NAME$="" : POS=1 : AGE=fix(rnd*5)+30 : BDAY=fix(rnd*365): CWDAY=20+fix(rnd*70)

for A=1 to 10 : read X,Y,SDET(A,5) : SDET(A,1)=X : SDET(A,2)=Y : SDET(A,3)=X+Y : SDET(A,4)=X+Y+2 : next A 
 data 1,2,4, 2,3,5, 3,4,6, 3,2,4, 4,4,6, 3,4,6, 4,1,4, 2,4,6, 1,3,5, 0,1,7
360  CW(0)=fix(rnd*9) : if sdet(cw(0),4)=10 then 360
 CUR=fix(rnd*5)+2 : 
CURLOC$=SYST$(CUR)
for A=1 to 10 : for C=1 to 2
28 B=fix(rnd*10) : if ecc(B,C)<>0 then goto 28
ecc(B,C)=A : next C : next A

33 cls: ? cat(1);"ROGUE TRADER";cat(-1): ?:? "A Captains goal": ? "was simple:": ?"Get a ship...": ?"Get a job...":? "Keep flying."
 z=2: gosub grid: restore 31: y=1: for x=1 to 2: at 105*siz,y+(5*siz):read n: print n:
y=y+(25*siz): next x
31 data "NEW GAME","LOAD"
32  gosub pick : I=0 : if  A=0 then 33 else on a gosub 450,600
400 gosub 7700: goto 1490

480 locate 9,1: input "NAME CHARACTER:";NAME$ : NAME$=upper$(NAME$) : input "NAME YOUR SHIP:";SHIP(7) : SHIP(7)=upper$(SHIP(7)): return
 450 gosub 480:  gosub 7840 : at 15*siz,132*siz :print "Courier" : at 110*siz,132*siz : print "Trader" :for x= 1 to 2: at (15+((x=2)*95))*siz,142*siz : print x*100;" Ton" : next X :
34 gosub pick2: if A=0  then 34
  for X=1 to a : for y=0 to 6 : read SHIP(y) : next  : next
 data 1,100,30,4,3,"COURIER CLASS",25,2,200,60,8,5,"TRADER CLASS",50

38 fuel=ship(4): LOAN=SHIP(0)*500000 : CREDS=SHIP(4)*1000 :for A=1 to 10 :x=fix(rnd*10): y=fix(rnd*3):FAV(x,y)=fav(x,y)+1 : next A
490 if name$="" then return

 open "pdoc:Rogue" for output as #1
print #1; CREDS;",";LOAN;",";REPAY;",";HULL;",";DAY;",";TRN;",";YEAR;",";AWAKE;",";REP;",";CUR;",";CURLOC$;",";NAME$;",";BH;",";FV;",";ILCHAR;",";CHSS;",";DEST;",";POS;",";AGE;",";BDAY;",";DDAY;",";SDAY;",";CWDAY;",";CHARGO;",";FINE;",";JDAY
print #1;FDEST;",";mis;",";hij;",";cargo;",";psnj;",";pday;",";fuel;",";sp;",";prs;",";Jmp;",";frght;",";weaps;",";wn;",";sj
for A=0 to 7:  print #1;SHIP(A) : next
for A=0 to 10 : print #1;WAN(A);",";CW(A);",";frgh(A);",";frs(A) : next A
for A=0 to 10 : for B=0 to 4 : print #1;SDET(A,B) : next B : next A
for A=0 to 10 : for B=0 to 3 : print #1;fav(A,B): next B : next A
for A=0 to 10 : for B=0 to 2 : print #1;ECC(A,B);",";kno(A,B): next B : next A
close #1 : cls : gm=1: return

600  open "pdoc:Rogue"  for input as #1
input #1;CREDS,LOAN,REPAY,HULL,DAY,TRN,YEAR,AWAKE,REP,CUR,CURLOC$,NAME$,BH,FV,ILCHAR,CHSS,DEST,POS,AGE,BDAY,DDAY,SDAY,CWDAY,CHARGO,FINE,JDAY
locate 9,2: ? "WELCOME BACK CAPTAIN ";name$: delay 100

input #1;FDEST,mis,hij,cargo,psnj,pday,fuel,sp,prs,Jmp,frght,weaps,wn,sj
for A=0 to 7:  input #1;SHIP(A) : next A
for A=0 to 10 : input #1;WAN(A),CW(A),frgh(A),frs(A) : next A
for A=0 to 10 : for B=0 to 4 : input #1;SDET(A,B) : next B : next A
for A=0 to 10 : for B=0 to 3 : input #1;fav(A,B) : next B : next A
for A=0 to 10 : for B=0 to 2 :  input #1;ECC(A,B),kno(A,B): next B : next A
close #1 : cls : GM=1: return

770 I=1: gosub 5300 : gosub 1510 :  goto 1750
780 if NAME$="" then GM=0
locate 13,1: if fs=0 then ? "FUEL AVAILABLE" else  ? "FUEL SHORTAGE"
z=6: gosub grid: restore 790: y=1: for x=1 to 6:read n: at 105*siz,y+(5*siz): print n
y=y+(25*siz): next x
790 data "YOU","YOUR SHIP","SYSTEMS","OFFERS","SLEEP/REST","STARPORT"
820  gosub pick : I=0 : if A=0 then 770
if A>4 then a=a-4: on a goto 1850,850
  i=1: cls: on A gosub 1090,1210,940,1350
  i=0: X=0 : goto 1490
850 z=5: gosub 5300: gosub grid: restore 851: y=1: for x=1 to 5: at 105*siz,y+(5*siz):read n: print n:
y=y+(25*siz): next x
851 data "DEPART","RE-FUEL","BANK","SEARCH","SAVE"
852  gosub pick : I=0 : if A=0 then 770
 I=1: on A goto 1540,1550,1560,2300,920

920  ? "SAVING...": if name$="" then cls: gosub 480:
gosub 490 : goto 770
930 cls: print " ALBION SECTOR " : ? "Current Location: ";curloc$: locate 3,10: ? "Port   Law   Pat.   Cust."
dim zone(10):for x=1 to 10:zone(x)=x: locate x+3,1: ? syst$(x): locate x+3,11: ? sdet(x,1),"     ";sdet(x,2),,sdet(x,3),"   ";sdet(x,4), :  if sdet(x,2)=0 or x=10 then ? "*"
if x=2 or x=4 or x=5 or x=7 then z=32+(x*11) : line 1,z*siz,160*siz,z*siz,0
next x :
 935  z=10:a=0: goto pick3
940 gosub 930: if A=0 then cls: return
b=zone(a):gosub 950: goto 940

950 cls :? " SYSTEM DETAILS: ";SYST$(B)
if kno(b,2)>0 then ? "Home to ";who$(kno(b,2)); : if kno(b,1)=ecc(b,1) then print " (";what$(kno(b,1));")"
locate 4,1 : print "PORT CLASS: ";SDET(B,1),"LAW LEVEL: ";SDET(B,2) : print "PATROL : ";SDET(B,3),,"CUSTOMS: ";SDET(B,4) : print :
 print "OFFENCES COMMITTED: ";WAN(B) : print
 for A=1 to 3 : print FV$(A);" CONTACTS: ";FAV(B,A) : next A :
if SDET(B,2)<1 or b=10 then ? : ? CAT(1);"SYSTEM IS INTERDICTED";CAT(-1);
 gosub 1310 :: return

1090 ? " CAPTAIN ";NAME$ : print : print "AGE: ";AGE : print int(SDAY/365);" YEARS, ";SDAY mod 365;" DAYS ELAPSED" :? "IMPOUNDED: ";int(prs/365);" YEARS, ";prs mod 365;" DAYS":  print : print "CREDS: ";CREDS,,;"REP: ";REP : print
 if LOAN=0 then 1120 else print "LOAN OUTSTANDING: ";LOAN : print "NEXT REPAYMENT IS ";
 if REPAY=1 then print " DUE TOMORROW"
 if REPAY=0 then print " DUE TODAY"
 if REPAY>1 then print " DUE IN ";REPAY;" DAYS"
 if REPAY=-1 then print " 1 DAY OVERDUE"
if repay<-1 then print abs(REPAY);" DAYS OVERDUE"
1120 ?: print "CURRENT LOCATION: ";CURLOC$

1190 gosub 1310 : if I=1 then return

1210 I=1 : cls: ? SHIP(7):? " (Aught 03-K";ship(3)*8;"-";ship(5);")" :?
 print "FUEL:  ";fuel;" Units, allowing J-";int((fuel+1)/2) :? "JUMPS MADE: ";jmp: ?
 ? ship(2);" ton Cargo & ";ship(3);" Staterooms": if sj=0 then ? else ? tab(4);"SCANNER JAMMER INSTALLED"
gosub 104 :gosub 1310
if ECC(0,0)=0 then return
cls :  print "ARTIFACTS" : print : for X=1 to 10 : if ECC(X,0)<>0 then print WHAT$(ECC(X,0))
next X : goto 1310

 104 gosub 7510 :if PDAY<1 then 123 ELSE ? "CHARTER: ";chargo;" Freight, ";chss;" Fares  ";: if sp>0 then ? "(OW)";
if fv>0 then ? "(";left(fv$(fv));")";
?:? "DELIVERY IS ";
 if JDAY>0 then ? "DUE IN ";JDAY;" DAYS"
 if JDAY=0 then ? "DUE TODAY"
 if jday<0 then ? abs(JDAY);" DAYS OVERDUE"
123 if fdest>0 then ? "Deliver to ";SYST$(FDEST);: IF FDEST<>DEST THEN print " via ";syst$(dest);
return

1310 PEN ON: REPEAT : DELAY 25 : UNTIL PEN(0):
  WHILE PEN(3) : DELAY 25 : WEND
p4=pen(4): p5=pen(5): pen off: return

1350 gosub 1400:  if A=0 then return else b=zone(a): gosub 950: goto 1350

1400 I=0: gosub 5300: ? "Deliveries from ";curloc$: I=1
locate 3,15: ? "Freight  Passengers": z=1: dim zone(10)
for x=1 to ship(4): for y=1 to 10
dist=abs(hype(cur)-hype(y)): dist=dist+((dist=0)*2)
if curloc$=syst$(y) or dist<>x then 1402 else zone(z)=y
locate z+3,1: ? syst$(y);" (";dist;")": locate z+3,15: if sdet(y,2)=0 or y=10 then ? "INTERDICTED" else ? frgh(y):  locate z+3,25 : ? frs(y)
 z++
1402 next y: next x: z--: goto pick3

1490 on POS goto 770,3730,4000,7330
1510 if LOAN<1 or REPAY>0 or RM=1 then return
RM=1 :?: ? "LOAN REPAYMENT IS " : if REPAY=0 then ? "DUE TODAY" else ? abs(REPAY);" DAYS OVERDUE"
 delay 150 : EVE=1
 if REPAY<-3 and BH=0 then WAN(0)=WAN(0)+fix(LOAN/10000) : gosub 5520 :?: ?"THE LOAN COMPANY": ? "HAS HIRED A BALIFF!" : delay 2000 :  BH++: loan=loan+(SHIP(0)*2000)
 return

1560 cls: print cat(2);"THE BANK";cat(-2):?: if LOAN<1 then ? "YOU DON''T OWE ANYTHING" : delay 1000 : goto 1490
if trn>2 then ? "THE BANK IS SHUT": delay 1000: goto 1490 
 Z=SHIP(0)*1000 : if CREDS<Z then  ? "YOU CANNOT AFFORD TO PAY" : delay 1000 : loan=loan+abs(creds-4000):creds=2000: goto 1860

CREDS=CREDS-Z : if REPAY<0 and BH>0 then WAN(0)=WAN(0)-fix(LOAN/10000)+5 : gosub 5520 :  BH--
 REPAY=REPAY+10 : LOAN=LOAN-min(LOAN,Z/2)
1610 if LOAN<1 then goto 1650 else print "NEXT PAYMENT IS "; : if REPAY=0 then print "DUE TODAY"; else if REPAY<0 then print abs(REPAY);" DAYS OVERDUE"; else print "DUE IN ";REPAY;" DAYS";
delay 1500 :  if REPAY<1 then goto 1560

1650 if creds>=LOAN+20000 then  creds=creds-loan:  WAN(0)=WAN(0)-(REPAY<0 and BH>0)*fix(loan/10000) : BH=0: loan=0:
if loan<1 then ?:? "LOAN CLEARED": delay 1000
 goto 1860

1750 if AWAKE<4 then 780
 if AWAKE=4 then ?:? "YOU NEED TO":? "GET SOME SLEEP" else ? "YOU ARE EXHAUSTED" :
delay 1000
 if AWAKE>4 then AWAKE=-1 : gosub 5080 : goto 2280
 goto 780
1850 AWAKE=0
1860 cls :
2280 if fix(rnd*6)>5 then gosub 7150
gosub 5080 : goto 1490

2490  ?:? "SEARCH FAILED" : delay 1000 : goto 2280
2300   z=2: gosub 5300: gosub grid: restore 2301: y=1: for x=1 to 2: at 105*siz,y+(5*siz):read n: print n:
y=y+(25*siz): next x
2301 data "CONTRACT","DEAL"
2302  gosub pick : I=0 : if  A=0 then 770
TRY=FAV(CUR,1)+FAV(CUR,2)+FAV(CUR,3) : if fix (rnd*100)>99-max(TRY,ecc(0,0)) then 7440
on a goto 3140,7710

3140 locate 4,1: if AWAKE>3 then 1540
 if FUEL=0 then gosub 3650 : goto 1490

3170 DEST=fix(rnd*10) : gosub 7410
 if DEST=CUR or FUEL<DIST then 3170 else try--:  if try<0 then 2490
 if fix(rnd*6)+((cw(dest)>0)*6) <6 then   3170
  x=SHIP(2)-cargo: CHARGO=fix(rnd*x) : CHSS=fix(rnd*(SHIP(3)-1)) : if fix(rnd*6)=6 then CHARGO=min(CHARGO,(CHSS*2)-1) : goto 3210
 if FAV(CUR,1)>=FAV(CUR,3) then CHARGO=min(CHARGO+FAV(CUR,1),x) 
3210 if CHARGO>x or CHSS+CHARGO<1 then 2490 else  cls :  PY=(CHSS*200)+50+(CHARGO*10) : if CW(DEST)>0 then PY=PY+500
3220 ?:? "YOU WILL TAKE:" : if CHARGO>0 then print "FREIGHT: ";CHARGO
3230 if CHSS>0 then print "PASSENGERS: ";CHSS
3240 print "TO ";SYST$(DEST);" (";dist;")" : ? : print "ADVANCE: ";PY : if CHARGO=0 and CW(DEST)=0 then 3270
3250 if fix(rnd*6)>2 then ILCHAR=min(fix(rnd*25),CHARGO) : if FAV(CUR,3)>=FAV(CUR,1) then ILCHAR=min(ILCHAR+FAV(CUR,3),CHARGO)
3260  print "DELIVERY: ";(CHARGO*(DIST*50))+(ILCHAR*50)+((CW(DEST)>0)*1000)
3270 FV=0: sp=0 : if fix(rnd*6)=1 and CW(DEST)=0 and DIST<SHIP(0)+2 then 3290
if fix(rnd*6)<=wan(dest) then sp=1: ? : ? "Offences will be wiped": goto 3290
  if ILCHAR>=CHARGO/3 then FV=3 else FV=1
if fav(dest,fv)=15 or fix(rnd*6)>5 or CHSS>CHARGO then fv=2
3280 ? : print FV$(FV);" contacts will be increased"

3290  gosub 7455 : if A=2 then CHARGO=0 : CHSS=0 : ILCHAR=0 : goto 1860

 CARGO=CARGO+CHARGO : psnj=CHSS : CREDS=CREDS+PY : gr=1: gosub 5080  : PDAY=1 : goto 181

1550
3360  cls: if fs=1 then ? "FUEL SHORTAGE - TRY LATER":  delay 1500: goto 1860
3365 G(1)=20*(5-SDET(CUR,1)) : G(2)=g(1)*(SHIP(4)-FUEL): gosub 7840 : at 15*siz,132*siz :print "1 Unit" : at 110*siz,132*siz : print "FULL" :for x= 1 to 2: at (15+((x=2)*95))*siz,142*siz : print G(X);" Creds" : next X :
locate 4,1 : print "CREDS:";CREDS :  print "EMPTY FUEL CELLS: ";SHIP(4)-FUEL: print "FULL FUEL CELLS: ";FUEL:
 if FUEL=SHIP(4) then ?:? "YOUR FUEL CELLS ARE FULL" : delay 1000 : goto 1860
 gosub pick2: if A=0 or CREDS<G(A) then 1860
CRED=CREDS-G(A): if a=2 then a=(SHIP(4)-FUEL)
FUEL=FUEL+a : goto 3365

3570 if POS=3 then 4000 else SRCH=0 : goto 1490
1540 if AWAKE>3 then ?: ? "YOU ARE TOO TIRED":?"FOR SPACE TRAVEL" : delay 1000 : cls : goto 3570
 if CREDS<50 then  ? :? "YOU CANNOT AFFORD":?"THE LIFE SUPPORT" : delay 1000 : goto 3570
3610 if pos=3 then gosub 930 else gosub 1400
b=zone(a): if a=0 or b=cur then 3570
 DEST=B : gosub 7410: cls :? curloc$;" to ";syst$(dest)
 if DIST<=FUEL then 3660 else gosub 3650 : goto 3610
3650 ?: ? :?"YOU HAVE INSUFFICENT FUEL" : DEST=FDEST : delay 1000 : cls : return
3660 if POS=3 then goto 4000
 181  if (SDET(DEST,2)>0 and dest<10) or SDET(CUR,2)<1 then 184
cls :locate 7,1:  ? tab(2);SYST$(DEST);" IS INTERDICTED" : print tab(2);"YOU MAY TAKE":  ? tab(2);"NO FREIGHT OR PASSENGERS" : if chargo+chss<1 then ? tab(2);"GOING THERE IS AN OFFENCE" : delay 200 :  WAN(CUR)=WAN(CUR)+1 : WAN(0)=WAN(0)+1 : W=1 :
 delay 2000: goto 3720

 184 erase W,z : if DIST>FUEL then 3720 else if CARGO=SHIP(2) then 3700 else FRG=frgh(dest) : pss=min(SHIP(2)-cargo,ship(6))
if fav(cur,1)>0 then d=1:  locate 4,9 : print "FREIGHT WAITING: ";FRG;"  " : locate 5,10 : print "HOLD FREE: ";pss;"  " : act= "INCREASE FREIGHT (10 tons)" :gosub 7650: frg=frg+(fvu*10)
 Z=min(FRG,pss):  frght=0: cls: 
 
3700 PSS=frs(dest): if SHIP(3)=8 and psnj<7 and PSS>0 then PSA=7-psnj : w=min(PSS,PSA)

if z+w<1 then 3720
? curloc$;" to ";syst$(dest): locate 4,9 : print "FREIGHT TO CARRY: ";z;"  " 
 locate 5,11 : print "FARES TO CARRY: ";w;"  "
gosub 7455: if a=1 then frght=z : cargo=cargo+z:  psnj=psnj+w : CREDS=CREDS+(w*100)
erase z,w

3720 if pday>0 then JDAY=HYPE(0)+3: a=1: goto 3730
3722 locate 11,13 : ? "LIFT-OFF?" : gosub 7840:at 15*siz,137*siz :print " DEPART" : at 110*siz,137*siz : print "  STAY   " :gosub pick2 : if A=0 then 3722
if A=2 then  CARGO=CARGO-frght : frght=0: CREDS=CREDS-(psnj*100) : psnj=0 : WAN(CUR)=WAN(CUR)-(W=1) : WAN(0)=WAN(0)-(W=1) : goto 1860
 3730 gosub 7410 :gosub 127: x=((psnj+1)*50): locate 10,5: ? "LIFE SUPPORT COSTS YOU ";X: creds=creds-X : delay 2000
 3740 OCUR=CUR : gr=1: i=0 :pos=2: fdest=dest
  cls :gosub 1090 : gosub 940 : gosub 5080: gosub 5300

3820 erase DT,Mj : if fix(rnd*6)>SDET(CUR,3) then  HIJ=1
 
 GR=1 : erase AR,FVU : gosub 5300 :? "LIFT OFF!" : delay 1500 

 ? "LEAVING ORBIT"
 delay 1000 : gosub 4446
if hij>0 then gosub 6780

goto 4000
3950  GR=1 : cls: ?  "ARRIVE AT JUMP POINT": delay 500:?
3960 pos=3: if fdest=cur or fuel=0 then print "Head In-system" else jump=105-(hype(0)*5)-int(jmp/50): ? "PREPARE FOR JUMP": ? "TO ";SYST$(DEST): ? "En-route to ";syst$(fdest):? :print "FUEL REQUIRED: ";HYPE(0);"   ": ? "FUEL HELD: ";fuel: ? "Jump Chance: ";jump;"%"
 locate 11,1: if fuel=0 then ? "YOU HAVE NO FUEL": ? "YOU MUST HEAD IN-SYSTEM": goto 3990
if HYPE(0)>FUEL then  ? "YOU HAVE INSUFFICENT FUEL"  : ? "YOU MUST RE-SET YOUR JUMP"
 3990 z=4: gosub grid: restore 3991: y=1: for x=1 to 4: at 105*siz,y+(5*siz):read n: print n:
y=y+(25*siz): next x
3991 data "HEAD-IN","MAKE JUMP","RE-SET","INFO"
3992  gosub pick :  I=1 : cls : if A=0 then 3950 else on A goto 4170,4240,3610,3970
3970 I=0: cls :gosub 1090 : gosub 940: goto 3960

4000 GR=cur : gosub 7410: if Mj=1 then  ? "YOU HAVE MIS-JUMPED" : delay 1000
if GM=0 or pos=3 then 257 else pos=3: gosub 490
257 Mj=0 : goto 3950

4170 POS=1 :  gosub 5300 : goto 4480

4240 gosub 7410 : if DIST=0 then  ? "YOU MUST SELECT": ? "A DESTINATION" : delay 500 : goto 4000
 D=0 : B=0 : if HYPE(0)>FUEL then 4000
 FUEL=FUEL-hype(0) : HYPE(0)=hype(0): gosub 7760

 WAN(0)=min(WAN(0)-(DIST*fix(rnd*3)),99) : jmp++: ? "ENTERING HYPERSPACE" : delay 2000 : gosub 4330 : goto 4350
4330 CURLOC$="HYPERSPACE" : cls : rect 0,0,360,360,color0 filled
for x=8 to 158 step (sdet(gr,5)*10): arc 160,160,x,0,3600 color 15:  next x
 for x=8 to 158 step (sdet(gr,5)*10): arc 160,160,x,0,3600  color 0:  next x  :
 return

4350 HYPE(0)=(DIST*2)-1 : D=(fix(rnd*3)*4): for E=1 to D : gosub 5080 : ? "HYPER-JUMP TAKES ";fix(e/4);" DAYS..." :delay 200 : next E : AWAKE=1 : GR=DEST 
 cls : if fix (rnd*100)<=JUMP then 4435 else ? "HYPERJUMP FAILURE": delay 1000
if fix(rnd*6)<3 then ?: ? "YOUR SHIP DISSIPATED": ? "IN HYPERSPACE" : goto 5460
 DEST=fix(rnd*10) : Mj=1 : gosub 4330 : goto 4350

4435 gosub 4330: CUR=GR : CURLOC$=SYST$(CUR) : DEST=FDEST : pos=2: goto 4000
 4480 if CUR<>FDEST then DEST=CUR : Mj=1

 ? "HEADING IN-SYSTEM": delay 1000
gosub 4446: ?: goto 4448

4446 D=fix(sdet(cur,5)/(3-ship(0))): for E=1 to D : gosub 5080 : ? "TRAVELLING TAKES ";e*6;"  HOURS..." :delay 200 : next E : AWAKE=1 : return

 4448 ? "ENTERING ORBITAL PATH " : delay 1000: POS=1 : CI=1: DCLR=cargo-(ilchar+weaps)
  erase GR,FVU :?: if sdet(CUR,2)>0 then ? "WELCOME TO "+SYST$(CUR) else  ? SYST$(CUR)+" IS INTERDICTED" :delay 2000 :goto 4592
 delay 2000 :? : ? "STANDBY FOR CUSTOMS DECLARATION" : delay 1000 : cls 
 gosub 104
?:?: ? "PATROL VALUE: ";SDET(CUR,3): ? "CUSTOMS RATING: ";SDET(CUR,4): ? "   POLITICAL FAVOURS: ";fav(cur,2): if sj>0 then ? tab(4);"SCANNER JAMMER INSTALLED"
4590  gosub 7840:at 15*siz,137*siz :print "SUBMIT" : at 110*siz,137*siz : print "EVADE"   : gosub pick2 : if A=0 then 4590 else cls: locate 4,1: if a=1 then 4660
 4592 if fix(rnd*6)+fix(rnd*6)<=sdet(cur,3)+(SHIP(4)-3)-sj then 272
? "YOUR EVASION IS SUCCESSFUL" : delay 1000 : if fix(rnd*6)>=ship(4)-(sj=3)  then 4961 else ? "Unfortunately you were identified.": ? "Evading Customs is an offence.": wan(cur)=wan(cur)+1: delay 3000 : goto 4961
 272  ? "YOUR EVASION IS UNSUCCESSFUL" : ? "THE CUSTOMS MEN ARREST YOU" : delay 3000:cls : gosub 5440 :WAN(CUR)=wan(cur)+1 :if fix(rnd*6)+fix(rnd*6)+fix(rnd*6)-wan(cur)<SDET(CUR,4) and sj>0 then ? "Scanner Jammer confiscated": ?"Possession is a serious offence":wan(cur)=wan(cur)+2: sj=0: delay 2000: ? 
goto 4790
4660 if POS=4 then 4810 else if FAV(CUR,2)>0 then W=0 : D=2: act="BRIBE OFFICIALS" : gosub 7650 : locate 6,1
  if fix(rnd*6)+fix(rnd*6) >SDET(CUR,4)-(FVU*2) then goto 4960
4790 ?"WE WISH TO INSPECT YOUR SHIP" : ? "PLEASE PREPARE FOR BOARDING" : delay 2000 :

4810 SRCH=min(fix(rnd*(SHIP(6))+SDET(CUR,4)-(FVU*5)),cargo-(ship(0)*5)): FIND=SRCH-DCLR : gosub 5390
 4840 if FIND<1 or (ILCHAR+weaps<1)  then ? "OUR SEARCH REVEALS NOTHING" : delay 1000: goto 4960
 PT=0 : cls: ? "ILLEGAL GOODS HAVE BEEN FOUND" : delay 2000 : if ILCHAR>0 then gosub 4940
 if FIND<1 or weaps<1 then 4920 else FOUND=min(FIND,weaps) : ?: ? "The Police confiscate "; FOUND;" Tons":  ? "from your cargo" : FIND=FIND-FOUND : WAN(CUR)=WAN(CUR)+FOUND : weaps=weaps-FOUND : CARGO=CARGO-FOUND :
 if fix(rnd*6)+fix(rnd*6) >SDET(Cur,4) then  PT=PT+(((SDET(cur,4)+1)*FOUND)*100) :
 delay 2000:
4920 pt=max(min(pt,creds-2000),0): gosub 5390
if FINE>0 and PT=0 then 4960
if pt=0 then ?:? "The customs men give an evil smile" : ? " ''Be seeing you...'' They say": delay 3000: goto 4960
 ?: ? "Lucky for you, these cops are corrupt." :  ? "They have recorded your crime and" : ?"levied a ''Private Tax'' of "; PT;" Creds" :CREDS=CREDS-PT : delay 5000 : cls : goto 4960
4940 FOUND=min(FIND,ILCHAR) : ? "The Police confiscate "; FOUND;" Tons" : ? "from the chartered goods." : ? "The Patron has no time" : ? "for incompetent smugglers." :? "Your reputation has suffered."
 FIND=FIND-FOUND : fav(fdest,FV)=fav(fdest,FV)-fix(rnd*3): erase fv,jDAY,sp: ILCHAR=ILCHAR-FOUND : CARGO=CARGO-FOUND : CHARGO=CHARGO-FOUND : if fix(rnd*6)+fix(rnd*6)>SDET(Cur,4) then PT=PT+(((SDET(CUR,4)+1)*FOUND)*100) else  WAN(CUR)=WAN(CUR)+fix(found/2)
 WAN(CUR)=WAN(CUR)+1 : WAN(0)=WAN(0)+FOUND : gosub 5520 : delay 5000 : return

4960 ? "YOU ARE CLEARED FOR LANDING" : delay 1000 : 
4961 ?:? "MAKING PLANETFALL": delay 1000
gosub 5300 :

if mj=0 or cargo+psnj=0 then  5000
 DEST=FDEST : gosub 7410 : COMP=(frght*60)+(CHARGO*(dist*100)): sp=0
  cls : locate 1,3 : ? "WRONG DESTINATION" : ? "YOU MUST PAY ";(COMP/2)+(psnj*200);" CREDS" : ? "COMPENSATION" : delay 2000 : cls : CREDS=CREDS-COMP-(psnj*200) :  if FV>0 then FAV(CUR,FV)=FAV(CUR,FV)-5
 goto 5020

5000 if PDAY=0 then 5020 else : CREDS=CREDS+(CW(CUR)>0)*1000: BNT=abs(JDAY*(frght+psnj+ILCHAR)) :  cls : locate 0,3 : if JDAY-1>0 then ? "FAST DELIVERY" : ? "YOU ARE PAID ";BNT;" CREDS BONUS" : CREDS=CREDS+BNT : delay 2000 : cls
 if JDAY+1<0 then ? "LATE DELIVERY" :  ? "YOU MUST PAY ";BNT;" CREDS": ? "COMPENSATION" : CREDS=CREDS-BNT : delay 2000 : cls
5020 DEST=OCUR : gosub 7410 : CREDS=CREDS+(frght*30)+(ILCHAR*50)+(CHARGO*(dist*50)) : 
if Frght>0 and mj=0 then FAV(CUR,1)=min(FAV(CUR,1)+1,15)
if psnj-chss>0 and mj=0 then FAV(CUR,2)=min(FAV(CUR,2)+1,15)
if (Frght+chargo+psnj>0) and mj=0 and (sdet(cur,2)=0 or cur=10) then FAV(CUR,3)=min(FAV(CUR,3)+1,15): 
if cw(cur)>0 then cw(cur)=cw(cur)+ilchar
if cw(0)=cur then cwday=max(1,cwday-ilchar)
CARGO=CARGO-frght-chargo : 
if sp>0 then wan(cur)=0
 if FV>0 then FAV(CUR,FV)=min(FAV(CUR,FV)+(fix(rnd*3)+1)+fv,15) 
erase psnj,CHARGO,CHSS,ILCHAR, frght,DEST,JDAY,FDEST,PDAY, Mj ,sp,fv,gr
 WAN(CUR)=WAN(CUR)+(CREDS<0)
 gosub 5080 : CI=0 : if GM=0 or POS=4  then delay 1500 else gosub 490
 if POS<4 then 1490 else POS=1 : gosub 5430 : goto 1490

5080 TRN++ : if TRN>4 then TRN=1 : DAY++ : if DAY=366 then DAY=1 : YEAR++
gosub 5300: fs=0:  if fix(rnd*6)>sdet(cur,1)+2 then fs=1
on TRN gosub 5120,7700,7700,5180 : if POS=4 and fine>0 then gosub 5180

5115  AWAKE++ : return
5120 SDAY++ : JDAY-- :  RM=0 : if LOAN>0 then REPAY--
 if GR=0 then CREDS=CREDS-20 : if  LOAN<1 and creds>=100000 and wn=0 then gosub 6330
 if DAY<>BDAY then 5172 else AGE++ 
  ?: ? "HAPPY BIRTHDAY": ? "CAPTAIN ";NAME$ : delay 1500 : cls : EVE=1
5172 if DAY=1 then gosub 7030 :  ?: ? "HAPPY NEW YEAR": ? "CAPTAIN ";NAME$ : delay 1500 : cls : EVE=1

if fix(rnd*6)+fix(rnd*6)>11 then for x=1 to 2: swap ecc(fix(rnd*10),1),ecc(fix(rnd*10),1): next x
goto 5390 

5180 for X=1 to 9 : if CW(X)=1 then gosub 6990
 if CW(X)>0 then CW(X)=CW(X)-1
next X :
 CWDAY-- : if CWDAY<1 then gosub 6950

5300 cls: print turn$(TRN);" ",format("000",DAY);".";YEAR : if I=1 then 7815 else return

5390 if Gr>0 then 5520 else if WAN(CUR)>0 then WAN(0)=WAN(0)+WAN(CUR)
5400 if CREDS<0 then WAN(CUR)=WAN(cur)+1: 
 if fix(rnd*100)>75/REP then goto 5420
cls :  ? " CAPTAIN ";NAME$;" "  : ? "YOU HAVE BEEN CAUGHT BY": ? "BOUNTY HUNTERS" : print "There is a nice reward for your" : print "capture." : print "The bounty hunter won''t have to pay" : ? "for your life support if he brings you" : ? "back dead..." : goto 5460
5420 if WAN(CUR)<1 then 5520 else if WAN(CUR)+SDET(CUR,2)<(fix(rnd*6)+fix(rnd*6)+fav(cur,3)/5)  then 5510
5430 cls: ? " CAPTAIN ";NAME$;" " : ? : ? "YOU HAVE BEEN ARRESTED"  : print "You are guilty of committing ": ? WAN(CUR);" major offences."
5440 ? : if CI=1 then POS=4 : PT=0 : FINE=1: sp=0 : ? "SENTENCE WILL BE PASSED" : ? "ONCE YOU MAKE PLANETFALL" : ?: delay 1500 : return
5450 FINE=WAN(CUR)*(30-FAV(CUR,2)) : Z=REPAY-FINE : Y=min(LOAN*2,(Z<0)*abs((Z-10)*(SHIP(0)*100))) : Z=Y+(FINE*20)+2000 :
if CREDS>=Z then 7300
? "THE SENTENCE IS": ? "INVOLUNTARY EUTHANASIA" : delay 1500:

5460 ?:? tab(3);"THE END"
   gosub 1310 : end

5510 if CI=1 then 5520 else ?:? "YOU ARE WANTED IN THIS SYSTEM" : delay 1500 : EVE=1
5520 WAN(0)=max(WAN(0),0) : REP=max(100-WAN(0),1) : return

6330 cls : ? "WELL THAT''S IT" : ? : ? "AFTER ";int(SDAY/365);" YEARS AND ";(SDAY mod 365);" DAYS" : ? "YOU HAVE PAID OFF YOUR LOAN" : ? "AND MADE A SMALL FORTUNE.": ? "The future is all yours..." : wn=1: ?: ?"You are free to continue making": ? "a large fortune."
6340 REPAY=0 : gosub 1310 : return

6780 cls: ? " PIRATES DETECTED!" :  ?: delay 1000
6800 if fix(rnd*6)>=ship(4)-(sj=3) then ? "   YOU MANAGE TO EVADE THEM"  : HIJ=0 : delay 2000 : cls: return
6860 ? " THEY STEAL YOUR SHIP" : ?:? "    AND TAKE YOUR LIFE...": delay 2000: goto 5460

6950 X=CW(0) : if CW(X)>0 then 6970 else for Y=1 to 2 : SDET(X,Y)=0 : next Y:  SDET(X,3)=8
 if CURLOC$<>"HYPERSPACE" then  ?: ? "ANARCHY AT ";SYST$(X) : ? "THE SYSTEM IS NOW INTERDICTED" : delay 3000 : cls : EVE=1
6970 CW(0)=fix(rnd*9): if sdet(cw(0),4)=10 then 6970 else CW(X)=fix(rnd*356)+9 : CWDAY=fix(rnd*365) : return
6990 if CURLOC$<>"HYPERSPACE" then ? : ? SYST$(X);"''S TROUBLES": ? "HAVE BEEN RESOLVED": ?"THE INTERDICTION HAS BEEN LIFTED" : delay 3000 : cls : EVE=1
 SDET(X,1)=int(rnd*5): 
SDET(X,2)=fix(rnd*3)+1-(cw(0)=x)
7010 SDET(X,3)=SDET(X,1)+SDET(X,2) : SDET(X,4)=SDET(X,3)+2: return

7030 for Z=1 to 2 : 
7031 X=fix(rnd*9) : if  CW(X)>0 or cw(0)=x then 7031
 if SDET(X,Z)<4  then SDET(X,Z)=SDET(X,Z)+1 : gosub 7010
7040 next Z : return

7150 ? : ? "YOU HEAR A RUMOUR...": delay 1000 :?
 X=fix(rnd*9) : if fix(rnd*6)<3 then goto 7280
 if fix(rnd*6)<2+FAV(CUR,fix(rnd*3)) then gosub 7490 : goto 7290
repeat: x++: until CW(X)>0 or X>9
 if CW(X)>0 and CW(X)<31 then print SYST$(X);"''S" :? "TROUBLES WILL": ? "SOON BE OVER" : goto 7290
7280 if cwday<31 then x=cw(0)
 ? SYST$(x): ? "IS HEADING TOWARD": ? "SOCIETAL COLLAPSE"
7290 delay 2000 : cls : return

7300   print "Your ship is impounded for ";(FINE);" days" : prs=prs+fine: if GM=0 or POS=4 then delay 1500 else POS=4 : gosub 490
 if creds-z<0 then LOAN=LOAN+(z-creds) : CREDS=CREDS+(z-creds)
 POS=4 : WAN(CUR)=0  : LOAN=LOAN-(Y/2) : CREDS=CREDS-(z-3000): REPAY=repay+fine : GR=1

7320 EVE=0 : gosub 5300 : repeat : TRN=4 : gosub 5080 : ?:? "THE DAYS PASS SLOWLY...": delay 100: FINE-- : until FINE=0 or EVE=1 : if EVE=1 and FINE>0 then goto 7320 
GR=0 : AWAKE=1 : TURN=1 : ?: ? "UNTIL YOUR SHIP IS RELEASED" : POS=1 : if GM=0 then delay 1500 else gosub 490
cls :  return

7330 gosub 5430:  goto 1610

7410 X=CUR : Y=DEST
 DIST=abs(HYPE(X)-HYPE(Y)): dist=dist+((dist=0 and x<>y)*2): HYPE(0)=(DIST*2)-1 : return

7440 cls :?: print "Your search leads to ";WHO$(ECC(CUR,2)):? :kno(cur,2)=ecc(cur,2): Y=0 : for X=1 to 10 : if ECC(X,0)=ECC(CUR,1) then ECC(0,0)=ECC(0,0)-5 : ECC(X,0)=0 : CARGO=CARGO-5 : Y++
 next X : if Y>0 then goto 7460
if SHIP(6)-CARGO<5 or fix(rnd*6) <4 or CREDS<5000 then goto 7470
7450 b=fix (rnd*10) : if b=CUR then goto 7450
 print "He offers to sell you 5 tons of " : print WHAT$(ECC(b,1));" for 1000 Creds"
gosub 7455 
if A=2 then goto 1860
ECC(0,0)=ECC(0,0)+5 : CARGO=CARGO+5 : z=0 : repeat : z++ : until ECC(z,0)=0 : ECC(z,0)=ECC(b,1) : CREDS=CREDS-1000 : goto 1860
7460 Y=Y*((SDET(CUR,2)+1)*3000) : print "He accepts your delivery of" : print WHAT$(ECC(CUR,1));:kno(cur,1)=ecc(cur,1) : print " and pays": ? "you ";Y;" Creds" : CREDS=CREDS+Y : goto 7480
7470 print "He tells you that " : if fix(rnd*100)>99-TRY then gosub 7490 else ? "he is buying ";what$(ecc(cur,1)) : kno(cur,1)=ecc(cur,1)
7480 delay 3000 : goto 1860

7490 X=fix(rnd*10) : if X=CUR then 7490
? WHO$(ECC(X,2));
if fix(rnd*6)<5 or kno(x,2)>0 then print " is buying " : ? WHAT$(ECC(X,1)) :kno(x,1)=ecc(x,1): return
 print " is at " : ? SYST$(X) :kno(x,2)=ecc(x,2): return

7500 if SDET(CUR,1)>0 then return else ? "THIS SYSTEM IS INTERDICTED" : delay 1000 :goto 3570
7510 ? "TOTAL CARGO: ";cargo : print "SPECIAL: ";ecc(0,0),,"ILLEGAL: ";weaps:
? "FREIGHT: ";frght,,"FARES: ";psnj-chss   : return

7650 FVU=0 : Z=FAV(CUR,D) :
7660 gosub 127: locate 10,7: ? act: locate 11,9 : print FV$(D);": ";Z-W : locate 12,11 : print "FAVOURS TO USE: ";W : gosub 7690 : if A<>3 then 7650 else FVU=W : FAV(CUR,D)=FAV(CUR,D)-W : erase D,W : return

7690 x=5:for y=1 to 5:
 rect x*siz,135*siz,(x+30)*siz,155*siz:
x=x+30: next y
at 8*siz,140*siz: print "  <<   ":  at 40*siz,140*siz: print "  <   ":
: at 70*siz,140*siz: print " OK" :at 100*siz,140*siz: print "  >   ":
at 130*siz,140*siz: print " >>":
turn=0:

126 gosub 1310
if p5<135*siz or p5>155*siz or p4<5*siz or p4>155*siz then goto 126
a=0: repeat: a++: until p4<((a*30)+5)*siz: if a<>3 then w=w+a-3+(a mod 2<>0)*(a-3)*4: w=max(0,min(w,z))
127 rect 0,65*siz,160*siz,160*siz,15 filled
return

7700 if GR>0 then return
for y=1 to 10:
if cur=y or abs(hype(cur)-hype(y))>5 then 7701
A=fix(rnd*5) :FRGH(y)=max(0,(((fix(SDET(cur,1)*2))-SDET(y,2))*A)+fix(rnd*10)) : if fix(rnd*6)<=fav(cur,1) then FRGH(y)=FRGH(y)+fav(cur,1)
frs(y)=max(0,(SDET(CUR,1)+SDET(y,1))-(A-2))
7701 next y:  return

7705 delay 3000: goto 1860
7710 if (fix(rnd*6)+fix(rnd*6)+fav(cur,3))<=(sdet(cur,2)+6) then 2490
cls:?: ? "YOU HAVE FOUND A POSSIBLE DEAL:"

if (cur<10) or (fix(rnd*6)+fix(rnd*6)+fav(10,3)<13) or (creds<10000) or (sj=3) then 467

print :  ? "Scanner Jammer for 5000 Creds": gosub 7455: if a=1 then sj=3: creds=creds-5000
goto 1860

467 b=1 : amnt=(fix(rnd*6)-sdet(cur,2))*5: prc=(300+fix(rnd*100))*(sdet(cur,2)+1)
if Cw(cur)>0 then amnt=(fix(rnd*6)-2)*5
if amnt<1 then amnt=abs(amnt)+10: b=2
if (b=2 and weaps=0) then ? "but you have nothing to sell": goto 7705
if (b=1 and (ship(2)-cargo=0)) then ? "but your hold is full" : goto 7705
w=0: on b goto 7722,7733

7715 if fav(cur,3)>0 then d=3: act= "INCREASE G00DS (5 tons)" :gosub 7650: amnt=amnt+(fvu*5):
 return
7720 locate 4,1 : print "''ILLEGALS'' FOR SALE: ";amnt-W;" at ";prc;" Creds   " : locate 5,5 : print "HOLD FREE: ";SHIP(2)-cargo-W;"  " :return
7722 gosub 7720: gosub 7715
 Z=min(int(creds/prc),SHIP(2)-cargo): z=min(z,amnt)
7725  gosub 7720: locate 6,6 : print "GOODS TO BUY: ";W;"  " : gosub 7690 : if A<>3 then 7725 else weaps=weaps+W : cargo=cargo+w: creds=creds-(w*prc):  goto 7740

7730 locate 4,1 : print "''ILLEGALS'' WANTED: ";amnt-W;" at ";prc;" Creds.  " : locate 5,5 : print "GOODS IN HOLD: ";weaps-W;"  " :return
7733 gosub 7730: gosub 7715
 Z=min(amnt,weaps)
7735  gosub 7730: locate 6,6 : print "GOODS TO SELL: ";W;"  " : gosub 7690 : if A<>3 then 7735 else weaps=weaps-W : cargo=cargo-w: creds=creds+(w*prc)

7740 if cw(cur)=0 then 7745
if b=1 then cw(cur)=max(1,cw(cur)-w) else cw(cur)=cw(cur)+w
7745 if cw(0)<>cur then 7750
if b=2 then cwday=max(1,cwday-w) else cwday=cwday+w

7750  if w>0 and fix(rnd*6)+fix(fav(cur,3)/(sdet(cur,2)+1))<=sdet(cur,2)+wan(cur) then wan(cur)=wan(cur)+fix(w/5) : if trn<4 then locate 8,1: gosub 5390
w=0: goto 1860

7760 cls :? SYST$(CUR); " TO ";SYST$(DEST) : ? : ? "JUMP%: ";JUMP : return

7815  print CURLOC$: ?"CREDS: ";CREDS : ?: return

7455 gosub 7840: at 15*siz,137*siz :print "ACCEPT" : at 110*siz,137*siz : print "DECLINE" :gosub pick2 : if A=0 then 7455
 return

label grid
x=1*siz: for n=1 to z: rect 98*siz,x,158*siz,x+(23*siz)
x=x+(25*siz) :next : return

label pick
124 gosub 1310 :a=0
if p4<98*siz or p4>159*siz or p5<1 or p5>(z*25)*siz then return
 repeat: a++: until p5<(a*25)*siz
return

7840 rect 5*siz,130*siz,58*siz,155*siz: rect 100*siz,130*siz,150*siz,155*siz: return

label pick2
 gosub 1310: a=0
if p5<135*siz or p5>155*siz or p4<5*siz or p4>155*siz then return
 repeat: a++: until p4<((a*50)+5)*siz: if a=2 then a=0 else  a=a-(a=3)
return

label pick3
 gosub 1310 :a=0
if p4<1*siz or p4>155*siz or p5<35*siz or p5>(40+(z*10))*siz then return
repeat: a++: until p5<(35+(a*11))*siz
return
'
