
'#sec:Main
'' Subversion.bas
'' 27/05/2006
'' Subversion and negotiation in a democratic society
'' By Gary Breinholt

''There are three Strata: Force, Influence, Wealth
''With two Elements in each Strata:
''	Force - Legal and Illegal
''	Influence - Social and Media
''	Wealth - Industrial and Government

''Following the Rule of FIW: Strata to the left are DOMINANT
''Elements within a strata are mutally OPPOSED.
''E.g. Groups in Force (Legal and Illegal) are DOMINANT to Influence (Social or Media)
''Groups in Media are OPPOSED to groups in Social.

''In each element there are three groups; each one is always controlled by one of the six factions.
''Therefore there are eighteen groups and each faction controls three groups at the start.

''The objective is to control the most groups at the end of three years (12 turns).

''The main screen displays your faction name, total power and the current date
''The grid shows the current power structure - your faction is in bold.

''Tap Intelligence to view the other factions.
''Immediatley you can see their total power and their view of you.
''Relationships go from Ally? to Enemy! (Ally - Trusts - Neutral - Distrusts - Enemy)
''Allies are more likely to support you and less likely to attack you.
''The reverse is true for Enemies

''Tap on a faction to view the world from their point of view
'' - you can now see what the chosen faction thinks of each of the others.

''Tap outside the grid to return to the main Intelligence screen (and maybe view another faction)
''Tap outside the grid again to return to the main screen.

''Tap Subvert to begin play, for that season
''Each faction gets to make one subversion attempt, against a specific group (and therefore against another Faction).

''A report flashes on the screen as each subversion attempt is made.
''This details the who, the where and the outcome.

''When it comes to your turn the main grid is displayed again, allowing you to review the situation.
''Tap subvert to continue and tap the group (Faction name) that you wish to subvert.

''REMEMBER THE RULE OF FIW:
''Force intimidates Influence,
''Influence manipulates Wealth,
''Wealth bribes Force

''The Attacker''s strength is 2 points per group that they control in the DOMINANT STRATA (i.e. both Elements)
'' Plus 1 point per group that they control in the OPPOSING element.

''The Defender''s strength is simply 2 points per group that they control, within the defending Element
''(The opposing element will give no support - even if you control groups within it).

''However, in addition, other Factions that control groups within the defending element
''may choose to give their support: 1 point per group that they control.
''Their decision is based on how they feel about the attacker and defender and if either party is currently winning.
''Giving support (or not) will have an effect on relationships.

''If you own a group within an attacked Element then the current subversion attempt (who and where) appears above the main grid.
''Take time to review the situation then tap the graffitti area to progress.
''You must decide whether to support the defender, or refuse to give support
''Supporting the defender will make them like you more, but will probably worsen your relationship with the attacker.
''Refusing to support will upset the defender but might possibly impress the attacker.

''The subversion attempt is resolved thus:
''Attack strength +1D6 must be greater than the Defence strength +1d6, for the subversion to be a success.

''At the end of 12 turns (Winter, Year 4) you have the chance to tap the Intelligence button,
''for a view of the final outcome.
''Tap anywhere to finish the game - The Illuminati will give their assessment.

label start
cls: 
?: ? ,,"  SUBVERSION"
? "   Political power is split between"
? "   eighteen groups, with "
? "   three groups in each element,"
? "   two elements in each strata,"
? "   and three strata in total"
?
? "   Use the Rule of FIW to subvert"
? "   as many as you can!"
?   
? "      Force Intimidates Influence"
? "      Influence Manipulates Wealth"
? "      Wealth Bribes Force";
pause 20: cls

siz=1+(xmax>300) 

label setup
dim rel(6,6): dim power(6): dim fact(6):  dim order(6): dim zone(6): dim grida(6,3,2): dim gridd(6,3,2): dim grid(3,2,3)
dim feel(5): dim type(3,2): dim seas(4)
win=0: dim wins(6)

