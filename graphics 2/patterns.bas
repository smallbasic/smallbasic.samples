
'pattern.bas for SmallBASIC 0.12.0 2015-11-27 Peter W & MGA/B+

f=4   '<================== 1 to 8? speed, the faster the less fine
s=500
while 1
  for i=0 to xmax/f
    for j=0 to ymax/f
      x=i*s/600
      y=j*s/600
      c= x*x+y*y
      d=c/2
      d=d-int(d)
      if d <0.25 then
        cc=rgbf(d*4,0,0)
      elif d<.5
        cc=rgbf(0,2*d,0)
      elif d<.75
        cc=rgbf(0,0,4/3*d)
      else
        cc=0
      fi    
      rect i*f,j*f step f,f,cc filled
    next
  next
  showpage
  delay 150
  s+=10
  if s>1000 then s=5
wend
