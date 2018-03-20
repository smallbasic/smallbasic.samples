
'ISOdate test.bas
? date 'completely backwards
today=""
? ISOdate(today)
? ISOdate("30/9/15")
func ISOdate(DslashMslashY)
   local fdate,d,my,m,y
   if DslashMslashY="" then fdate=date else fdate=DslashMslashY
   d=leftof(fdate,"/"):if len(d)=1 then d="0"+d
   my=rightof(fdate,"/")
   m=leftof(my,"/"):if len(m)=1 then m="0"+m
   y=rightof(my,"/"):if len(y)=2 then y="20"+y
   ISOdate=y+"-"+m+"-"+d
end   
