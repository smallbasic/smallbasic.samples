'rotozoomer Galileo vB+.bas (SmallBasic) bpf 2015-05-16
' some big screen adjustements B+
'a snapshot frame
rect 0,0,804,704,15 filled
for i=1 to 24
  'orig .08, now increment in radian fractions
  ANG=ANG+2*3.14159265/32
  CS=COS(ANG)*ABS(SIN(ANG))*128
  SS=SIN(ANG)*ABS(SIN(ANG))*128
  FOR Y=-350 TO 350
    FOR X=-400 TO 400
    	tono = abs(((X*CS-Y*SS) band (Y*CS+X*SS))/256)
        if tono>255 then tono=255
    	pset X+402,Y+352,rgb(tono,tono,tono)
    NEXT X
  NEXT Y
  'showpage
next
'take a picture