
#sec:Main
' Crow.bas
' 08/02/2005
' Machiavellian politics in the Court of the Raven King
' By Gary Breinholt

label start
cls: ?: ? ,"Parliament of Crows"
?: ?"  Sing your song for sixpence,"
? "  just before you die."
? "  Four and twenty blackbirds,"
? "  sent in to spy."
? "  When the spy was opened"
? "  the bird began to sing."
? "  Now wasn't that a dangerous thing"
? "  to do before the King."
?: ? ,"   Children's nursery rhyme"
pause 20: cls
siz=1+(xmax>300)
? ,,"  RULES"
? "   Four and twenty Blackbirds"
? "   fill The Court of The Raven King."
? "   Whichever faction can control"
? "   the majority will usurp The King."
? "   Use bribery, blackmail, slander"
? "   and assassination to increase"
? "   the support for your faction,"
? "   or to reduce the support for others."
? "   Each Blackbird that you control"
? "   will contibute to your funds."
? "   Beware of leaving evidence of"
? "   your Foul Deeds... ";
pause 30: cls
?
? "   The game will end when one Faction"
? "   gains control of the majority of"
? "   the Blackbirds, currently at court."
?
? "   If the total number of Blackbirds"
? "   falls below 16, or the number of" ? "   active factions falls below 4, then"
? "   anarchy will prevail."
? "   Any one of the surviving factions"
? "   might seize control."

? "   However a tie for power will cause"
? "   the court to collapse... ";
pause 30: cls

19 locate 5,10: at 50*siz,(50+x*20)*siz:?"Pick your game":    'locate 5+x*2,10
restore scenes: for x=1 to 3: read n: rect 35*siz,(45+x*20)*siz,125*siz,(65+x*20)*siz :at 45*siz,(50+x*20)*siz:?n::next

22 gosub tap
if p4<35*siz or p4>125*siz or p5<65*siz or p5>125*siz then goto 22
z=0: repeat: z++: until p5<(65+z*20)*siz: ply=7-z: cply=ply: cls: locate 5,10

on 7-ply goto 23,24,25

23 ? "A Time of Peace... ":?
?"     In the Golden Age the Parliament of":?" Crows consisted of six factions, who":?" held an even balance of power.":?
?" Then someone read 'Il Principe'...": goto 29

24 ?"The Corvid Heresy":?
?"    Following the Corvid Heresy House": ?" Chough was banished and it's leaders":? " went into exile.":?:?" The vacancies were soon filled...": goto 29

25 ?"...A Time of War":?
?"    In a time of civil war House Jackdaw": ? " became extinct.":?:?" The Parliament of Crows tettered on": ?" the edge of anarchy..."

29 pause:
label setup
dim BBs(ply): dim imm(ply,ply): dim cash(ply): dim evi(ply,ply): dim ecourt(ply): dim fact(ply): dim ss(ply): dim order(ply): dim zone(ply)

restore facts: y=0: you=fix(rnd*ply): for x=0 to ply: read fact(x),ss(x): BBs(x)=4
cash(x)=500: if x<>you then zone(y)=fact(x): y++
next x: bbs(0)=4*ply:
if ply=4 then for x=1 to 2: y=fix(rnd*4): bbs(y)=bbs(y)+1:cash(y)=cash(y)+100: next y: bbs(0)=bbs(0)+2
court=24-bbs(0):
seas=1: year=1300+fix(rnd*550)

for y=1 to ply: for z=1 to ply:
if y<>z and fix(rnd*6)>4 then imm(y,z)=3
next z: next y


x=int(rnd*((9-ply)+3)): if ply=6 or x=0 then goto begin
for y=1 to x: cp=fix(rnd*ply): gosub foul: next y
for z=1 to ply: CP=z: if CP=you then gosub you
if fix(rnd*6)>=ply and ecourt(0)>1 then gosub gather: next z

label begin
seas=1
while seas<5: dim order(ply)
order(0)=1: while order(0)<ply+1
10 y=fix(rnd*ply): if order(y)>0 then goto 10
order(y)=order(0): order(0)=order(0)+1:wend

