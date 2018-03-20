
'sine cube.bas SmallBASIC 0.12.0  2015-11-26
'modified from Mennonite in QB64 samples
window 0,420,420,0
mode=1
while 1
  color 7,0:cls
  FOR l = 8 * 32 TO 0 STEP -8
    FOR y = 4 TO 4 * 32 STEP 4
      FOR x = 8 * 32 TO 0 STEP -8      
        if SIN(x * y * l * 3.14) >0 then 
          if mode then cube x+y,y+l,y else drawball x+y,y+l
        end if
      NEXT x
      showpage
      delay 2
    NEXT y
  NEXT l
  showpage
  delay 2000
  mode=(mode+1) mod 2
wend
sub cube(x,y,c)
  local i
  for i=0 to 2
    line x+i,y+i,x+6+i,y+i,rgb(c*1.9,c*1.9,c+127)
    line x+i,y+i+1,x+i,y+7+i,rgb(0,0,1.9*c)
  next
  rect x+3,y+3,x+10,y+10,rgb(1.9*c,0,0) filled
  rect x+4,y+4,x+9,y+9,0 filled
end 
sub drawball(x,y)
   xc=x+12:yc=y+12
   for r=9 to 1 step -1
      circle xc,yc,r,1,rgb(255-r*25,255-r*20,0) filled
   next
   pset xc,yc,rgb(255,255,0)
end
