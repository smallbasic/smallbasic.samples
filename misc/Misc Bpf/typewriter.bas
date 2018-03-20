'typewriter.bas SmallBASIC 2015-04-21 B+
a="":fl=""
open "mytext.txt" for input as #1
while not eof(1)
lineinput #1,a
fl+=a+Chr(13)
wend
close #1
lf=len(fl)
for i=1 to lf
   print mid(fl,i,1);
   If asc(mid(fl,i,1))=13 then print
   delay 220
   'delay 10
next i
?:? "The end, goodbye!"