if fix(rnd*6)<6 then goto 68 66 CP=fix(rnd*ply): if BBs(CP)=0 then  goto 66
x=fix(rnd*3): for y=1 to x: gosub foul: next y

68 for go=1 to ply: CP=order(go)
for y=1 to ply: if imm(CP,y)>0 then imm(CP,y)=imm(CP,y)-1
next y earn=0: for y=1 to BBs(cp): earn=earn+fix(rnd*3)*50: next y: cash(cp)=min(1500,cash(cp)+earn):
if earn>bbs(cp)*120 and bbs(cp)>2 then gosub foul
if BBS(CP)=0 and cash(cp)<150 and evi(0,CP)<1 then goto 41
rv=-1: if CP=you then gosub play: goto 41
gosub you
locate 9,1: ?  fact(CP);"        ":?"takes turn ";go

'AI routines
try=0:hit=0: repeat: z=ply

dim czk(ply): czk(0)=1: while czk(0)<ply+1
39 y=fix(rnd*ply): if czk(y)>0 then goto 39
czk(y)=czk(0): czk(0)=czk(0)+1:wend
ldr=0: cp1=0: for x=1 to ply : if bbs(x)>7 and bbs(x)=ldr then cp1++
if bbs(x)>ldr then ldr=bbs(x): cp1=0
next x
38 need=(int(BBS(0)/2)+1)-BBs(CP)
DP=fix(rnd*ply): if hit>0 then DP=hit: if BBS(DP)<1 then hit=0: goto 38

n=0:tar=0: repeat:  n++
if czk(n)=CP and n<ply then n++

if cash(CP)>=(need*200) and BBs(czk(n))>=need and BBs(czk(n))>=1 and imm(czk(n),CP)<1 and CP<>czk(n) then exit loop: x=4:DP=czk(n): hit=DP: goto 37
if  imm(czk(n),CP)<1 and BBs(czk(n))>1  then dp=czk(n)

if  BBs(czk(n))+2>int(BBs(0)/2) and cash(cp)>300 then DP=czk(n): tar=1

until n=ply: if CP=DP then DP=fix(rnd*ply): tar=0: hit=0

if court>0 and cash(CP)>149 and BBs(CP)<((BBs(0)/2)-2)-evi(CP,0)-tar  then gosub recruit: goto 38

if DP=CP or BBs(DP)<1 or (BBs(DP)<2 and (cply=4 and need>1)) then goto 158

if tar=1 then goto 46
if fix(rnd*4)<=ecourt(0) and cash(CP)>149 then gosub gather: goto 38

if (cash(CP)>199 or evi(CP,dp)>1) and imm(CP,dp)<1 and BBs(dp)>1 and  (imm(dp,CP)>0 or BBs(dp)+BBs(CP)>=int(BBs(0)/2)-2 or evi(dp,CP)>1) then gosub immune: goto 38

if (cash(CP)>199 or evi(CP,you)>1) and imm(CP,you)<1 and BBs(you)>1 and  (imm(you,CP)>0 or BBs(you)+BBs(CP)>=int(BBs(0)/2) or evi(you,CP)>1) then DP=you: gosub immune: goto 38

if  imm(DP,CP)<1 and cply>4 then hit=DP

46 x=1
if  (evi(CP,DP)<2 or imm(DP,CP)>2) then x=2 else goto 37

if (evi(CP,DP)<1 or imm(DP,CP)>1) then x=3 else goto 37
if (cash(CP)>199 and imm(DP,CP)<1) then x=4:  goto 37
if tar=1 then 37
if (cash(CP)<600 or imm(DP,CP)<1 or fix(rnd*4< imm(DP,CP))) then x++ else goto 37
if x>3 then x=4
37 on x gosub black,reveal,ass,bribe

158 try++:until try=20 or (cash(CP)<150 and evi(0,CP)<1) or need<1

cls
41 if BBs(0)<16 or BBs(CP)>BBs(0)/2 or cply<4 then goto poem
next go: seas++: erase order

wend: year++: goto begin

label you
evi(0,0)=0: for x=1 to ply: evi(0,0)=evi(0,0)+evi(x,0):next x
cls: locate 1,1: print ss(seas);"  Year ";year;"   "
? "Blackbirds at Court: ";BBs(0): print
print cat(2);fact(you);cat(-2): print "Your Blackbirds: ";BBs(you): ? "Treasury: £";cash(you): ? "Foul Deeds: ";evi(you,0): ?
return

