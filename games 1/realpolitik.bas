
'#sec:Main
'' Realpolitik.bas
'' 20/07/2006
'' The politics of practical reality, ignoring morals or ideology.
''A game of geopolitical manouverings.
'' By Gary Breinholt

label start
cls: 
?: ? ,,"  REALPOLITIK"
? "   As leader of you country you"
? "   must maintain your International"
? "   Prestige and Internal Stability."
? "   Diplomacy and subversion,"
? "   are your main tools."
? "   But if all else fails there is always"
? "   war as the the last resort!"
?
? "   Covert actions might appear"
? "   to be an attractive alternative."
? "   But the cost of being found out"
? "   may prove too high to bear!";
pause 20: cls

siz=1+(xmax>300) 

label setup
dim rel(6,6),pres(6),fact(6),geo(6,6),enemy(6),friend(6), news(8), wnews(10), oldpres(6),newpres(6) , pres1(6)
dim stab(6), seas(4),feel(5), stabs(10), rels(10), newss(10), ystab(6),chamed(6), ld(6),stat(6): win=0: fd=0 :ply=6 

restore facts: y=1: you=2 : 
for x=1 to 6: read fact(x)
stab(x)=4+fix(rnd*3)
 next x

for z=1 to 6: for x=1 to 6: read geo(z,x): rel(z,x)=6
next x: next z

for z=0 to 5: read feel(z): next z
for z=1 to 4: read seas(z): next z
for z=0 to 10: read stabs(z): next z
for z=0 to 10: read rels(z): next z
for z=0 to 10: read newss(z): next z

year=2009+fix(rnd*20): syear=year+1
for x=1 to 6:  
repeat: y=fix(rnd*6): until x<>y and geo(x,y)=1: enemy(x)=y: rel(x,y)=rel(x,y)-1: rel(y,x)=rel(y,x)-1
repeat: y=fix(rnd*6): until x<>y and geo(x,y)=1 and enemy(x)<>y: friend(x)=y
rel(x,y)=rel(x,y)+1: rel(y,x)=rel(y,x)+1
oldpres(x)=7: gosub prest
next x

gosub news: gosub wnews
wnews(1)=fact(you)+" welcomes their new leader"

label begin
ss=1: year++: 

while ss<5
dim charel(6,6): dim chastab(6)
cls: locate 2,5: ?cat(2);"World News "; seas(ss);"  ";year;cat(-2): ?
for x=1 to 10: ? wnews(x): next x
pause wn*2: gosub wnews
if win>0 then goto win

''Your turn
dim xtm(6): gosub 185: 
for x=1 to 6: if x=you or stab(x)<1 then goto 71
ystab(x)=ystab(x)+chamed(x): ystab(0)=ystab(0)+fix(chamed(x)): chamed(x)=0
ystab(x)=max(min(ystab(x),10),0)
71 next x: ystab(0)=ystab(0)+fix(chamed(0))
chamed(0)=0
ystab(0)=max(min(ystab(0),10),0): 
cls: locate 8,5: ? "Resolving..."

''AI routines
for cp=1 to 6: stab(0)=0
if cp=you or stab(cp)=0  or ld(cp)=1 then goto 97
dp=enemy(cp):dp2=enemy(dp): if stab(dp)=0 then goto 93	
if fix(rnd*6)+fix(rnd*6)>=stab(dp) then chastab(dp)=chastab(dp)-1 else rel(cp,dp)=rel(cp,dp)-1: rel(dp,cp)=rel(cp,dp)
if rel(cp,dp)>1 or (geo(cp,dp)=1 and dp2=cp and stab(cp)>stab(dp)) then charel(cp,dp)=charel(cp,dp)-1: charel(dp,cp)=charel(dp,cp)-1
 if stab(dp2)=0 or dp2=cp then goto 93
if rel(cp,dp2)>7 then chastab(dp2)=chastab(dp2)+1 else charel(cp,dp2)=charel(cp,dp2)+1: charel(dp2,cp)=charel(dp2,cp)+1

93 dp=friend(cp): if stab(dp)=0 or dp=enemy(cp) then goto 97
dp2=enemy(dp):  if stab(dp2)=0 or dp2=cp then goto 94
if (rel(cp,dp)>9 and ((rel (cp,dp2)>1) or (dp2=enemy(cp) and geo(cp,dp2)=1 and stab(cp)>stab(dp))))  or rel(cp,dp2)>4  then charel(cp,dp2)=charel(cp,dp2)-1: charel(dp2,cp)=charel(dp2,cp)-1
if rel(cp,dp)=10 then chastab(dp)=chastab(dp)+1
94 dp2=friend(dp): if stab(dp2)=0 or dp2=cp then goto 96
if rel(cp,dp2)<8 then charel(cp,dp2)=charel(cp,dp2)+1: charel(dp2,cp)=charel(dp2,cp)+1