restore facts: y=1: you=fix(rnd*4):
for x=1 to 6: read fact(x): if x<>you then zone(y)=fact(x): y++
for u=1 to 6: rel(x,u)=3: next u
power(x)=3
 next x

for z=1 to 3: for x=0 to 2: read type(z,x): next x: next z

for z=1 to 5: read feel(z): next z
for z=1 to 4: read seas(z): next z

year=2000+fix(rnd*150): yend=4

for x=1 to 6:  for y=1 to 3
44 w=fix(rnd*3): v=fix(rnd*2):u=fix(rnd*3): if grid(w,v,u)>0 then goto 44 else grid(w,v,u)=x: 
next y: next x

label begin
ss=1: year++: yend--: winner=max(power())
if yend=0 then goto win

while ss<5
dim order(6): rt=0
orders=1: while orders<7
10 y=fix(rnd*6): if order(y)>0 then goto 10
order(y)=orders: orders++:wend

cls: locate 2,1: ?"New Season": gosub info: gosub subvert
for go=1 to 6: CP=order(go):
if power(cp)<1 then goto 39

''creates attack defence grids
winner=max(power())
dim gridd(6,3,2)
for w=1 to 3: w2=w-1: if w2=0 then w2=3
 for v=1 to 2: v2=1+(v=1) : sa=0: sd=0:
for u=1 to 3
if grid(w2,v,u)=cp then sa=sa+2
if grid(w2,v2,u)=cp then sa=sa+2
if grid(w,v2,u)=cp then sa++
for x=1 to 6: if grid(w,v,u)=x then gridd(x,w,v)=gridd(x,w,v)+2: 
next x
next u: 
grida(cp,w,v)=sa
next v: next w

79 for x=1 to 3: for y=1 to 2:
grid(x,y,0)=max(gridd(1,x,y),gridd(2,x,y),gridd(3,x,y),gridd(4,x,y),gridd(5,x,y),gridd(6,x,y)):
next y: next x


if CP=you then gosub play: goto 39

''AI routines
t=0: if power(cp)<winner and (yend=1 and ss>2) then repeat: t=fix(rnd*6): until (winner=power(t) and t<>cp): if rel(cp,t)*2>fix(rnd*6)+fix(rnd*6)  then t=0

tar=-6: dp=0: for w=1 to 3: for v=1 to 2
if t>0 and gridd(t,w,v)=0 then goto 92

if grid(w,v,0)=4 and gridd(cp,w,v)<>2  then grid(w,v,0)=2
if t>0 then grid(w,v,0)=gridd(t,w,v)


 t1=grida(cp,w,v)-grid(w,v,0)
if t1>tar then tar=t1
92 next v: next w:



dim stack(6,1): x=0: 
for w=1 to 3: for v=1 to 2
if t>0 and gridd(t,w,v)<>grid(w,v,0) then goto 80
if grida(cp,w,v)-grid(w,v,0)<>tar then goto 80

x++: if gridd(cp,w,v)=4 then x=1
stack(x,0)=w: stack(x,1)=v:

 80 next v: next w:

84 y=fix(rnd*x): w=stack(y,0): v=stack(y,1)
on grid(w,v,0)/2 goto 85,86,85
85 if gridd(cp,w,v)=4 then goto 86
u=fix(rnd*3): if gridd(grid(w,v,u),w,v)=4 and gridd(cp,w,v)<>2 then grid(w,v,0)=2: goto 86
goto 90
86 u=0: repeat: u++: until gridd(grid(w,v,u),w,v)=grid(w,v,0)
90 dp=grid(w,v,u): if dp=cp or rel(cp,dp)*2>=fix(rnd*6)+fix(rnd*6)+((power(dp)=winner)*int((4-yend)/2)) then goto 84
rel(cp,dp)=max(rel(cp,dp)-2,1)

93 rect 0,11*siz,160*siz,48*siz,15 filled
locate 3,1: print squeeze(fact(cp)); " attempts to subvert" 
? cat(dp=you);squeeze(fact(dp));cat(-1);" in ";type(w,v);" ";type(w,0)

