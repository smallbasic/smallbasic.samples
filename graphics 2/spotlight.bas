
'spotlite v2.bas 2015-12-12 SmallBASIC 0.12.2 [B+=MGA]                
pen on:maxd=(xmax^2+ymax^2)^.5
while 1:cls
for y=0 to ymax step 20
  for x= 0 to xmax step 20
    m=255*(1-((((x-pen(4))^2+(y-pen(5))^2)^.5))/maxd)^4
    rect x,y step 20,20,rgb(m,m,255-m) filled
  next
next
showpage:delay 20
wend