label play
turn=0: while turn=0 and (cash(you)>0 or evi(0,you)>0)
gosub you:?"Turn ";go: z=6: gosub grid: restore acts: y=1: for x=1 to 6
at 105*siz,y+(1*siz):read n: print n
at 102*siz,y+(12*siz):read n: print n
y=y+(25*siz): next x: at 125*siz,2*siz: print "(";ecourt(0);")": at 130*siz,102*siz: print "(";court;")":
gosub pick: if turn=1 then goto 49 else on z gosub 52,54,56,58,60,62: turn=0
49 wend: return

52 z=ply: y=26*siz: p=0: gosub zones: ? "Spying" : ? "Costs £150 to": ? "Gather Evidence (3)": ? "£10 to spy on a":? "Faction"
at 105*siz,2*siz: print "Gather" at 102*siz,13*siz: print "Evidence (";ecourt(0);")"
gosub pick: if turn=1 then goto 49
gosub rect: if z=1 then gosub gather else DP=len(zone(z-1))-2: gosub spy
goto 52
54 z=ply-1: y=1*siz:p=3: gosub zones: ? "Immunity": ? "Destroy 2 Evidence": ? "or £200 (£150 paid": ? "to the faction)"
gosub pick: if turn=1 then goto 49 gosub rect: DP=len(zone(z))-2: gosub immune
goto 54

56 z=ply-1:  y=1*siz: p=1: gosub zones: ? "Slander": ? "Reveals 1 Evidence.": ? "Needs immunity <2"
gosub pick: if turn=1 then goto 49
gosub rect:  DP=len(zone(z))-2: if imm(DP,CP)>1 then gosub immunity else gosub reveal
goto 56

58  z=ply-1:  y=1*siz: p=1: gosub zones: ? "Blackmail": ? "Returns 2 Evidence.": ? "Needs immunity <3": ? "(A Foul Deed)";
gosub pick: if turn=1 then goto 49
gosub rect:  DP=len(zone(z))-2: if imm(DP,CP)>2 then gosub immunity else gosub black
goto 58

60  z=ply:  y=26*siz: p=0: gosub zones: ? "Bribery": ? "Costs £150 to": ? "bribe The King  OR": ? "£200 and NO immunity":? "to bribe a Blackbird": ? "(A Foul Deed)";
at 105*siz,2*siz: print "Blackbird" at 102*siz,13*siz: print "Vacancies (";court;")"
gosub pick: if turn=1 then goto 49
gosub rect: if z=1 then gosub recruit else DP=len(zone(z-1))-2:  if imm(DP,CP)>0 then gosub immunity else gosub bribe
goto 60

62  z=ply-1:  y=1*siz:p=0: gosub zones: ? "Assassinate": ? "Costs £400 but risks a": : ? "Breach of Immunity": : ? "(or a Foul Deed)": ? "if discovered";
gosub pick: if turn=1 then goto 49
gosub rect:  DP=len(zone(z))-2: gosub ass
goto 62

label rect rect 0,100*siz,95*siz,160*siz,15 filled
return

label spy
if cash(CP)<10 then goto advice else cash(CP)=cash(CP)-10
110 for x=4 to 14: locate x,1: ?spc(42);: next x: locate 4,1: ? cat(2); "Report on ";fact(DP);cat(-2);"     ": ? "Blackbirds: ";bbs(DP);"     ":? "Treasury: £";cash(DP);"       ": ? "Foul deeds: ";evi(DP,0);"     ": ?
y=9: for x=1 to ply: if x=you and DP<>you then ? cat(2);
if x<>DP then print fact(x);": ": locate y,10: ?;imm(DP,x);" ";imm(x,DP),evi(DP,x);" ";evi(x,DP);cat(0):y++:
next x: pause
return