96 rect 0,48*siz,160*siz,160*siz,15 filled

''check for support 
s1=" ": s2=" ": a=" "
if dp<>you and cp<>you and gridd(you,w,v)>0 then gosub support: s1=a
y=7: for x=1 to 3: if grid(w,v,x)=dp or grid(w,v,x)=cp or grid(w,v,x)=y or grid(w,v,x)=you then goto  94
y=grid(w,v,x)
cpaid=((power(dp)=winner)*fix((4-yend)/2))+(rel(y,cp)*2>fix(rnd*6)+fix(rnd*6))*rel(y,cp)
dpaid=((power(cp)=winner)*fix((4-yend)/2))+(rel(y,dp)*2>=fix(rnd*6)+fix(rnd*6))*rel(y,dp)
if cpaid>dpaid then gosub cpaid else gosub dpaid
if s1=" " then s1=a else s2=a
94 next x
rel(dp,cp)=max(rel(dp,cp)-1,1)
locate 6,3: ? s1: ? "    ";s2:
 ?: ? squeeze(fact(cp));
if grida(cp,w,v)+fix(rnd*6)>gridd(dp,w,v)+fix(rnd*6) then goto 112

''if grida(cp,w,v)>gridd(dp,w,v) then goto 112
? " fails to subvert": goto 38

112 grid(w,v,u)=cp: power(cp)=power(cp)+1: power(dp)=power(dp)-1: rel(dp,cp)=max(rel(dp,cp)-2,1): ? " succesfully subverts"
38 delay 1500:

39  gosub you: next go: 
ss++: wend: goto begin

label play
cls: locate 2,1: ?"Your Turn": gosub info: gosub subvert
56 rect 4*siz,20*siz,160*siz,48*siz,15 filled: locate 4,1: ? "Select a group to subvert"

122 gosub tap
if p5<65*siz or p5>152*siz or p4<5 or p4>155*siz or (p5>95*siz and p5<122*siz) then goto 122
w=1+(p4>50*siz)+(p4>95*siz)
v=1+(p5>120*siz): if v=1 then p5=p5+57*siz
u=1+(p5>132*siz)+(p5>142*siz)
dp=grid(w,v,u): if dp=cp then goto 122
goto 93

113 return

114 ''dummy line

''Intelligence
115 turn=0: cp1=you: 
141 cls:  locate 1,1 : print cat(2);fact (you);cat(-2);" (";power(you);")    "
 z=5: y=1*siz: p=0: gosub zones: 

? "Who do you want": ?"to know about?"
gosub pick: if turn=0 then goto 154
if yend<1 then return 
cls: gosub info: goto subvert 
154  you=len(zone(z))-2 
 z=4: y=1*siz: p=0: gosub zones2:gosub pick: ''if turn=0 then goto 154
you=cp1: cp1=0: goto 115

 178 y=1: 
for x=1 to 6:  if x<>you then zone(y)=fact(x): y++
next x: return

label you
 locate 1,1 : print cat(2);fact (you);cat(-2);" (";power(you);")    "; seas(ss);"  ";year;" - Year ";4-yend:
return

label zones2
cls:  locate 1,1 : print cat(2);fact (you);cat(-2);" (";power(you);")    "
for x=1 to 5: n=len(zone(x))-2:  if  n=you then goto 222
at 102*siz,y+(1*siz): print fact(n);" ";"(";power(n);")": at 110*siz,y+(12*siz): print "(";feel(rel(you,n));")"
y=y+(25*siz): 
222 next x
locate 5,1: ? "Their view of you:": ? cat(1);feel(rel(you,cp1));cat(-1): ? 
? "   view of the others:"
goto grid

label zones
cls:  locate 1,1 : print cat(2);fact (you);cat(-2);" (";power(you);")    "
for x=1 to 5: n=len(zone(x))-2:
at 102*siz,y+(1*siz): print fact(n);" ";"(";power(n);")": at 110*siz,y+(12*siz): print "(";feel(rel(n,you));")"
y=y+(25*siz): next x

