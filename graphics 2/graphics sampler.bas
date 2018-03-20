
'Graphics sampler.bas for SmallBASIC 0.12.0 05-11-2015 MGA/B+
' #1) A Rubens, Peter Paul Landscape.bas for SmallBASIC 2015-08-13 MGA/B+
' inspired by a Master (or two or 3 or more)
' translated to SmallBASIC from Aurels code copied BPF 2015-08-13
'
' #2 reoccuring squares SmallBASIC translation from
' reoccuring squares NaaLaa started 2015-05-14 MGA/B+
'
' #3 crop circles 3.bas 2015-09-19 MGA/B+
'
' #4 sinecube3c.bas SmallBASIC 2015-08-24 MGA/B+ modified from:
' sinecube 2006 mennonite public domain
'
' #5 voronoi.bas for SmallBASIC 2015-10-14 MGA/B+
' modified bluatigro code from JB 2015-09-07 voronoi diagram
'
' #6 "teddy bear scarab" BP.org (dang! this does not look the same as FTLK)
' "Curlicue Fractal" thread reply #53 2015-10-30 MGA/B+
'
' #7 dragon scales.bas for SmallBASIC 2015-09-30 MGA/B+
'
' #8 rotate 7 star.bas SmallBASIC 2015-11-07 MGA/B+
'
th=txth("Q")+4
pen on
repeat
  menu=0:k=0
  color 11,4:cls
  at 50,th:? "Menu:                EXIT (any non digit key)"
  at 10,3*th:? "1 Lakeside view"
  at 10,4*th:? "2 Square recursion"
  at 10,5*th:? "3 Crop Circle #3"
  at 10,6*th:? "4 Sine Cube v3"
  at 10,7*th:? "5 Litte gem Voronoi"
  at 10,8*th:? "6 Teddy Bear Scarab"
  at 10,9*th:? "7 Dragon Scales"
  at 10,10*th:? "8 Rotating 7 point star"
  at 10,12*th:?"Press the number of your choice or click the line..."
  at 10,13*th:? "Each drawing will delay 3-5 secs and return here."
  k=Inkey
  if len(k)=1 then 
    if asc(k)<57 and asc(k)>48 then menu=k else exit
  end if
  if pen(3) then
    mline=pen(5)/th
    delay 30
    if mline>2 and mline<11 then menu=int(mline)-2
    if mline>0 and mline<2 then exit
  endif
  select case menu
  case 1:lakeside:delay 5000
  case 2:recur:delay 3000 
  case 3:crop3:delay 3000
  case 4:sinecube:delay 4000
  case 5:voronoi:delay 3000
  case 6:teddy:delay 3000
  case 7:dragon:delay 2000
  case 8:star:delay 500
  end select 
until 0
pen off
? "bye"
' ======================================= procedures
sub lakeside()
  local width,height,i,skycolor,lakecolor,start,rr,gg,bb,mountains,offset,y,factor,offrand,x,txcolor
  width=xmax:height=ymax
  color 0,15:cls
  for i=0 to 128
    skycolor=rgb(120,120,200-i)
    line 0, i,xmax,i,skycolor
  next
  for i=129 to ymax
    lakecolor=rgb(0,rnd*20+100-.1*i,rnd*20+100-.1*i)
    line 0,i,xmax,i,lakecolor
  next
  start=100
  rr=70:gg=90:bb=70
  for mountains= 1 to 6
    offset=0
    y=start
    repeat
      factor = (RND*9-4)/2
      offrand=offset+rnd*7
      for x=offset to offrand
        y=y +factor
        txcolor=rgb(rr,gg,bb)
        line x,y,x,height,txcolor
      next
      offset=x
    until offset>=width
    rr=rr-20:gg=gg-10:bb=bb-19
    if rr<0 then rr=0
    if gg<0 then gg=0
    if bb<0 then bb=0
    start=start+(20+RND*40)
  NEXT mountains
end
sub recur()
  local sq
  sq=700
  rect 0,0 step sq,sq,0 filled
  sqPlus4 sq/2,sq/2,sq/2,255
end
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
sub crop3()
  local cx,cy,hc,lc,n,stp,br,shft,i,x,y,ga,bn,br,lr,r,dr
  cx=xmax/2:cy=ymax/2
  hc=rgb(0,180,0):lc=rgb(0,120,0)
  n=12:stp=-40
  rect 0,0,xmax,ymax,lc filled
  for br=360 to 100 step stp
    shft=shft+720/(n*n)
    for i=1 to n 
      x=cx+br*cos(rad(i*360/n+shft))
      y=cy+br*sin(rad(i*360/n+shft))
      drawc x,y
    next
  next
  circle cx,cy,100,1,lc filled
  ga=-30.5:bn=100
  br=9.5:lr=.5:r=br:dr=(br-lr)/bn
  for n=1 to bn 
    x=cx+10*sqr(n)*cos(rad(n*ga))
    y=cy+10*sqr(n)*sin(rad(n*ga))
    r-=dr
    circle x,y,r,1,hc filled
  next