label gather
if cash(CP)<150 or ecourt(0)<1 then goto advice else cash(CP)= cash(CP)-150
locate 11,1
x=min(ecourt(0),3): for w=1 to x: y=fix(rnd*(ecourt(0))): n=0
repeat: n++: y=y-ecourt(n): until y<1
ecourt(0)=ecourt(0)-1: ecourt(n)=ecourt(n)-1:
evi(0,CP)=evi(0,CP)+1
evi(CP,n)=evi(CP,n)+1: if CP=n then evi(CP,0)=evi(CP,0)-1:  evi(0,CP)=evi(0,CP)-1
if CP<>you then goto 92
if n=you then ? "You erased a Foul Deed" else ? "You found evidence"
pause 1
92 next: pause 1
return

label immune
if imm(CP,DP)>0 or (cash(CP)<200 and evi(CP,DP)<2) or BBs(CP)<1 then goto advice
imm(CP,DP)=imm(CP,DP)+4:
if evi(CP,DP)>1 then evi(CP,DP)=evi(CP,DP)-2: evi(0,CP)=evi(0,CP)-2: evi(DP,0)=evi(DP,0)-2: goto 141
cash(CP)=cash(CP)-200:cash(DP)=cash(DP)+150
141 if CP=you then locate 11,1: ? "You have immunity":? "against ";fact(DP): pause 2
return

label reveal
if evi(CP,DP)<1 or imm(Dp,cP)>1 or BBs(DP)<1 then goto advice
evi(CP,DP)=evi(CP,DP)-1: evi(0,CP)=evi(0,CP)-1: evi(DP,0)=evi(DP,0)-1: BBs(dP)=BBs(dp)-1: BBs(0)=BBs(0)-1: court++
if cp=you then locate 11,1: ? "You expose ";squeeze(fact(Dp));"'s":? "foul deed." : ? "A Blackbird has been": ? "expelled from court.";: pause 3
if BBS(DP)<1 then goto dem
return

label black
if evi(CP,DP)<2 or imm(Dp,cP)>2 or BBs(DP)<1 then goto advice
evi(CP,DP)=evi(CP,DP)-2: evi(DP,0)=evi(DP,0)-2:  evi(0,CP)=evi(0,CP)-2:BBs(DP)=BBs(DP)-1: BBs(CP)=BBs(CP)+1: gosub foul
if CP=you then gosub pers
if BBS(DP)<1 then goto dem
return

label bribe
if cash(CP)<200 or imm(Dp,cP)>0 or BBs(DP)<1 then goto advice
cash(cP)=cash(CP)-200
if fix(rnd*6)>4 then 278
BBs(dP)=BBs(dp)-1: BBs(CP)=BBs(cP)+1: gosub foul
if cp=you then gosub pers
if BBS(DP)<1 then goto dem
return

278 cash(dp)=cash(dp)+100: if (cp=you or dp=you) then locate 11,1: ? "A Blackbird makes":? "a donation  ": pause 2
return

label recruit
if court<1 or cash(CP)<150 then goto advice else cash(CP)=cash(CP)-150: rv++
if CP=you then locate 11,1: ? "The Raven King takes":? "your money and "
w=0: if fix(rnd*6)<((BBs(0)/2)-BBs(CP))-evi(CP,0)+rv and int(BBs(0)/2)>BBs(CP) then BBs(CP)=BBs(CP)+1:court--: w=1:BBs(0)=BBs(0)+1: rv=-1
if CP<>you then return
if CP=you and w=1 then ? "grants you a blackbird"
if CP=you and w<>1 then ? "laughs in your face"
pause 3: return

label ass
if cash(CP)<400 or BBs(DP)<1 then goto advice cash(cP)=cash(CP)-400: if cp=you then locate 11,1: ? "A Hawk does the job": pause 1
if fix(rnd*6)<=bbs(dp) then goto 208 if cp=you then ? "He missed his prey": pause 1
goto 210 208 BBs(dP)=BBs(dp)-1: BBs(0)=BBs(0)-1: court++: if fix(rnd*6)>imm(dp,cp) then goto 210
if fix(rnd*6)<imm(dp,cp) then 209
if cp=you then ? "He also left a trail": pause 1
gosub foul: goto 210

209 if cp=you then ? "But was caught in the" : ? "act": pause 1
if dp=you then ? "You have caught a Hawk": pause 1
for y=1 to ply: if imm(CP,y)>0 then imm(CP,y)=imm(CP,y)-1
next y imm(cp,dp)=0

