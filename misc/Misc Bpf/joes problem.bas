'joes problem.bas posted Bpf 2015-06-04 my answer agrees with Wolfgram link!

input "How many in circle ";circ
input "Remove every nth part, n = ";out
dim circus(0 to (circ-1))
count=0:nem=0
while ccount
   if circus(count mod circ)=0 then nem+=1
   if nem=out then 
      circus(count mod circ)=count
      print (count mod circ)+1;", ";
      lastnam=(count mod circ)+1
      nem=0
   end if   
   count+=1   
wend
print
print "last in circle = #";lastnam
end

func ccount
   local i:ccount=1
   for i=0 to (circ-1)
      if circus(i)=0 then exit sub
   next
   ccount=0
end