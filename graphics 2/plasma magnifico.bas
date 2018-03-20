

'Plasma Magnifico - updated 2015-11-26 for Android
'This program creates a plasma surface, which looks oily or silky.
color 15,12
while 1
  r=rnd:g=rnd:b=rnd
  for n=1 to 5
    r1=r:g1=g:b1=b
    repeat:r=rnd:until abs(r-r1)> .3
    repeat:g=rnd:until abs(g-g1)> .3
    repeat:b=rnd:until abs(g-g1)> .3
    for m=0 to 17:m1=17-m
      f1=(m*r)/18:f2=(m*g)/18:f3=(m*b)/18:c << rgbf(f1,f2,f3)
    next
    for m=0 to 17:m1=17-m
      f1=(m+m1*r)/18:f2=(m+m1*g)/18:f3=(m+m1*b)/18:c << rgbf(f1,f2,f3)
    next
    for m=0 to 17:m1=17-m
      f1=(m1+m*r)/18:f2=(m1+m*g)/18:f3=(m1+m*b)/18:c << rgbf(f1,f2,f3)
    next
    for m=0 to 17:m1=17-m
      f1=(m1*r)/18:f2=(m1*g)/18:f3=(m1*b)/18:c << rgbf(f1,f2,f3)
    next
  next

  for n=1 to 6
    p << [rnd*xmax,rnd*ymax]
    f << rnd*.1
  next n
  pen on
  for y=0 to ymax-1 step 2
    for x=0 to xmax-1 step 2
      d=0
      for n=0 to 5
        k=sqr((x-p(n)(0))^2+(y-p(n)(1))^2)
        d =d+(sin(k*f(n))+1)/2
      next n:d=d*60
      rect x,y step 2,ymax-y color c(d) filled
    next x
    at xmax/2,0:? Space(8)+"STOP"+space(8)
    showpage
    if pen(3) then
      if pen(4)> xmax/2 and pen(5)< ymax/2 then pen off:end
    end if
  next y
  showpage
  pen off
  at xmax/2,0:input" Next: press enter  ";temp
  erase c,p,f
  cls
wend