96 charel(cp,dp)=charel(cp,dp)+1
charel(dp,cp)=charel(dp,cp)+1
97 next cp: 

dim order(6): rt=0
orders=1: while orders<7
109 y=fix(rnd*6): if order(y)>0 then goto 109
order(y)=orders: orders++:wend

for go=1 to 6: x=order(go)
 if stab(x)=0 then goto 119
for y=1 to 6:
 if x=y or stab(y)=0 then goto 117 
charel(x,y)= charel(x,y)-(rel(x,y)>8 and  charel(x,y)<2 )
if rel(x,y)>7 and  charel(x,y)=1 then charel(x,y)=0
 charel(x,y)=max(min(charel(x,y),1),-1)
rel(x,y)=rel(x,y)+charel(x,y): 
if rel(x,y)>8  then chastab(x)=chastab(x)+1: if y=2 then ystab(0)=max(ystab(0)-2,0)

if rel(x,y)<10  then goto 117
''if fix(rnd*6)>3 then enemy(y)=enemy(x) else enemy(x)=enemy(y)

v=(enemy(y)>0)*enemy(y): w=(enemy(x)>0)*enemy(x): 

rel(x,v)=min(rel(x,v),rel(y,v)): rel(v,x)=rel(x,v): 
rel(x,w)=min(rel(x,w),rel(y,w)): rel(w,x)=rel(x,w): 

117 next y
119 next go

for go=1 to 6: x=order(go): 
for goh=1 to 6: y=order(goh): 
rel(x,y)=rel(y,x):
rel(x,y)=max(min(rel(x,y),10),0)
if rel(x,y)<1 then chastab(x)=chastab(x)-1
 next goh: next go

for go=1 to 6: x=order(go)
 if stab(x)<1 then goto 104
stab(x)=stab(x)+chastab(x)
gosub prest:

 if pres(x)<1 then stab(x)=0 : wnews(wn)="Corrupt leader removed in "+fact(x): wn++: stat(x)=fact(x)+" is in interregnum" :ply-- : goto 104

y=enemy(x)
if stab(x)>0 then goto 99
pres(x)=0: v=friend(x): if rel(x,v)>8 and stab(v)>0 and geo(x,v)=1 then y=v: goto 107
if  stab(y)<1 or geo(x,y)=2 or rel(x,y)>1 then goto 108 
107 wnews(wn)=fact(y)+" restores peace in "+fact(x):pres1(y)=pres1(y)+1:stab(y)=min(stab(y)+2,10): wn++: pres(x)=0: stat(x)="Puppet government to "+fact(y) : ply-- : goto 104
108 wnews(wn)=" Anarchy reigns in "+fact(x): wn++: pres(x)=0: stat(x)=fact(x)+" is in interregnum" : ply-- : goto 104

''war
99 if rel(x,y)>0 or geo(x,y)=2 or stab(y)<1 then goto 104
 
if fix(rnd*6)>3 or ld(x)=1 then stab(x)=0:wnews(wn)=fact(y)+" invades "+fact(x):pres1(y)=pres1(y)+1: pres(x)=0: stab(y)=min(stab(y)+2,10): wn++: stat(x)="Invaded by  "+fact(y) : ply-- : goto 104 
 stab(y)=0: wnews(wn)=fact(x)+" invades "+fact(y):pres1(x)=pres1(x)+1:stab(x)=min(stab(x)+2,10): pres(y)=0: wn++: stat(y)="Invaded by  "+fact(x) : ply-- : 
 
104 gosub prest: next go

win=(ply=1)+(stab(2)=0): if win>0 then wn++: wnews(wn)="     Breaking news...": st=ss: goto 39

''review f&e
for x=1 to 6:
friend(x)=0: enemy(x)=0
 if stab(x)=0 or ld(x)=1 or x=2 then goto 118
if ply>2 then t=0: z=1: gosub 105: friend(x)=y
 t=36: z=2: gosub 105: enemy(x)=y
118 next x: 

39  ss++: wend: goto begin

105 for y=1 to 6
if stab(y)<1 or x=y or (ld(y)=1 and z=1) then goto 149
v=stab(y)+pres(y)
if (v>t and z=1) or (v<t and z=2) then t=v
149 next y: 
158 repeat: y=fix(rnd*6): until x<>y and stab(y)>0 and ((stab(y)+pres(y)=t  and y<>friend(x)) or (ld(y)=1 and z=2)): 
return