label grid
x=1*siz: for n=1 to z
rect 98*siz,x,158*siz,x+(23*siz)
x=x+(25*siz)
next: locate 6,1
 return

label pick1
122 gosub tap
if p5<125*siz or p5>155*siz or p4<5*siz or p4>155*siz then goto 122
z=0: repeat: z++: until p4<((z*45)+5)*siz
return

label pick2   ''used by subvert
126 gosub tap
if p5<30*siz or p5>45*siz or p4<5*siz or p4>150*siz then goto 126
z=0: repeat: z++: until p4<((z*50)+5)*siz: if z=2 then goto 126
return

label pick3 ''used by support
181 gosub tap
if p5<125*siz or p5>155*siz or p4<5*siz or p4>155*siz then goto 181
z=0: repeat: z++: until p4<((z*50)+5)*siz: if z=2 then goto 181
return

label pick  ''used by intelligence
124 gosub tap
if p4<98*siz or p4>159*siz or p5<1 or p5>(z*25)*siz then turn=1: return
z=0: repeat: z++: until p5<(z*25)*siz
return

label tap
PEN ON: REPEAT : DELAY 25 : UNTIL PEN(0):
  WHILE PEN(3) : DELAY 25 : WEND
p4=pen(4): p5=pen(5): pen off: 
return

label facts
data "Jay","Rook","Raven","Magpie","Jackdaw","Chough  "

label type
data "Force","Legal","Illegal","Influence","Social","Media","Wealth","Industrial","Government"

label feel
data "Enemy!","Distrusts","Neutral","Trusts","Ally?"

label seasons
data "Spring","Summer","Autumn","Winter"

label grps
data "","","Three","Four","Five","Six","Seven","Eight","Nine","Ten","Eleven","Twelve","Thirteen","Fourteen","Fifteen"

label win
ss=4: year-- 
237 cls: gosub info: locate 3,5: ? "The End"
rect 95*siz,30*siz,150*siz,45*siz: at 100*siz,32*siz: print  "Intelligence"
turn=0: 
240 gosub tap
if p5>30*siz and p5<45*siz and p4>95*siz and p4<150*siz then gosub 115: goto 237

z=0: for x=1 to 6
if power(x)=winner then z++: wins(z)=x: 
next x
win=6-(z>1)-((winner<6)*2)-((winner<7)*2)+(winner>9)+(winner=15)
restore grps: for x=1 to winner: read grps: next x

264  cls: locate 2,1: on win gosub 329,330,331,332,333,334,335,336  : pause: goto start

329 ?: ?, ,"WOEFUL!"
?: ?"    Minor gains were made by: "
for x=1 to z: 
print,, cat(wins(x)=you);fact(wins(x));cat(-1):
next x:

? "    They each control ";grps;" groups."
?: ? "    The Illuminati laugh at them!"
return

330 ?: ?: ? ,"PATHETIC!"
?: ? , "Only ";grps;" groups are controlled"
? ,,"by ";fact(wins(z))
?: ?"    The Illuminati are not impressed!"
return

331  ?: ? ,,"DISAPPOINTING..."
?: ?"    Minor power is shared by: "
for x=1 to z: 
print,, cat(wins(x)=you);fact(wins(x));cat(-1):
next x:
? "    They each control ";grps;" groups."
?: ? "    The Illuminati expect better results."
return

332 ?: ?, ,"ACCEPTABLE!"
?: ? , grps;" groups are controlled"
?,"by ";fact(wins(z))
?: ? ,,"The Illuminati acknowledge "
?,, "their good effort"
return

333  ?: ? ,,"IMPRESSIVE..."
?: ? "    Major power is shared by: "
print,, cat(wins(1)=you);fact(wins(1));cat(-1);" and ";cat(wins(2)=you);fact(wins(2));cat(-1)

?:?  "    They each control ";grps;" groups."
?: ? "    The Illuminati respects their"
?,"machiavellian efforts"
return

