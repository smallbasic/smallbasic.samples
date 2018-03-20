'MOD D v1.BAS SmallBASIC 2015-04-13 B+
' OK D says try it in MOD 7, so I say why not all?
start=31:enoughAlready=37
for m=3 to enoughAlready
   locate 1,100:? "MOD:";m
   FOR i=0 TO 600
      FOR j=0 TO 400
         c=15*((i XOR 2+j XOR 2) MOD m<>0)
         pset i,j,c
      NEXT j
   NEXT i
   pause 15
   cls
next m