'joes problem generalized.bas post Bpf 2015-06-04 B+
while 1
   cls
   input "(<2 or non integer quits) How many in circle ";circ
   if circ<2 then end
   if int(circ)<>circ then end
   input "(<2 or non integer quits) Remove every nth part, n = ";out
   if out<2 then end
   if int(out)<>out then end

   dim circus(0 to (circ-1))
   count=0:nem=0:linecount=0
   while ccount
      if circus(count mod circ)=0 then nem+=1
      if nem=out then 
         circus(count mod circ)=count
         print (count mod circ)+1;", ";
         linecount+=1
         if linecount=15 then print:linecount=0
         lastnum=(count mod circ)+1
         nem=0
      end if   
      count+=1   
   wend
   print
   print "last in circle = #";lastnum
   print
   input "press enter...",d
wend
end ' never getting to here
func ccount
   local i:ccount=1
   for i=0 to (circ-1)
      if circus(i)=0 then exit sub
   next
   ccount=0
end