end
sub drawc(mx,my)
  local m,cr,dx,dy,dr,i,cc,hc,lc,cx,cy,x,y,r
  hc=rgb(0,180,0):lc=rgb(0,120,0)
  cx=xmax/2:cy=ymax/2      
  m=20:cr=100 
  dx=(mx-cx)/m:dy=(my-cy)/m:dr=cr/m
  for i=m to 0 step -1 
    if i mod 2 then cc=hc else cc=lc
    x=cx+dx*(m-i):y=cy+dy*(m-i):r=dr*i
    circle x,y,r,1,cc filled
    delay 2
  next
end
sub sinecube()
  local l,y,x
  color 7,0:cls
  FOR l = 8 * 32 TO 0 STEP -8
    FOR y = 4 TO 4 * 32 STEP 4
      FOR x = 8 * 32 TO 0 STEP -8
        if SIN(x * y * l * 3.14) >0 then cube x+y,y+l,y
      NEXT x
    NEXT y
  NEXT l
end
sub cube(x,y,c)
  local i
  for i=0 to 2
    line x+i,y+i,x+6+i,y+i,rgb(c*1.9,c*1.9,c+127)
    line x+i,y+i+1,x+i,y+7+i,rgb(0,0,1.9*c)
  next
  rect x+3,y+3,x+10,y+10,rgb(1.9*c,0,0) filled
  rect x+4,y+4,x+9,y+9,0 filled
end 
sub voronoi()
  local sq,s2,points,x,y,kl,i,g,xx,yy,d,a,b,q,kkl
  sq=125:s2=sq/2:points=240
  dim x(points),y(points),kl(points)
  color 15,0:cls
  for i = 0 to points
    x(i)=rnd*sq: y(i)=rnd*sq
    g=127-127*(abs(s2-x(i))/s2)+127-127*(abs(s2-y(i))/s2)
    kl(i)=rgb(255-x(i)/sq*255,g,y(i)/sq*255)
  next
  for xx = 0 to sq
    for yy = 0 to sq
      d = 307201
      for i = 0 to points
        a=x(i)-xx: b=y(i)-yy
        q=a*a+b*b
        if q < d then d = q: kkl = i
      next
      pset xx+20,yy+20,kl(kkl)
    next
  next
end
sub teddy()
  local x1,x2,y0,z,f,c
  color 15,0:cls
  x1=xmax/2:x2=x1:y0=ymax/2
  for z=0 to 200000
    f  =  f + 3.13960000000001
    x1 = x1 + cos(f*f)
    x2 = x2 - cos(f*f)
    y0 = y0 + sin(f*f)
    c=rgb(z mod 255,z mod 255,0)
    pset x1, y0 + 200,c
    pset x2, y0 + 200,c
  next
end
sub dragon()
  local i,colr,r,lastx,angle,x,y
  color 15,0:cls
  dim colr(16)
  for i=0 to 15
    colr(i)=rgb(255-i*16,i*16,0)
  next
  r=ymax/16  'ymax = const maximum y value can show
  for i=15 to 0 step -2
    lastx=0
    for angle=0 to 1800
      x=r*rad(angle)-r*sin(rad(angle))
      y=r-r*cos(rad(angle)) 
      rect lastx,0,x,(i-1)*r+y,colr(i) filled
      lastx=x
    next
    lastx=0
    for angle=180 to 1980
      x=-r*rad(180)+r*rad(angle)-r*sin(rad(angle))
      y=r-r*cos(rad(angle)) 
      rect lastx,0,x,(i-2)*r+y,colr(i-1) filled
      lastx=x
    next
  next
end sub
sub star()
  local x,y,a,b,i,n,m
  dim x(6),y(6)
  while 1
    cls:? "Any key to quit..."
    for a=b to 1.9*pi+b step 2*pi/7:x(i)=ymax/2+(ymax/2-10)*cos(a):y(i)=ymax/2+(ymax/2-10)*sin(a):i+=1:next
    for i=1 to 7:n=(m+3)%7:line x(m),y(m),x(n),y(n):m=n:next
    if len(inkey) then exit sub
    b+=1:i=0:delay 50
  wend
end
