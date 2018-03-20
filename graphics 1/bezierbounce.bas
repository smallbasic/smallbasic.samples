

'Bezier Bounce.bas edit for On-line sample 05-11-2015

color 0,0
cls

for n=1 to 16
  append a,rnd*(xmax-20)+10
  append a,rnd*(ymax-20)+10
  append d,(rnd*3+1)*sgn(rnd-.5)
  append d,(rnd*3+1)*sgn(rnd-.5)
next

f=rgbf(rnd,rdn,.5*rnd+.5):l1=bez(a,3)
repeat
  cls
  for n=0 to ubound(a)
    k=a(n)+d(n):s=ymax
    if n%2=0:s=xmax:endif
    if (k>s) or (k<0)
      d(n)=(rnd*3+1)*sgn(-d(n))
    endif
    a(n)=a(n)+d(n)
  next
  l2=l1:l1=bez(a,3)
  drawpoly(l2) color 0
  drawpoly(l1) color f
  showpage
  delay 20
until 0

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
