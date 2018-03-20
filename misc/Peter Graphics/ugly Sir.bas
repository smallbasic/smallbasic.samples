'Ugly Sirpinski 2015-04-12 from Bpf PeterMaria
'Ugly Sir.bas adapted to SmallBASIC by B+
d=800
sc=3
dim p(d),c(d)

while 1
   cls
   for i=0 to d
      p(i)=1
      c(i)=0
   next i
   for n=2 to d
      for r=2 to n
         var = p(r)+p(r-1)
         c(r)= var mod sc
         if c(r)=0 then pset n,r
      next r
      for i=1 to d
         p(i) = c(i)
      next i
   next n
   locate 35,10 : print "Modulus: ";sc
   locate 36,10 
   input "See next modulus? Enter any other=quits ";ink
   if ink<>"" then end
   sc +=1
wend
end