1 red$ = "<font color=red>"
2 green$ = "<font color=green>"
3 black$="<font color=black>"
10 sor$="Sorry, you loose bet. Pot = "
11 win$=" Yeah! you  WIN  bet. Pot = "
12 blk$= "                                                            "
13 print blk$
14 print "                  Fifty50 (or so) by B+                     "
15 print blk$
16 print "        readapted for Simple Web Basic: 2015-02-18          "
17 print blk$
18 goto 35
19 print blk$
20 print "              Thanks for playing, goodbye!                  "
21 return
22 print blk$
23 print "                Sorry, bet limit is 100                     "
24 return
25 print blk$
26 print "                Win Grand Prize! Goodbye                    "
27 return
28 print blk$
29 print "                 Loose too much, Goodbye                    "
30 return                
35 pot=0
40 rem startRound
50 input "  Bet 1 to 100 (0=quit) ", bet
60 if bet <= 0 then gosub 19 :end
70 if bet > 100 then gosub 22 :goto 40
80 winloose=rnd
81 print winloose
90 if winLoose<.4321 then pot=pot-bet:pl$=sor$ else pot=pot+bet:pl$=win$
100 pl$=pl$+str$(pot) :lp=len(pl$)
110 pl$=string$(int((60-lp)*.5)," ")+pl$ :lp=len(pl$)
120 pl$=pl$+string$((60-lp)," ")
121 print blk$:print pl$:print blk$
130 if pot>1000 then gosub 24:end
140 if pot<-1000 then gosub 27:end
150 goto 40