
'sierpinski decorated.bas 2015-12-06 SmallBASIC 0.12.1 [B+=MGA]
'Thanks to PeterMaria W for code snips

color 15,0
if xmax>ymax then ssq=ymax else ssq=xmax
horizon=485
xplus =ssq
yplus =horizon
nstars=100
dim xstar(100),ystar(100)
for i=1 to 100
  xstar(i)=rnd*ssq:ystar(i)=rnd*horizon
next
while 1
  cls
  for i=0 to horizon
    line 0,i,ssq,i,rgb(i/horizon*128,i/horizon*32,64)
  next
  land=ssq-horizon
  for i=horizon to ssq
    cc=128+(i-horizon)/land*127
    line 0,i,ssq,i,rgb(cc,cc,cc)
  next
  for i=1 to 100
    circle xstar(i),ystar(i),2,1,11 filled
  next
  pinetree 200,100
 star xplus,yplus
 xdist=420-xplus
 xplus=xplus+.1*xdist
 ydist=80-yplus
 yplus=yplus+.1*ydist
 showpage
 delay 50
wend

sub star(x,y)
  circle x,y,3,1,11 filled 
  line x-7,y,x-3,y,11
  line x+3,y,x+7,y,11
  line x,y-7,x,y-3,11
  line x,y+3,x,y+7,11
  if x>419 and x<421 and y>79 and y<81 then 
    circle x,y,12
    ? "  Seasons Greetings "
    sier 210,125,420,340
    pause
  end if
end

sub sier(tlx,tly,width,height)
  ' Sierpinski Christmas.bas modified from Petermaria's
  ax = tlx
  ay = tly+height
  bx = tlx+width
  by = tly+height
  cx = tlx+width/2
  cy = tly
  px = tlx
  py = tly+height
  for n=0 to 4000
    circle  px, py,1,1,int(rnd*16) filled
    'pset px,py,int(rnd*16)
    select Case int(rnd*3)
    case 0
      px = (px + ax) / 2.0
      py = (py + ay) / 2.0
    case 1
      px = (px + bx) / 2.0
      py = (py + by) / 2.0
    case 2
      px = (px + cx) / 2.0
      py = (py + cy) / 2.0
    end select         
  next
  showpage 
end

sub pinetree(x,y)
  'tannen baum by PeterMaria W  orig 440x460
  bpx=220:bpy=410
  tpx = bpx
  For aa=-4 to 4
    bpxx=bpx+aa
    bpyy=bpy-390
    Line x+bpxx, y+bpy, x+bpx, y+bpyy, rgb(30,30,0)
  Next
  ra = 160
  tpy = bpy-40
  For ht=1 to 40
    For xs=-100 to 100 step 40
      xsh = xs/100
      rs = rnd*4/10
      tpxx = tpx+(xsh*ra)
      tpyy = tpy-rs*ra
      Line x+tpx, y+tpy, x+tpxx, y+tpyy, rgb(50,40,20)
      For aa=1 to 30
        fra=rnd*10/10*ra
        x1=tpx+(xsh*fra)
        y1=tpy-rs*fra
        x2=tpx+xsh*(fra+ra/5)
        y2=tpy-rs*fra+(-rs+(Rnd*8)/10-0.4)*(ra/5)
        Line x+x1,y+y1,x+x2,y+y2, rgb(rnd*120,rnd*70+70,rnd*80)
      Next
    Next
    ra -=4
    tpy -=9
  Next
  showpage
  delay 10
end
