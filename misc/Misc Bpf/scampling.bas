'scampling.bas SmallBASIC 2015-09-02 MGA/B+
dim msg(1 to 5)
msg(1)="This is really cool. I have a program:"
msg(2)="{scampling.BAS (Small-BASIC) @2015-09-02 MGA/B+}"
msg(3)="which can scramble a text so that it still can be read by a human brain."
msg(4)=""
msg(5)="THIS MESSAGE SHOWS YOU, THAT THE CAPABILITIES OF YOUR BRAIN ARE REALLY GREAT!"
punc=" <,>.?/:;'{[}]|\!@#$%^&*()_-+="+chr(34)
for m in msg
   lastp=0:build=""
   for i=1 to len(m)
      if instr(punc,mid(m,i,1)) then
         word=mid(m,lastp+1,i-lastp-1)
         build=build+scample(word)+mid(m,i,1)
         lastp=i   
      endif          
   next
   if lastp<len(m) then
      word=mid(m,lastp+1)
      build=build+scample(word)
   endif
   ? build
next
func scample(word)
   local i,flaglower,lp,w,words
   if word="scramble" then scample=chr(34)+"sapmcle"+chr(34):exit
   if word="a" then scample="aa":exit
   if len(word) then
      flaglower=0
      for i=1 to len(word)
         if instr("abcdefghijklmnopqrstuvwxyz",mid(word,i,1)) then flaglower=1:exit for
      next
      if flaglower then     
         if len(word)>3 then
            lp=int(rnd*(len(word)-3))+2
            word=mid(word,1,lp-1)+mid(word,lp+1,1)+mid(word,lp,1)+mid(word,lp+2)
         end if
      else
         split "A4,B8,E3,G6,I1,O0,S5",",",words
         for w in words
            word=translate(word,left(w,1),right(w,1))
         next
      end if 
   end if       
   scample=word 
end 