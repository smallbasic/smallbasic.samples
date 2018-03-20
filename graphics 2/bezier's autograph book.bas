
'Bezier's autograph book.bas SmallBasic 0.12.0 2015-11-14 MGA/B+
'Modified from Bezier Bounce.bas

Randomize
color 0,15
while len(inkey)=0
  cls
  topn=int(50*rnd+20)
  for n=1 to topn
    append a,n*xmax/topn-5
    append a,ymax/2
    append d,(rnd*rnd*10)*sgn(rnd-.5)
    append d,(rnd*rnd*10)*sgn(rnd-.5)
  next
  
  f=rgbf(.5*rnd,.5*rnd,.5*rnd):l1=bez(a,3)
  for rep=1 to 50
    cls
    for n=0 to ubound(a)
      k=a(n)+d(n):s=ymax
      if n%2=0:s=xmax:endif
      if (k>s) or (k<0) then
        d(n)=(rnd*3+1)*sgn(-d(n))
      endif
      a(n)=a(n)+d(n)
    next
    l2=l1:l1=bez(a,3)
    drawpoly(l2) color 15
    drawpoly(l1) color f
    showpage
    delay 20
  next
  delay 100
  erase a
wend
func bez(a,b)
  local a1,n,m
  for m=1 to b
    erase a1
    append a1,a(0)
    append a1,a(1)
    for n=0 to ubound(a) -5 step 2
      append a1,(a(n)+3*a(n+2))/4
      append a1,(a(n+1)+3*a(n+3))/4
      append a1,(3*a(n+2)+a(n+4))/4
      append a1,(3*a(n+3)+a(n+5))/4
    next
    append a1,a(ubound(a)-1)
    append a1,a(ubound(a))
    erase a:a=a1
  next:bez=a
end func
