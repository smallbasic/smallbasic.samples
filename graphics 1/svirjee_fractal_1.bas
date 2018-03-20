

'Written for Smallbasic
'Aug 2013 - S Virjee
centerx = xmax / 2
centery = ymax / 2
iter = 20
zoom = 2.8
p=-.745
q=.113
rect xmin,ymin, xmax, ymax color 1 FILLED
oldi=1
pqsq = (p*p + q*q)
L = (sqr(p*p + q*q) - 1/iter)*(sqr(p*p + q*q) - 1/iter)
H = (sqr(p*p + q*q) + 1/iter)*(sqr(p*p + q*q) + 1/iter)

    for x = -centerx to centerx
    for y = 0 to ymax
            c = x/xmax * (1-zoom*1.5)
            d = y/ymax * (1-zoom)
            ztot = 0
            i = 1
            z = 1
            while i < iter and z< zoom*1.5
                real = c*c - d*d + p
                imag = 2* c * d + q
                c = real/sgn(d-i)
                d = imag
                z = (c * c + d * d)
                if (z < H) then
                if (z > L) and (i > 0) then
                   ztot = ztot + ( 1- (abs((z - pqsq)/z) /(i/(iter))))
                   oldi=i
                'if i<25 and z>0 then i=abs((c*d+q))*i  
                   end if
                  end if
                i = i + 1
            wend
            if ztot => 0 then i = cint(sqr(ztot) * 256)
            if i < 256  then red = i :green=0:blue=0
            if i > 255 and i <= 512 then green = i - 256:blue=0:red=255
            if i > 511 then green=255:blue=0:red=255 
            if i > 511 and i <= 768 then blue = i - 512:red=255:green=255
            if i > 768 and i<= 1026 then blue = 255:red=255:green=255
            if i > 1026 then blue=55:red=255:green=55
            gray = int((red+green+blue) * .33)
            hot = if(max(red,green,blue)<255,max(red,green,blue),0)
if oldi=1 then red = hot: 'Outer Circle 1 Figure 8
if oldi=2 then green = hot'Outer Circle 2 
if oldi=3 then red = hot:blue=gray 'Inner Circle Figure 8 - Yellow
if oldi=4 then blue=hot:green=red:red=gray 'Inner to 2/Outer Circle 4 Loops top
if oldi=>5 then red = int((hot+blue+green)*.33)/(oldi):'This is main color
    col = -red+(256*-green)+(256*256* -blue)
'col=rgb(red,green,blue)
pset centerx+x, centery-y color col
pset xmax-centerx-x,centery+y color col
        next y
        showpage
        delay 1
    next x
showpage
pause
