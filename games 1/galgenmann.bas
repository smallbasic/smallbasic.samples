
'DIM W(25)
DIM Word$(11)

label home

Wrong=0:Check=0:Hit=0:GotIt=0
FOR a = 0 to 25:W(a)=0:next a
d=0
color 0,15
cls
color 12,15
?CAT(1);"Carstens SmallBASIC Galgenmann";CAT(0)
?CAT(1);"   Based on SB Novices Hangman";CAT(0)
?""


GOSUB Database
XA=20:COLOR 1,15
FOR GW = 1 TO LEN(HM$)
Word$(GW)=UCASE$(MID$(HM$,GW,1))
AT XA, 160:?"_"
XA = XA + 20
NEXT GW


color 0,15
X1=5
Y1=185
Char=65
COLOR 2,15
for a = 1 to 4
   for b = 1 to 7
      pset 5+c,185+d:rect 35+c,215+d:AT 10+c,190+d:?Chr$(Char)
      if a=4 and b=6:AT 10+c,190+d:?"Neu":fi
      if a=4 and b=7:AT 10+c-3,190+d:?"Ende":fi
      c=c+32
     Char=Char+1
   next b
   d=d+32:c=0
next a

while 1
pen on
if pen(0)then
  x=pen(4)
  y=pen(5)
  X1=5:Y1=185:Lx=1
  for a = 1 to 7
   if x>X1 and x<X1+30 then
     for b = 1 to 4
      if y>Y1 and y<Y1+30:AT X1+5,Y1+5:?"   ":fi
      if y>185 and y<217
   if x>5 and x<37 and W(0)=0:W$="A":W(0)=1:GOSUB CheckABC:fi
   if x>37 and x<69 and W(1)=0:W$="B":W(1)=1:GOSUB CheckABC:fi
   if x>69 and x<101 and W(2)=0:W$="C":W(2)=1:GOSUB CheckABC:fi
   if x>101 and x<133 and W(3)=0:W$="D":W(3)=1:GOSUB CheckABC:fi
   if x>133 and x<165 and W(4)=0:W$="E":W(4)=1:GOSUB CheckABC:fi
   if x>165 and x<197 and W(5)=0:W$="F":W(5)=1:GOSUB CheckABC:fi
   if x>197 and x<229 and W(6)=0:W$="G":W(6)=1:GOSUB CheckABC:fi
      fi
      if y>217 and y<249
   if x>5 and x<37 and W(7)=0:W$="H":W(7)=1:GOSUB CheckABC:fi
   if x>37 and x<69 and W(8)=0:W$="I":W(8)=1:GOSUB CheckABC:fi
   if x>69 and x<101 and W(9)=0:W$="J":W(9)=1:GOSUB CheckABC:fi
   if x>101 and x<133 and W(10)=0:W$="K":W(10)=1:GOSUB CheckABC:fi
   if x>133 and x<165 and W(11)=0:W$="L":W(11)=1:GOSUB CheckABC:fi
   if x>165 and x<197 and W(12)=0:W$="M":W(12)=1:GOSUB CheckABC:fi
   if x>197 and x<229 and W(13)=0:W$="N":W(13)=1:GOSUB CheckABC:fi
      fi
      if y>249 and y<281
   if x>5 and x<37 and W(14)=0:W$="O":W(14)=1:GOSUB CheckABC:fi
   if x>37 and x<69 and W(15)=0:W$="P":W(15)=1:GOSUB CheckABC:fi
   if x>69 and x<101 and W(16)=0:W$="Q":W(16)=1:GOSUB CheckABC:fi
   if x>101 and x<133 and W(17)=0:W$="R":W(17)=1:GOSUB CheckABC:fi
   if x>133 and x<165 and W(18)=0:W$="S":W(18)=1:GOSUB CheckABC:fi
   if x>165 and x<197 and W(19)=0:W$="T":W(19)=1:GOSUB CheckABC:fi
   if x>197 and x<229 and W(20)=0:W$="U":W(20)=1:GOSUB CheckABC:fi
      fi
      if y>281 and y<313
   if x>5 and x<37 and W(21)=0:W$="V":W(21)=1:GOSUB CheckABC:fi
   if x>37 and x<69 and W(22)=0:W$="W":W(22)=1:GOSUB CheckABC:fi
   if x>69 and x<101 and W(23)=0:W$="X":W(23)=1:GOSUB CheckABC:fi
   if x>101 and x<133 and W(24)=0:W$="Y":W(24)=1:GOSUB CheckABC:fi
   if x>133 and x<165 and W(25)=0:W$="Z":W(25)=1:GOSUB CheckABC:fi
   if x>165 and x<197 THEN GOTO home
   if x>197 and x<229:cls:?"Danke f&#252;r''s Spielen":?"Und danke an SmallBASIC, Novice etc. !":end:fi
      fi
      Y1=Y1+32
     next b
   fi
   X1=X1+32
  next a
  IF Hit=0 and Check=1 THEN GOSUB DrawHangman
  Check=0:Hit=0