334 ?: ?, ,"WELL DONE!"
?: ? , grps;" groups are controlled"
?,"by ";fact(wins(z))
?: ? ,,"The Illuminati praise them"
?, "for their clever manipulations"
return

335 ?: ?, ,"CONGRATULATIONS!"
?: ? , grps;" groups are controlled"
? ,"by ";fact(wins(z))
?: ?"    The Illuminati honour them"
? "    for achieving majority control"
return

336 ?: ?, ,"AMAZING!"
?: ? , grps;" groups are controlled"
? ,"by ";fact(wins(z))
?, "This is the best result possible."
?: ?"    The Illuminati are in awe"
? "    of their deviousness."
return

label support
gosub info: pause: 
rect 0,48*siz,160*siz,160*siz,15 filled
locate 6,1: ? cat(2);"Their views of you;";cat(-2): ? squeeze(fact(cp));" (";power(cp);"): ";feel(rel(cp,you)),"Attack: ";grida(cp,w,v): 
? squeeze(fact(dp));" (";power(dp);"): ";feel(rel(dp,you)),"Defence: ";gridd(dp,w,v): 
?: ?."Support ";squeeze(fact(dp));"?"

 rect 5*siz,125*siz,60*siz,155*siz: at 7*siz,130*siz: print "Support":  at 7*siz,142*siz :print fact(dp)

 rect 95*siz,125*siz,150*siz,155*siz: at 100*siz,130*siz: print "Refuse":  at 100*siz,142*siz :print "Support"

turn=0:y=you: gosub pick3: 
rect 1,48*siz,160*siz,160*siz,15 filled
on z goto dpaid,114,cpaid

 label cpaid
a=squeeze(fact(y))+" refuses to support"
rel(dp,y)=max(rel(dp,y)-1,1): rel(y,dp)=max(rel(y,dp)-1,1):
if rel(cp,y)>=fix(rnd*6) then rel(cp,y)=min(rel(cp,y)+1,5): rel(y,cp)=min(rel(y,cp)+1,5):
return

label dpaid
gridd(dp,w,v)=gridd(dp,w,v)+gridd(y,w,v)/2: a=squeeze(fact(y))+" supports "+fact(dp)
if rel(cp,y)>=fix(rnd*6) then rel(cp,y)=max(rel(cp,y)-1,1): rel(y,cp)=max(rel(y,cp)-1,1)
rel(dp,y)=min(rel(dp,y)+1,5): rel(y,dp)=min(rel(y,dp)+1,5)
return

label info
''cls
100 gosub you
rect 5*siz,50*siz,50*siz,105*siz: at 10*siz,52*siz: print cat(2);"Legal";cat(-2)
rect 50*siz,50*siz,95*siz,105*siz: at 60*siz,52*siz: print cat(2);"Social";cat(-2);
 rect 95*siz,50*siz,155*siz,105*siz: at 105*siz,52*siz: print cat(2);"Industrial";cat(-2)
 rect 5*siz,105*siz,50*siz,155*siz: at 10*siz,107*siz: print cat(2);"Illegal";cat(-2)
rect 50*siz,105*siz,95*siz,155*siz: at 60*siz,107*siz: print cat(2);"Media";cat(-2)
 rect 95*siz,105*siz,155*siz,155*siz: at 100*siz,107*siz: print cat(2);"Government";cat(-2)

for t=1 to 3:for s =1 to 2: for r=1 to 3
at (70*(t-1))+(t*10)*siz,((s*56)+(r*10))*siz: 
print cat(grid(t,s,r)=you);fact(grid(t,s,r)); cat(-1)
next r: next s:next t:
return

label subvert
rect 5*siz,30*siz,60*siz,45*siz: at 15*siz,32*siz: print "Subvert":  

 rect 95*siz,30*siz,150*siz,45*siz: at 100*siz,32*siz: print  "Intelligence"

turn=0: gosub pick2: on z goto 113,114,115
'
