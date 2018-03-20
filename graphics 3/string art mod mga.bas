
' string art mod mga.bas  SmallBASIC 0.12.2 [B+=MGA] 2016-03-08
' orig ? S Shaw, 2013 by way of Johnno on SB forum

RANDOMIZE timer
dim ab(29,1)
for i=0 to 29
  read ab(i,0),ab(i,1)
next
' 30 nice a,b combos
data 11,7 , 6,3 , 12,9 , 4,2 , 2,9 , 3,4 , 12,3, 9,3 , 7,6 , 5,5
data 13,1 , 7,3 , 9,11 , 10,3, 7,1 , 1,9 , 9,2 , 3,8 , 8,10, 2,4
data 8,5  , 10,7, 27,9 , 2,3 , 3,4 , 4,10, 1,3 , 9,5 , 6,9 ,22,1

th=txth("Q")
cy=ymax/2
cx=xmax/2 
scale=min(cy,cx)-2*th:a=9:b=6:dta=0
while 1
  for i= 0 to 360
    t=i*pi/180.0
    x=cos(t) : y=sin(t)
    x2=cos(a*t) : y2=sin(b*t)
    line x*scale+cx,y*scale+cy,x2*scale+cx,y2*scale+cy
  next
  s="a="+str(a)+" b="+str(b)
  s=s+" x=exit n=nice r=random g=globe"
  at (xmax-txtw(s))\2,0:?s
  repeat 
    ink=inkey
    ink=upper(ink)
    delay 20
  until ink<>"" and instr("XQNRG",ink)>0 'aha! instr("anything","")=1
  cls
  dta++
  if dta>=30 then dta=0
  IF ink="N" THEN
    a=ab(dta,0) : b=ab(dta,1)
  elif ink="R"
    a=rnd*30\1+1 : b=rnd*30\1+1
  elif ink="X" or ink="Q"
    end
  elif ink="G"
    a=dta:b=dta
  end if
  ink=""
wend