fi
wend

LABEL CheckABC
XA=20
FOR GW=1 TO LEN(HM$)
if Word$(GW)=W$:color 2:AT XA,160:?CAT(1);W$;CAT(0):Hit=1:GotIt=GotIt+1:fi
Check=1
XA=XA+20
if GotIt=LEN(HM$):COLOR 4:LOCATE 3,15:?"Gewonnen!!":GOSUB Clean:FI
NEXT GW
RETURN


LABEL DrawHangman
Wrong=Wrong+1
if Wrong=1: for z = 30 to 34:color 4:pset 10,z:line 90,z:next z:FI
if Wrong=2: for z = 85 to 89:color 4:pset z,34:line z,150:next z:FI
if Wrong=3: for z = 40 to 42:color 2:pset z,34:line z,44:next z:FI
if Wrong=4: color 13:circle 41,50,10 filled:FI
if Wrong=5: for z = 34 to 48:color 9:pset z,62:line z,100:next z:FI
if Wrong=6: for z = 65 to 68:color 9:pset 10,z:line 32,z:next z:FI
if Wrong=7: for z = 65 to 68:color 9:pset 51,z:line 73,z:next z:FI
if Wrong=8: for z = 27 to 31:color 10:pset z,95:line z,140:next z:FI
if Wrong=9:
for z = 51 to 55:color 10,15:pset z,95:line z,140:next z
LOCATE 3,15:color 12,15:?"Verloren!!"
GOSUB Clean
RETURN

LABEL Clean
color 2,15
c=0:d=0
for a = 0 to 25:W(a)=1:next a
for a = 1 to 4
for b = 1 to 7
  pset 5+c,185+d:rect 35+c,215+d:AT 10+c,190+d:?"   "
  if a=4 and b=6:AT 10+c,190+d:?"Neu":fi
  if a=4 and b=7:AT 10+c-3,190+d:?"Ende":fi
  c=c+32
  Char=Char+1
next b
d=d+32:c=0
next a


FI
RETURN



