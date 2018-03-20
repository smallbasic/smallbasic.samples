'typewriter with sound effects.bas SmallBASIC 2015-04-26 B+
a="":fl="":mult=20:ldelay=150:start=100
open "mytext.txt" for input as #1
while not eof(1)
lineinput #1,a
fl+=a+Chr(13)
wend
close #1
lf=len(fl)
for i=1 to lf
   c=mid(fl,i,1): a=asc(c)
   print c;
   if a = 13 then 
      print : delay 240
   elif  a>47 and a<58
      sound start+mult+(a-48)*mult,ldelay
   elif a>65 and a<90 
      sound start+39*mult+(a-65)*mult,ldelay
   elif a>96 and a<123
      sound start+12*mult+(a-97)*mult,ldelay
   fi   
   delay ldelay
next i
?:? "The end, goodbye!"
