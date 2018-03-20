10 rem =================Setup FiftyFifty v2.txt
11 rem currently does not work in SW BASIC, 2015-02-24 AHA! the INVISIBLES at the end of file after a copy+paste!
12 rem this works fine when remove INVISIBLES at end of file!!!
15 bl$="<span style=background-color:white>"+string$(44," ")
20 print bl$
30 print "<span style=background-color:white>"; "<font color=blue>";"  FiftyFifty v2.txt, B+ revised 2015-02-19  "
40 print bl$
50 print 
80 P=0:B=1000
150 rem ============ Game
160 while P <1000 and P >-1000
170    while B>100
180       input "Bet 1-100 (0=quit) ", B
190       if B<=0 then print "Thanks for playing, goodbye!"
200       if B<=0 then end
210       if B>100 then print "Sorry, bet limit is 100."
220       if B>100 then print 
230    wend
240    W=rnd
250    if W<.4321 then P=P-B
260    if W<.4321 then print "Sorry, lost bet, Pot = "; 
270    if W>=.4321 then P=P+B
280    if W>=.4321 then print "Yeah,  Win!   Pot = ";
290    print P : print : B=1000
320 wend  
340 rem ============== close
350 if P>1000 then print "Win Grand Prize! Goodbye"
360 if P<-1000 then print "Loose too much, Goodbye"
370 end