Label Database
RANDOMIZE TIMER
Guess=INT(RND*192)+1
if Guess=1 then HM$="Ahnherr"
if Guess=2 then HM$="Ahnung"
if Guess=3 then HM$="Ahorn"
if Guess=4 then HM$="Akademie"
if Guess=5 then HM$="Akklamation"
if Guess=6 then HM$="Akklimatisierung"
if Guess=7 then HM$="Akquisiteur"
if Guess=8 then HM$="Akribie"
if Guess=9 then HM$="Aktendeckel"
if Guess=10 then HM$="Alpen"
if Guess=11 then HM$="Ansager"
if Guess=12 then HM$="Antidepressivum"
if Guess=13 then HM$="Apfelkuchen"
if Guess=14 then HM$="Apparat"
if Guess=15 then HM$="Argumentationsfolge"
if Guess=16 then HM$="Arsenal"
if Guess=17 then HM$="Assistenzarzt"
if Guess=18 then HM$="Attentaeter"
if Guess=19 then HM$="Atavismus"
if Guess=20 then HM$="Authentizitaet"
if Guess=21 then HM$="Bagatelle"
if Guess=23 then HM$="Ballermann"
if Guess=24 then HM$="Dauerauftrag"
if Guess=25 then HM$="Dauerbrenner"
if Guess=26 then HM$="Dauererfolg"
if Guess=27 then HM$="Dauerhaftigkeit"
if Guess=28 then HM$="Dauerlauf"
if Guess=29 then HM$="Dauerzustand"
if Guess=30 then HM$="Daumen"
if Guess=31 then HM$="Daune"
if Guess=32 then HM$="Deaktivierung"
if Guess=33 then HM$="Debatte"
if Guess=34 then HM$="Debattenpunkt"
if Guess=35 then HM$="Deckadresse"
if Guess=36 then HM$="Deckbett"
if Guess=37 then HM$="Deckblatt"
if Guess=38 then HM$="Deckel"
if Guess=39 then HM$="Deckelblatt"
if Guess=40 then HM$="Deckfarbe"
if Guess=41 then HM$="Deckmantel"
if Guess=42 then HM$="Deckname"
if Guess=43 then HM$="Deckung"
if Guess=44 then HM$="Decoder"
if Guess=45 then HM$="Decodiereinheit"
if Guess=46 then HM$="Decodierung"
if Guess=47 then HM$="Deduktion"
if Guess=48 then HM$="Defaultwert"
if Guess=49 then HM$="Defensivposition"
if Guess=50 then HM$="Definiertheit"
if Guess=51 then HM$="Definition"
if Guess=52 then HM$="Defizit"
if Guess=53 then HM$="Deflation"
if Guess=54 then HM$="Degen"
if Guess=55 then HM$="Degeneration"
if Guess=56 then HM$="Degradierung"
if Guess=57 then HM$="Degression"
if Guess=58 then HM$="Dehnbarkeit"
if Guess=59 then HM$="Dehnung"
if Guess=60 then HM$="Deich"
if Guess=61 then HM$="Deichsel"
if Guess=62 then HM$="Dekade"
if Guess=63 then HM$="Dekadenz"
if Guess=64 then HM$="Dekalog"
if Guess=65 then HM$="Dekan"
if Guess=66 then HM$="Dekanat"
if Guess=67 then HM$="Deklamation"
if Guess=68 then HM$="Deklamator"
if Guess=69 then HM$="Deklaration"
if Guess=70 then HM$="Deklarationspflicht"
if Guess=71 then HM$="Deklination"
if Guess=72 then HM$="Dekor"
if Guess=73 then HM$="Dekorateur"
if Guess=74 then HM$="Dekoration"
if Guess=75 then HM$="Dekret"
if Guess=76 then HM$="Delegation"
if Guess=77 then HM$="Delikatesse"
if Guess=78 then HM$="Delikt"
if Guess=79 then HM$="Delirien"
if Guess=80 then HM$="Delirium"
if Guess=81 then HM$="Delle"
if Guess=82 then HM$="Delphin"
if Guess=83 then HM$="Delta"
if Guess=84 then HM$="Demagoge"
if Guess=85 then HM$="Demagogie"
if Guess=86 then HM$="Demarkationslinie"
if Guess=87 then HM$="Dementi"
if Guess=88 then HM$="Dementierung"
if Guess=89 then HM$="Demobilisierung"
if Guess=90 then HM$="Demokrat"
if Guess=91 then HM$="Elefant"
if Guess=92 then HM$="Empirismus"
if Guess=93 then HM$="Gartenzwerg"
if Guess=94 then HM$="Geisterbahn"
if Guess=95 then HM$="Guntershagen"
if Guess=96 then HM$="Gaensewein"
if Guess=97 then HM$="Geheimrat"
if Guess=98 then HM$="Hebewerk"
if Guess=99 then HM$="Heu"
if Guess=100 then HM$="Hundekuchen"
if Guess=101 then HM$="Hausverwalter"
if Guess=102 then HM$="Identifikation"
if Guess=103 then HM$="Internetprovider"
if Guess=104 then HM$="Inselurlaub"
if Guess=105 then HM$="Jungbrunnen"
if Guess=106 then HM$="Jagdschloss"
if Guess=107 then HM$="Jurisprudenz"
if Guess=108 then HM$="Kaeltekompresse"
if Guess=109 then HM$="Konsistenz"
if Guess=110 then HM$="Korallenriff"
if Guess=111 then HM$="Kindergarten"
if Guess=112 then HM$="Lampenschirm"
if Guess=113 then HM$="Lederhose"
if Guess=114 then HM$="Landeshauptstadt"
if Guess=115 then HM$="Lurch"
if Guess=116 then HM$="Leberwurst"
if Guess=117 then HM$="Musterkoffer"
if Guess=118 then HM$="Magnetschwebebahn"
if Guess=119 then HM$="Meister"
if Guess=120 then HM$="Massenproduktion"
if Guess=121 then HM$="Numismatik"
if Guess=122 then HM$="Nautilist"
if Guess=123 then HM$="Neuerwerbung"
if Guess=124 then HM$="Nachbau"
if Guess=125 then HM$="Nougatcreme"
if Guess=126 then HM$="Nasentropfen"
if Guess=127 then HM$="Oberamtsarzt"
if Guess=128 then HM$="Offensive"
if Guess=129 then HM$="Osterweiterung"
if Guess=130 then HM$="Plagiator"
if Guess=131 then HM$="Pruefplakette"
if Guess=132 then HM$="Praesidentschaftskandidat"
if Guess=133 then HM$="Perceptron"
if Guess=134 then HM$="Pallindrom"
if Guess=135 then HM$="Perserteppich"
if Guess=136 then HM$="Perserkatze"
if Guess=137 then HM$="Rasenmaeher"
if Guess=138 then HM$="Rostentferner"
if Guess=139 then HM$="Rudel"
if Guess=140 then HM$="Richter"
if Guess=141 then HM$="Randalierer"
if Guess=142 then HM$="Strassenbahn"
if Guess=143 then HM$="Sandkuchen"
if Guess=144 then HM$="Saftschorle"
if Guess=145 then HM$="Semperoper"
if Guess=146 then HM$="Trachtenverein"
if Guess=147 then HM$="Turnverein"
if Guess=148 then HM$="Tanzclub"
if Guess=149 then HM$="Tiger"
if Guess=150 then HM$="Tornado"
if Guess=151 then HM$="Totalschaden"
if Guess=152 then HM$="Tomatencremesuppe"
if Guess=153 then HM$="Tzunami"
if Guess=154 then HM$="Terpentin"
if Guess=155 then HM$="Terminalemulation"
if Guess=156 then HM$="Transponderfrequenz"
if Guess=157 then HM$="Trampolin"
if Guess=158 then HM$="Terminator"
if Guess=159 then HM$="Ueberschallflugzeug"
if Guess=160 then HM$="Unternehmergeist"
if Guess=161 then HM$="Unabdingbarkeit"
if Guess=162 then HM$="User"
if Guess=163 then HM$="Uebergabeprotokoll"
if Guess=164 then HM$="Vereinsvorstand"
if Guess=165 then HM$="Vaterland"
if Guess=166 then HM$="Verantwortlicher"
if Guess=167 then HM$="Vorstufe"
if Guess=168 then HM$="Vespa"
if Guess=169 then HM$="Vielflieger"
if Guess=170 then HM$="Vatertagsausflug"
if Guess=171 then HM$="Wal"
if Guess=172 then HM$="Wald"
if Guess=173 then HM$="Waldmeister"
if Guess=174 then HM$="Waldenser"
if Guess=175 then HM$="Weidenzaun"
if Guess=176 then HM$="Weidenkaetzchen"
if Guess=177 then HM$="Wasserfall"
if Guess=178 then HM$="Wiesenchampignon"
if Guess=179 then HM$="Wunderkerze"
if Guess=180 then HM$="Wildwuchs"
if Guess=181 then HM$="Warzenschwein"
if Guess=182 then HM$="Wertung"
if Guess=183 then HM$="Xylophon"
if Guess=184 then HM$="Xanthippe"
if Guess=185 then HM$="Xerographieren"
if Guess=186 then HM$="Zanderfilet"
if Guess=187 then HM$="Zauberstab"
if Guess=188 then HM$="Zentralregister"
if Guess=189 then HM$="Zusammenhalt"
if Guess=190 then HM$="Zerstoerungswut"
if Guess=191 then HM$="Zuckerwatte"
if Guess=192 then HM$="Zeugnis"
if Guess=193 then HM$="Zahnarzthelferin"
Return'
