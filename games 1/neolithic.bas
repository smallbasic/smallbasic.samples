
''' Neolithic.bas
'' by Gary Breinholt
'' 31/01/2005

''The old chieftain is dead, YOU are the new.
''You have 3 years (12 seasons) to prove your worth.

''You start with 6 supporters: By providing for their needs you must aim to increase the support to 12 or more.

''Each season you wil allocate people to the HUNT - the remainder will be allocated to WORK.

''These people generate  points, which will be spent to ''buy'' the needed goods.
''Tap the desired item to buy it.

''BASIC REQUIREMENTS
''FOOD - The cost is for 2 units (feeds 2)
''HUTS - 1 hut houses 2 people

''NEEDS
''Prices vary season to season.
''The highest priced item is the one most desired in that season.

''LORE & FUR - created from hunting  
''TOOLS & CRAFTS - Created from work

''If more than half your people own the most desired item in a given season then support might increase. If less than half then support will decrease.

''HAPPY/UNHAPPY
''People expect to be fed and housed.
''They also react well to owning ALL of the items.
''Again this effects support.


label start

Y=1: T=6: M=6: H=0: HP=0: W=0
WP=0: F=0: HT=0: L=0: FR=0: TL=0
C=0: ppy=0: uppy=0: UNF=0: UNH=0
10  cls

while Y<4:
12 restore season: SS=1
while SS<5: read S,f1,ht1,l1,fr1,tl1,c1

label Allocate
H=0: t1=t: W=t1
13 gosub 90: locate 9,1:  ? "Hunters: ";H,"Workers: ";w

''Draw grid
rect 5,100,50,125: at 20,105: print "+1"
rect 50,100,95,125: at 70,105: print "+2"
 rect 95,100,140,125: at 115,105: print "+5"
 rect 5,125,50,155: at 10,130: print "Re-Set"
rect 50,125,95,155: ''at 60,130: print "TOOLS"
 rect 95,125,140,155: at 105,130: print "Done"

gosub pick

 if p4<5 or p4>140 or p5<98 or p5>155 then goto 13

if p5>125 then goto cont

if p4<50 then h=h+1: t1=t1-1
if p4<95 and p4>50 then h=h+2: t1=t1-2
if p4>95 then h=h+5: t1=t1-5
if t1<0 then goto allocate
w=t1:  goto 13

label cont
if p4<50 then goto allocate
w=t1: if p4<95 then goto 13

''W=T-H:  
if H>0 then HP=H*2+fix(rnd*6) else HP=0
if W>0 then WP=W*2+fix( rnd*6) else WP=0
''ap= fix( rnd*6)+fix( rnd*6)+fix( rnd*6)


while HP>=min(f1,l1,fr1) or WP>=min(ht1,tl1,c1)
gosub 90
''Draw grid
rect 5,100,50,125: at 10,100: print "FOOD":  at 10,110 :print "(";f1;")"
rect 50,100,95,125: at 60,100: print "LORE":  at 60,110 :print "(";l1;")"
 rect 95,100,140,125: at 105,100: print "FURS":  at 105,110 :print "(";fr1;")"
 rect 5,125,50,155: at 10,130: print "HUTS":  at 10,140 :print "(";ht1;")"
rect 50,125,95,155: at 60,130: print "TOOLS":  at 60,140 :print "(";tl1;")"
 rect 95,125,140,155: at 105,130: print "CRAFTS":  at 105,140 :print "(";c1;")"

gosub pick: gosub spend
wend

''Seasonal Adjustment
 UNF=0: F=F-T: if F<0 then UNF=F*-1: F=0
20 UNH=T-HT*2: if UNH<-1 then HT--: goto 20
if UNH<0 then UNH=0
gosub 100: ?: print ,S;" Adjustment         "
if fix(rnd*6)>3 then gosub bad
GM=min (L,FR,TL,C):
on SS gosub Spring, Summer, Autumn, Winter

if T=M then print ,"No change in support!": T=max(0,M)
if T>M then print ,"You lost support!": T=max(0,M)
''? "You lost ";int(F/3);" Food!": F=F-int(F/3)
if L>T then L=T
if FR>T then FR=T
if TL>T then TL=T
if C>T then C=T
if HT>fix (T/2) then HT=fix (T/2)
if ppy>T then ppy=T
if uppy>T then uppy=T
if T<M then print,"You gained support!"
T=max(0,M)
gosub 110: locate 14,10: print "PRESS ANY KEY";: pause
if T<2 then SS=5: Y=4
SS++
wend

Y++
wend
s="Spring"
cls: gosub 100: locate 11,11: if T<7 then print "Tough luck": ?"       You will be the next sacrifice!": pause: goto start
 if T>11 then print "Congratulations": ?"   You have become Chieftain-for-Life": pause: end
if T>9 and Y=4 then print "Not bad": ? "        The People are impressed": ?"You have  been granted another year.": pause:  goto 12
 print "Too bad": ?"    The People have chosen another.": pause:  goto start

label Season 
data "Spring",3,5,3,2,1,4,"Summer",2,6,4,1,2,3,"Autumn",4,5,2,3,4,1,"Winter",5,6,1,4,3,2

90  UNF=T-F: if UNF<0 then UNF=0
 UNH=T-HT*2: if UNH<0 then UNH=0
100 cls:
110  locate 1,1
 print  s;" Year ";Y: locate 1,15 : print "Supporters:  ";T;"   "
print "Happy:  ";ppy,"Unhappy:  ";uppy
print: print "Food: ",F;" (";UNF;" Unfed)"
print "Huts: ",HT;"  =  ";HT*2;"  Housed (";UNH;" Unhoused)"

print "Lore: ",L;"  ","Fur: ",FR;"  "
print "Tools: ",TL;"  ","Craft: ",C;"  "
print: print "Hunt: ",HP;" ","Work: ",WP;" "

return

label Spring
M++: uppy=T-GM: gosub happy
 if UNF>uppy then uppy=UNF: gosub happy
if uppy>ppy then M--
if C<T/2 then M--
if UNF=0 then M++
if C>T/2 then M++
return

label Summer
M++: ppy=GM: gosub nappy
 if UNF>uppy then uppy=UNF: gosub happy
if ppy=0 then M--
if L<T/2 then M--
if L>T/2 then M++
return

label Autumn
M--: uppy=T-GM: gosub happy
 if UNH>uppy then uppy=UNH: gosub happy
if TL<T/2 then M--
if UNF>2 then M--
''all housed
if TL>T/2 then M++
return

label Winter
M--: ppy=GM: gosub nappy
if UNH>uppy then uppy=UNH: gosub happy
if uppy>ppy then M--
if UNF>1 then M--
if UNH>2 then M--
if UNH=0 then M++
if FR>T/2 then M++
return

label happy
 if uppy+ppy>T then ppy=T-uppy
return

label nappy
 if uppy+ppy>T then uppy=T-ppy
return

label pick
122 pen on: while pen(0)=0: delay 50:
 wend: 
p4=pen(4): p5=pen(5): pen off: return

label spend
if p4<5 or p4>140 or p5<98 or p5>155 then goto old
oldhp=HP: oldwp=WP: oldf=F: oldht=HT:oldl=L: oldfr=FR: oldtl=TL: oldc=C
if p5>125 then goto work
if p4<50 then goto food else if p4>95 then goto fur
if HP>=l1  then HP=HP-l1: L++
return

label food
if HP>=f1 then HP=HP-f1: F=F+2
return
label fur
if HP>=fr1 then HP=HP-fr1: FR++
return

label old
HP=oldhp: WP=oldwp: F=oldf:  HT=oldht: L=oldl: FR=oldfr: TL=oldtl: C=oldc: return

label work
if p4<50 then goto hut else if p4>95 then goto craft
if WP>=tl1 then WP=WP-tl1: TL++
return

label hut
if WP>=ht1 and T>HT*2 then WP=WP-ht1: HT++
return

label craft
if WP>=c1 then WP=WP-c1: C++
return

label bad
x=fix(rnd*6): on x goto 161,162,163,164,165,166
161 if F>0 then print ,"Some food went bad": F=F-fix(rnd*3): if F<0 then F=0
return
162 if L>0 then print ,"Some lore was proved false": L=L-fix(rnd*3): if L<0 then L=0
return
163 if FR>0 then print ,"Some fur went moldy": FR=FR-fix(rnd*3): if FR<0 then FR=0
return
164 if HT>0 then print ,"A hut burnt down": HT--
return
165 if TL>0 then print ,"Some tools broke": TL=TL-fix(rnd*3): if TL<0 then TL=0
return
166  if c>0 then print ,."Some craftwork was stolen": c=c-fix(rnd*3): if c<0 then c=0
return'