label you
 locate 1,1 : print cat(2);fact (you);cat(-2);"     "; 
if win>0 then ? ,"     The End   " else ? seas(ss);"  ";year
? "Prestige: ";feel(fix(pres(you)/2))
? "Stability: ";stabs(stab(you));
 locate 2,21: ? "  MF: ";feel(fix(ystab(0)/2))
''? "Prestige: ";feel(fix(pres(you)/2))
return

label pick2   ''used by dip/subvert
181 gosub tap
if p5<125*siz or p5>155*siz or p4<5*siz or p4>155*siz then z=4.: goto 193
z=0: repeat: z++: until p4<((z*50)+5)*siz: 
193 return

label pick3 ''pick Country
 gosub tap
if p4<1*siz or p4>155*siz or p5<40*siz or p5>(155)*siz then turn=1: return
z=0: repeat: z++: until p5<(50+(z*22))*siz
return

label tap
PEN ON: REPEAT : DELAY 25 : UNTIL PEN(0):
  WHILE PEN(3) : DELAY 25 : WEND
p4=pen(4): p5=pen(5): pen off: 
return

label facts
data "The Alaud","Corvidae","Phasian","Turdid","Rallidia","Hirund"

label geo
data " ","1","1","2","1","2","1"," ","2","1","2","1","1","2"," ","1","1","2","2","1","1"," ","2","1","1","2","1","2"," ","1","2","1","2","1","1"," "

label feel
data "None","Lowest","Low","Average","High","Highest"

label seasons
data "Spring","Summer","Autumn","Winter"

label stabs
data "Anarchy","Civil Unrest","Unpopular","Weak","Weakening","Average","Strengthening","Strong","Popular","Autocratic","Unopposed"

Label rels
data "War","Casus Belli","Trade Embargo","Denouncing","Weak","Weakening","Improving","Workable","Favoured Trade","Full Support","Military Pact"

label newss
data " at war with "," hostile towards "," ceases trade with "," denounces ","","","",""," favours trade with "," fully supports "," makes pact with "

label win
237 if st=4 then st=0
cls: gosub you: locate 5,1: ? "After ";year-syear;" years and ";st;" seasons"
 ? "you have ";
if stab(2)>0 then ? "WON" else ? "LOST": ''pres(2)=0:  pres1(2)=0
st=(16-(((year-syear)*4)+st))*3
?: ? "You control ";pres1(2);" countries, through" :? "invasion, or as puppets."
? "You were caught commiting ";fd
? "Foul Deeds!"
? "Your final score is ";fix(max(min(((pres1(2)*10)+fix(oldpres(2)*5)+((stab(2)>0)*ss)-((stab(2)<1)*st)+stab(2)+((stab(2)>0)*10)),100),0)/((stab(2)<1)+1));"%": ?
? "   Can you do better?";
gosub tap: gosub 185
goto start

185 cls: gosub you
at 67*siz,33*siz: print "Stability  Relationship"
z=10: y=4
for x=1 to 6: if x=you then goto 192
rect (100-(stab(x)*4))*siz,(40+z)*siz,100*siz,(50+z)*siz,color 0 filled
at 5*siz,(35+z)*siz: ? fact(x)
rect 105*siz,(40+z)*siz, (105+(rel(you,x)*4))*siz,(50+z)*siz,color 0 filled
 if geo(you,x)=1 then at 3*siz,(45+z)*siz : ? "  (Neighbour)";
z=z+22
192 next x :  
z=5: y=1*siz: p=0: 
gosub pick3: if turn=1 then z=5:turn--: cls: return
dp=z: if z>=you then dp++

''your actions against dp 
239 cls:  locate 1,1 : print cat(2);fact(dp);cat(-2)
? "Prestige: ";feel(fix(pres(dp)/2));
locate 2,21: ? "MF: ";feel(round(ystab(dp)/2))
? "Internal Stability: ";stabs(stab(dp))
? "Relationship with you: ";rels(rel(you,dp)): ?
if stat(dp)>0 then locate 8,4: ? stat(dp): goto 258
dp2=friend(dp): dp1=enemy(dp):

locate 6,5: ? cat(2);fact(dp)+" News "; seas(ss);" ";year;cat(-2): 
for x=1 to 6: if x=dp then goto 259
if (rel(dp,x)>7 or rel(dp,x)<4) and stab(x)>0 then ? fact(dp);newss(rel(dp,x));fact(x): 
259 next x: if ypos=6 then ?:? "   No news this season!" 

