'reoccuring squares SmallBASIC translation from
rem reoccuring squares NaaLaa started 2015-05-14 MGA/B+
sub sqPlus4(x,y,side,colorNumber)
   local cc,cx,cy,ns,nc
   cc=rgb(colorNumber,0,colorNumber)
   cx=x-side/2:cy=y-side/2
   rect cx,cy step side,side,cc filled
   if side<4 then exit sub
   ns=side/2:nc=colorNumber-35
   sqPlus4 cx,cy,ns,nc
   sqPlus4 cx+side,cy,ns,nc
   sqPlus4 cx,cy+side,ns,nc
   sqPlus4 cx+side,cy+side,ns,nc
end
sq=700
rect 0,0 step sq,sq,0 filled
sqPlus4 sq/2,sq/2,sq/2,255