210  if BBs(DP)<1 then goto dem
return

label immunity
locate 11,1: ? squeeze(fact(DP));" has":?"immunity against you";: pause 2
return

label advice
if CP=you then locate 11,1: ? "Your Advisor tells you":?"that this is not possible";: pause 2
return
label pers
locate 11,1: ? "You persuade a":  ? "Blackbird to join you" :pause 2: return

label dem
if cp=you then for x=11 to 14: locate x,1: ?spc(42);: next x: locate 11,1: ? "You have caused the": ?"demise of "; fact(DP): pause 2
cash(DP)=0: cply--

for x=1 to ply: ecourt(x)=ecourt(x)+evi(DP,x): ecourt(0)=ecourt(0)+evi(DP,x): evi(DP,x)=0: evi(x,DP)=0
next x: evi(DP,0)=0: evi(0,DP)=0
ecourt(0)=ecourt(0)-ecourt(DP): ecourt(DP)=0

label foul
ecourt(CP)=ecourt(CP)+1
ecourt(0)=ecourt(0)+1
evi(CP,0)=evi(CP,0)+1
return

label zones
gosub you: for x=1 to ply-1: n=len(zone(x))-2
at 102*siz,y+(1*siz): print fact(n);" ";"(";BBs(n);")": at 110*siz,y+(12*siz)
if p=0 and imm(n,you)>0 then print "Immunity ";imm(n,you)
if p=1 and evi(you,n)>0 then print "Evidence ";evi(you,n)
if p=3 then  print " (";imm(you,n);")"," (";evi(you,n);")"
y=y+(25*siz): next x

label grid
x=1*siz: for n=1 to z
rect 98*siz,x,158*siz,x+(23*siz)
x=x+(25*siz)
next: locate 9,1
return

label pick
122 gosub tap
if p4<98*siz or p4>159*siz or p5<1 or p5>(z*25)*siz then turn=1: goto 49
z=0: repeat: z++: until p5<(z*25)*siz
return

label tap
PEN ON: REPEAT : DELAY 25 : UNTIL PEN(0)
 WHILE PEN(3) : DELAY 25 : WEND
p4=pen(4): p5=pen(5): pen off: return

label poem
cls: ?
?"  The King was in his Counting House,"
?"  counting out his money."
?"  The Queen lay in her parlour,"
?"  entertaining many."
?"  The Knave was in the Courtyard,"
?"  hawking all his views;"
?"  when up came a Blackbird"
?"  to spread the latest news:":
pause 5:locate 11,1:
if BBs(0)<16 or (cply<4 and bbs(cp)<=bbs(0)/2) or (evi(cp,0)>=bbs(cp)/2) then goto anarchy else goto win

label anarchy
?,"  Anarchy has broken out":y=bbs(0): bbs(0)=0
x=0: for z=1 to ply: x=x+(bbs(z)=max(bbs)):
if (bbs(z)+(int(cash(z)/200))-evi(z,0))>(bbs(cp)+(int(cash(cp)/200))-evi(cp,0)) and fix(rnd*6)>3 then cp=z
next ply
if bbs(cp)>9 and x<2 then ?, squeeze(fact(cp));" has seized power" else ? "   The Parliament of Crows has ended" :cp=0 bbs(0)=y:  goto 199

label win
?,"The Raven King is dead -": ?,"Long live the ";squeeze(fact(Cp));" King":
199 locate 14,5: if cp=0 then ? "EVERYONE LOSES";
if cp=you then ?, "YOU WIN";
if cp>0 and cp<>you then ?, "YOU LOSE";
pause

gosub you: CP=you: DP=CP: gosub 110
for DP=1 to ply: if DP<>CP then gosub 110
next
goto start

label scenes
data "A Time of Peace... ","The Corvid Heresy","...A Time of War"

label facts
data "Neutral","""Jay","Spring","Rook","Summer","Raven","Autumn","Magpie","Winter","Jackdaw","""Chough  ",""

label acts
data  "Spy", "£10/150", "Immunity","£200","Slander","1 Evidence","Blackmail","2 Evidence", "Bribe","£150/200", "Assassinate","£400"
