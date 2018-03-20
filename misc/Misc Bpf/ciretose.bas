'ciretose.bas SmallBASIC (not MS) 2015-04-11 B+
Input "Enter text to code:",ctext
if len(ctext)<1 then end
fline="" : l=len(ctext) 
for i = 1 to l
   fline=fline+code(mid(ctext,i,1))
next i
fline=fline+"!"
open "Hi.txt" for output as #1
print#1, fline
close#1
print "goodbye"
end '==========main
func code(kar)
   local c,numb
   c=""
   numb=asc(kar)
   if numb>=200 then c="::":numb=numb-200
   if numb>=100 then c=":":numb=numb-100
   if numb>=50  then c=c+".":numb=numb-50
   while numb>=10
      c=c+"=":numb=numb-10
   wend 
   while numb>0
      c=c+"+":numb=numb-1
   wend
   code=c+"p>"
end