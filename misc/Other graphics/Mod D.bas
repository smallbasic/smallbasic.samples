'D recommended Bpf 2015-04-12 B+ SmallBASIC adapted
FOR i=0 TO 799
FOR j=0 TO 479
   c=14*((i XOR 2+j XOR 2) MOD 3<>0)
   pset i,j,c
NEXT j
NEXT i