258 if win>0 or stat(dp)>0 then gosub tap : goto 185
gosub 366: at 8*siz,130*siz: print "Diplomacy": at 105*siz,130*siz: print "Support/":  at 105*siz,142*siz :print "Destabilise"
turn=0: gosub pick2: on z goto 113,185,115,185

113 at 8*siz,130*siz: print "  Improve    ":  at 6*siz,142*siz :print "Relationship"
gosub 365: at 65*siz,130*siz: print " Cancel":  at 63*siz,142*siz :print "proposal"
at 105*siz,130*siz: print " Create an":  at 105*siz,142*siz :print " incident     "
turn=0: gosub pick2: 
rect 0,50*siz,160*siz,160*siz,15 filled
locate 7,1:
on z goto 270,280,290,239

270 if (charel(you,dp1)=1 or (rel(you,dp1)>7 and stab(dp1)>0)or charel(you,dp2)=-1 or (rel(you,dp2)<4 and stab(dp2)>0)) and friend(dp)<>you  then  ? fact(dp);" says:" :? "     Your relationship with other": ? "countries is causing us some concern": ? "Please call back later" :pause 1:  goto 295

charel(you,dp)=1: charel(dp,you)=1
 ? fact(dp);" says:" : ? "     We will consider your proposal...":  goto 295

280 charel(you,dp)=0: charel(dp,you)=0:  ? fact(dp);" says:": ? "Did we do something wrong?":  goto 295

''290 if ystab(dp)<1 or xtm(dp)=1 or friend(dp)=0 or friend(dp)=2 then goto 294
290 if ystab(dp)<1 or xtm(dp)=1 or ply<3 or friend(dp)=0 then goto 294
gosub 366: at 8*siz,130*siz: print "  Involving    ":  at 6*siz,142*siz :print "  Corvidae    "
 at 105*siz,130*siz: print "Involving   ":  at 101*siz,142*siz :print "Their Friend"
turn=0: gosub pick2: locate 7,1:
on z goto 294,239,291,239

291 dp1=friend(dp): ''if dp1=you then goto 239
''291 dp1=fix(rnd*6): if dp1=you or stab(dp1)<1 or dp=dp1 then goto 291
xtm(dp)=1 : if fix(rnd*6)+fix(rnd*6)-ystab(0)+int(ystab(dp))>=rel(dp,dp1) then goto 292 
locate 7,1:  ? fact(dp);" and ";fact(dp1);" warn ";fact(you);":": ? "     The World shall hear of this!": 
ystab(0)=min(ystab(0)+3,10): fd=fd+1 
wnews(wn)=fact(2)+" caught causing conflict": wn++: 
wnews(wn)="between "+fact(dp)+" and "+fact(dp1): wn++: 
rel(you,dp)=max(rel(you,dp)-1,0): rel(dp,you)=rel(you,dp)
rel(you,dp1)=max(rel(you,dp1)-1,0): rel(dp1,you)=rel(you,dp1) 
goto 295
292 friend(dp)=2: rel(dp1,dp)=max(rel(dp1,dp)-1,0): rel(dp,dp1)=rel(dp1,dp)
enemy(dp)=dp1: x=dp: goto 293
''charel(dp,dp1)=-1:charel(dp1,dp)=-1: 

294 charel(you,dp)=-1: charel(dp,you)=-1:  dp1=dp: x=2: 
293 locate 8,1:  ? fact(x);" blames ";fact(dp1);" following" 
? " a major international incident!":  
   ''? fact(dp);" says:" : ? "     Your opinions have been noted!":  

295 pause 2: goto 239

114 ''dummy line

115 gosub 365: at 8*siz,130*siz: print "    Support    ":at 6*siz,142*siz :print "G''vernment"   ''"    Support    "
 at 65*siz,130*siz: print "   No  ":  at 63*siz,142*siz :print "Support "
if ystab(dp)<3 or xtm(dp)=1 then  at 105*siz,130*siz: print "   Support  ": at 105*siz,142*siz :print "Opposition": goto 314
 at 105*siz,130*siz: print "    Covert   ":
at 105*siz,142*siz :print "    Actions   "
314 turn=0: gosub pick2: if chastab(dp)<>0 and z<>2 then goto 239
rect 0,50*siz,160*siz,160*siz,15 filled
 locate 7,1:  ? " Newsflash:" : locate 8,1:     
on z goto 300,310,320,239

