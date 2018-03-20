
'Autumn scene.bas for SmallBASIC 0.12.0 05-11-2015 MGA/B+ from: 
' Autumn scene.txt for Just Basic 2015-10-03 MGA/B+ translated from:
' tree3.bas SmallBASIC 2015-05-13 translated from
' tree2.txt Naalaa 2015-05-14 MGA/B+ and help from chrisws!
' code inspired by tree found on Naalaa by Peter W

repeat
  'the sky
  for i=0 to 200
    line 0,i,xmax,i,rgb(0,0,205+.25*i)
  next
  'the earth
  for i=200 to ymax
    line 0,i,xmax,i,rgb(0,40+.18*i,0)
  next
  'yard is too neat
  for i=203 to ymax step 5
    j=1
    repeat
      x=rnd*xmax
      leaf2 x,i
      j=j+1
    until (500-i)*.25-j<0
  next
  'the skyline
  for i=1 to 27
    x=rnd*xmax:s=rnd*201:y=200-s:cc=rnd*75
    rect x,y,x+s,y+s,rgb(cc,cc,cc) filled
  next
  'the trees 7 back to front
  DrawTree 1100,350,55,-90,7
  DrawTree 800,270,65,-90, 7
  DrawTree 550,325,70,-90,7
  DrawTree 325,380,65,-90,7
  DrawTree 125,400,75,-90,7
  DrawTree 900,430,80,-90,7
  DrawTree 600,500,85,-90,7
  DrawTree 300,525,75,-90,7
  'more giants
  DrawTree 50,500,105,-90,7
  DrawTree 1150,800,125,-90,7
  DrawTree 400,875,115,-90,7
  delay 2000
until len(inkey)

'====================================================== for tree only
sub DrawTree(x1, y1, Size, theta, depth)
  local SA1,SA2,SF1,SF2,x2,y2
  SA1=7+23*rnd
  SA2=7+23*rnd
  SF1=.60+.30*rnd
  SF2=.60+.30*rnd
  x2 = x1 + cos(rad(theta)) * Size
  y2 = y1 + sin(rad(theta)) * Size
  line x1,y1,x2,y2,rgb(20+rnd*40,35+rnd*40,0)
  if depth<5 then leaf x2,y2
  if depth<=0 then leaf x2,y2 : exit sub
  DrawTree x2,y2,Size*SF1+8-depth,theta-SA1,depth-1
  DrawTree x2,y2,Size*SF2+8-depth,theta+SA2,depth-1
end

sub leaf(x,y)
  local sp,n,xoff,yoff,woff,hoff
  sp=15
  for n=1 to 5
    xoff=x+rnd*sp-rnd*sp
    yoff=y+rnd*sp-rnd*sp
    woff=3+rnd*3
    hoff=3+rnd*3
    rect xoff,yoff,xoff+woff,yoff+hoff,rgb(50+rnd*205,100+rnd*155,0) filled
  next
end

sub leaf2(x,y)
  local sp,n,xoff,yoff,woff,hoff
  sp=32
  for n=1 to 5
    xoff=x+rnd*41-20
    yoff=y+rnd*5-2
    woff=3+rnd*.000012*y*y
    hoff=3+rnd*.000005*y*y
    rect xoff,yoff,xoff+woff,yoff+hoff,rgb(rnd*128,50+rnd*75,rnd*20) filled
  next
end
