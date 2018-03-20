'sinecube3c.bas SmallBASIC 2015-08-24 MGA/B+ modified from:
'sinecube 2006 mennonite public domain
color 7,0:cls
FOR l = 8 * 32 TO 0 STEP -8
   FOR y = 4 TO 4 * 32 STEP 4
      FOR x = 8 * 32 TO 0 STEP -8
         if SIN(x * y * l * 3.14) >0 then cube x+y,y+l,y
      NEXT x
   NEXT y
NEXT l
sub cube(x,y,c)
   for i=0 to 2
      line x+i,y+i,x+6+i,y+i,rgb(c*1.9,c*1.9,c+127)
      line x+i,y+i+1,x+i,y+7+i,rgb(0,0,1.9*c)
   next
   rect x+3,y+3,x+10,y+10,rgb(1.9*c,0,0) filled
   rect x+4,y+4,x+9,y+9,0 filled
end 