300 chastab(dp)=1: chamed(dp)=0 : chamed(0)=chamed(0)-2
? fact(2);" gives support to ";fact(dp):  goto 295
310 chastab(dp)=0: chamed(dp)=0 : ? fact(2);" ignores ";fact(dp): goto 295
320 if ystab(dp)<3 or xtm(dp)=1 then goto 319
gosub 366: at 8*siz,130*siz: print "      Incite     ":  at 6*siz,142*siz :print "  Insurgents  "
 at 105*siz,130*siz: print " Extreme   ":  at 105*siz,142*siz :print " Measures "
turn=0: gosub pick2: 
rect 0,50*siz,160*siz,160*siz,15 filled
 locate 7,1:  ? " Newsflash:" : locate 8,1: 
on z goto 319,239,331,239

319  chamed(dp)=0.5 
if fix(rnd*6)+fix(rnd*6)-ystab(0)+int(ystab(dp))>=stab(dp) then goto 288
locate 8,1:  ? fact(dp);" warns ";fact(you);":": ? "Don''t meddle in the affairs of others!": rel(you,dp)=max(rel(you,dp)-1,0): rel(dp,you)=rel(you,dp) 
goto 295
288 chamed(dp)=1:chastab(dp)=-1:  
289 ? fact(2);" silent in support?":  
goto 295

331 gosub 366: at 8*siz,130*siz: print "Assassinate":  at 6*siz,142*siz :print "     Leader    "
 at 105*siz,130*siz: print "     Coup      ":  at 105*siz,142*siz :print "    D''etat    "
turn=0: gosub pick2: 
rect 0,50*siz,160*siz,123*siz,15 filled
 locate 7,1:  ? " Newsflash:" : locate 8,1:
337 on z goto 338,239,348,239

338 if ld(dp)=1 then ? " Your advisor says:": ? fact(dp);" is already leaderless": goto 295
xtm(dp)=1: if fix(rnd*6)+int(ystab(dp))>=pres(dp)-1 then goto 341
 ? fact(dp);" says:": 
? "     The World shall hear of this!": ystab(0)=min(ystab(0)+3,10): fd=fd+1 
wnews(wn)=fact(2)+" killers caught in "+fact(dp): wn++: rel(you,dp)=max(rel(you,dp)-2,0): rel(dp,you)=rel(you,dp) : goto 295
341 ? "Leader assassinated in ";fact(dp): ld(dp)=1: stab(dp)=int(stab(dp)/2): stab(2)=min(stab(2)+1,10): 
wnews(wn)="Leader assassinated in "+fact(dp): wn++: 
if stab(dp)<1 and ld(dp)=1 then stat(dp)="Leader assassinated": pres(dp)=0: ply--
goto 295

348  if geo(2,dp)=2 then ? " Your advisor says:": ? fact(dp);" is not our neighbour": goto 295
xtm(dp)=1: if fix(rnd*6)+int(ystab(dp))>stab(dp) then goto 351
 ? fact(dp);" says:": 
? "     The World shall hear of this!": ystab(0)=min(ystab(0)+3,10):
 fd=fd+1 :wnews(wn)=fact(2)+" fund coup in "+fact(dp): wn++: rel(you,dp)=max(rel(you,dp)-3,0): rel(dp,you)=rel(you,dp) : goto 295
351 ? "Major uprising  in ";fact(dp):  stab(dp)=int(stab(dp)/4): 
''pres(dp)=max(pres(dp)-4,0)
wnews(wn)="Major uprising  in  "+fact(dp):
if stab(dp)=0 then stat(dp)="Puppet government to "+fact(2): ply-- : wnews(wn)=fact(2)+" restores peace in "+fact(dp): pres1(2)=pres1(2)+1:pres(dp)=0:
wn++: stab(2)=min(stab(2)+1,10):
goto 295

365 rect 58*siz,125*siz,100*siz,155*siz
366 rect 5*siz,125*siz,58*siz,155*siz: 
 rect 100*siz,125*siz,150*siz,155*siz: 
return

label wnews
for x=0 to 10: wnews(x)=" ": next x
 wnews(1)="   No news this season!" : wn=1
return

label news
for x=0 to 8: news(x)=" ": next x
 news(1)="   No news this season!" : n=1
return

label prest
if stab(x)<1 then goto 354
newpres(x)=fix((rel(x,1)+rel(x,2)+rel(x,3)+rel(x,4)+rel(x,5)+rel(x,6)+stab(x))/6)-((x=2)*(int(ystab(0)/2)))-((x=2)*fd)
pres(x)=pres1(x)+newpres(x): stab(x)=stab(x)+(newpres(x)-oldpres(x))
pres(x)=max(min(pres(x),10),0)
oldpres(x)=newpres(x)
354 stab(x)=max(min(stab(x),10),0)
return
'
