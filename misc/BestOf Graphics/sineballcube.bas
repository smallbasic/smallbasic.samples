'sineballcube.bas SmallBASIC(! MS) 2015-08-23 MGA/B+ translated and modified from:
'sinecube 2006 mennonite public domain
FOR l = 8 * 32 TO 1 STEP -8
   FOR y = 4 TO 4 * 32 STEP 4
      FOR x = 8 * 32 TO 1 STEP -8
         if SIN(x * y * l * 3.14) >0 then drawball x+y,y+l
      NEXT x
   NEXT y
NEXT l
sub drawball(x,y)
   xc=x+12:yc=y+12
   for r=9 to 1 step -1
      circle xc,yc,r,1,rgb(255-r*25,255-r*20,0) filled
   next
   pset xc,yc,rgb(255,255,0)
end