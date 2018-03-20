'insert delete test.bas SmallBASIC 2015-04-27 B+
dim test()
for i=50 to 1 step -1
   insert test,0,i
next
showtest
delete test,29,10
showtest
for i=10 to 1 step -1
   insert test,29,chr(64+i)
next
showtest
end
sub wait4key()
   local k
   ? " *** Press any key to continue ***"
   k=0
   while k=0
      k=inkey
   wend
end
sub showtest()
   ? "here is test array: 
   for i=0 to ubound(test)
      print test(i);" ";
   next
   ?
   wait4key
end