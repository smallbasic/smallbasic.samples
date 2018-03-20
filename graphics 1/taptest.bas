
''' taptest.bas
'' 08/07/2002
'' prints out "tap" coordinates
'' as well as the color of that pixel

  pen on
  circle 30,30,30 color 4 filled
at 30,30:? "4";
  circle xmax/2,0,40 color 7 filled
 at xmax/2,0:? "7";
  circle xmax/2,ymax,40 color 9 filled
at xmax/2,ymax-20:? "9" ;
 circle 30,ymax-30,30 color 14 filled
at 30,ymax-30:? "14" ;
 circle xmax,ymax/2,40 color 10 filled
at xmax-20,ymax/2:? "10";
  circle xmax-30,ymax-30,30 color 11 filled
at xmax-30,ymax-30:? "11";
  circle xmax-30,30,30 color 6 filled
at xmax-30,30:? "6";
  circle 0,ymax/2,40 color 0 filled
at  0,ymax/2:? "0";
  ? CHR$(27)+"[8"+chr$(55)+"m";

while(1)
  while pen(0)=0
  wend
  while pen(3)=1
  wend 
  rect xmax/2-20,ymax*3/8,xmax*5/8,ymax*6/8,15 filled
 ? CHR$(27)+"[8"+chr$(55)+"m";
 at xmax/2-20,ymax*3/8: print "X: "; pen(1)
 at xmax/2-20,ymax/2: print "Y: "; pen(2)
 at xmax/2-20,ymax*5/8: print "C: "; point(pen(1),pen(2))
wend  
'
