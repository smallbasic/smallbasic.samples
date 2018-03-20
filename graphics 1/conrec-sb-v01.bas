
' CONREC - A Contouring Routine
'
' by Paul Bourke, Byte, June 1987
' Homepage http://ozviz.wasp.uwa.edu.au/~pbourke/papers/conrec/
' (See webpage for details of the method.)
' Adapted for SmallBasic-v0.9.5 by Ted Clayton
'
' CONREC avoids the advanced math & heavy computation
' of more-formal contour-generation methods, by using
' a series of geometric tests within a local 'box'
' around & above each point in a data-grid.
' Each contour-segment is generated independently
' of other segments while scanning the grid
' raster-fashion.  In its present form, this
' program does not 'follow' a contour, and does not
' make polylines, polygons or shapes.
'
'  colors
'  ----------
const mapGrn = rgb(200, 235, 171)   ' map-Green background
const conPri = rgb(120, 115,  70)   ' Primary contour-line
const conInt = rgb(165, 165, 120)   ' Intermediate contour
const medGry = rgb(160, 160, 160)   ' medium-Gray
const drkGry = rgb( 90,  90,  90)   ' dark-Gray
const bdrRed = rgb(175, 150,  50)   ' border-Red
'
'  screen layout
'  ----------
' rect 0,0, xmax-1,ymax-1, medGry filled          ' page bg
' view 40,40, 659,499                             ' set viewport
rect 0,0, xmax-1,ymax-1 color mapGrn filled  	' viewport bg
' rect 40,40, 659,499 color drkGry                ' viewport border
'
'  data structures
'  ----------
dim h(4)     ' relative heights of the box above contour
dim ish(4)   ' sign of h()
dim xh(4)    ' x coordinates of box
dim yh(4)    ' y coordinates of box
dim im(3)    ' mapping from vertex numbers to x offsets
dim jm(3)    ' mapping from vertex numbers to y offsets
'
'  mapping pre-sets
'  ----------
im(0)=0 : im(1)=1 : im(2)=1 : im(3)=0
jm(0)=0 : jm(1)=0 : jm(2)=1 : jm(3)=1
'
'  case switch table
'  ----------
dim castab(2,2,2)
data 0,0,8,0,2,5,7,6,9,0,3,4,1,3,1,4,3,0,9,6,7,5,2,0,8,0,0
for k=0 to 2
  for j=0 to 2
    for i=0 to 2
      read castab(k,j,i)
    next i
  next j
next k
'
'
'         Generate test-data
'  =================================
'  Can be replaced by a different function-generator,
'  or by any "iub by jub" array of data.
'
const ilength=639   ' rendered image size
const jlength=479
const imin=17       ' right   *View-hack
const jmin=497      ' bottom  *View-hack
const iub=90        ' grid-dimensions
const jub=90
const nc=10         ' number of contour-levels
'
dim d(iub,jub)      ' data array
dim x(iub)
dim y(jub)
dim z(nc-1)         ' contour array
'
'  Define Function
'  ===============
for i=0 to iub
  ix=2*pi*(2*i-iub)/jub
  for j=0 to jub
    jy=2*pi*(2*j-jub)/jub
    r=sqr(ix^2+jy^2)
    d(i,j)=sin(r)+.5/sqr((ix+3.05)^2+iy^2)
  next j
  x(i)=i*ilength/iub+imin
next i
'
for j=0 to jub
  y(j)=jmin-j*jlength/jub
next j
'
for i=0 to nc-1
  z(i)=(i-5)/5
next i
'  -----  end data-generation
'
'
'  =======================================
'         begin CONREC Subroutine
'
'  Check the input parameters for validity
'  =======================================
'
const prmerr=false
if iub<=0 then prmerr=true
if jub<=0 then prmerr=true
if nc<=0 then prmerr=true
for k=1 to nc-1
  if (z(k)<=z(k-1)) then prmerr=true
next k
if (prmerr) then msg$="Error in input parameters" : return
'
'  Scan the array, top to bottom, left to right
'  ===============
for j = jub - 1 to 0 step -1
  for i=0 to iub-1
    '  Find the lowest vertex
    '  ----------
    if (d(i,j)<d(i,j+1)) then dmin=d(i,j) else dmin=d(i,j+1)
    if (d(i+1,j)<dmin) then dmin=d(i+1,j)
    if (d(i+1,j+1)<dmin) then dmin=d(i+1,j+1)
    '  Find the highest vertex
    '  ----------
    if (d(i,j)>d(i,j+1)) then dmax=d(i,j) else dmax=d(i,j+1)
    if (d(i+1,j)>dmax) then dmax=d(i+1,j)
    if (d(i+1,j+1)>dmax) then dmax=d(i+1,j+1)
    '
    '  Draw each contour within this box
    '  ===============
    if (dmax<z(0) or dmin>z(nc-1)) then goto noneinbox
    for k=0 to nc-1
      if ((z(k)<dmin) or (z(k)>dmax)) then goto noneintri
      for m=4 to 0 step -1
        if m>0 then
          h(m)=d(i+im(m-1),j+jm(m-1))-z(k)
          xh(m)=x(i+im(m-1))
          yh(m)=y(j+jm(m-1))
        endif
        if m=0 then
          h(0)=(h(1)+h(2)+h(3)+h(4))/4
          xh(0)=(x(i)+x(i+1))/2
          yh(0)=(y(j)+y(j+1))/2
        endif
        if h(m)>0 then ish(m)=2
        if h(m)<0 then ish(m)=0
        if h(m)=0 then ish(m)=1
      next m
      '
      '  Scan each triangle in the box
      '  ===============
      for m=1 to 4
        m1=m : m2=0 : m3=m+1
        if (m3=5) then m3=1
        caseCon=int(castab(ish(m1),ish(m2),ish(m3)))
        if (caseCon=0) then goto Case0
        on caseCon goto Case1,Case2,Case3,Case4,Case5,Case6,Case7,Case8,Case9
        '
        label Case1  '  Line between vertices m1 and m2
         x1=xh(m1)
		 y1=yh(m1)
		 x2=xh(m2)
		 y2=yh(m2) : goto DrawIt
		'
        label Case2  '  Line between vertices m2 and m3
         x1=xh(m2)
		 y1=yh(m2)
		 x2=xh(m3)
		 y2=yh(m3) : goto DrawIt
		'
        label Case3  '  Line between vertices m3 and m1
         x1=xh(m3)
		 y1=yh(m3)
		 x2=xh(m1)
		 y2=yh(m1) : goto DrawIt
		'
        label Case4  ' Line between vertex m1 and side m2-m3
         x1=xh(m1)
		 y1=yh(m1)
         x2=(h(m3)*xh(m2)-h(m2)*xh(m3))/(h(m3)-h(m2))
         y2=(h(m3)*yh(m2)-h(m2)*yh(m3))/(h(m3)-h(m2)) : goto DrawIt
        '
        label Case5  '  Line between vertex m2 and side m3-m1
         x1=xh(m2)
		 y1=yh(m2)
         x2=(h(m1)*xh(m3)-h(m3)*xh(m1))/(h(m1)-h(m3))
         y2=(h(m1)*yh(m3)-h(m3)*yh(m1))/(h(m1)-h(m3)) : goto DrawIt
        '
        label Case6  '  Line between vertex m3 and side m1-m2
         x1=xh(m3)
		 y1=yh(m3)
         x2=(h(m2)*xh(m1)-h(m1)*xh(m2))/(h(m2)-h(m1))
         y2=(h(m2)*yh(m1)-h(m1)*yh(m2))/(h(m2)-h(m1)) : goto DrawIt
        '
        label Case7  '  Line between sides m1-m2 and m2-m3
         x1=(h(m2)*xh(m1)-h(m1)*xh(m2))/(h(m2)-h(m1))
         y1=(h(m2)*yh(m1)-h(m1)*yh(m2))/(h(m2)-h(m1))
         x2=(h(m3)*xh(m2)-h(m2)*xh(m3))/(h(m3)-h(m2))
         y2=(h(m3)*yh(m2)-h(m2)*yh(m3))/(h(m3)-h(m2)) : goto DrawIt
        '
        label Case8  '  Line between sides m2-m3 and m3-m1
         x1=(h(m3)*xh(m2)-h(m2)*xh(m3))/(h(m3)-h(m2))
         y1=(h(m3)*yh(m2)-h(m2)*yh(m3))/(h(m3)-h(m2))
         x2=(h(m1)*xh(m3)-h(m3)*xh(m1))/(h(m1)-h(m3))
         y2=(h(m1)*yh(m3)-h(m3)*yh(m1))/(h(m1)-h(m3)) : goto DrawIt
        '
        label Case9  '  Line between sides m3-m1 and m1-m2
         x1=(h(m1)*xh(m3)-h(m3)*xh(m1))/(h(m1)-h(m3))
         y1=(h(m1)*yh(m3)-h(m3)*yh(m1))/(h(m1)-h(m3))
         x2=(h(m2)*xh(m1)-h(m1)*xh(m2))/(h(m2)-h(m1))
         y2=(h(m2)*yh(m1)-h(m1)*yh(m2))/(h(m2)-h(m1)) : goto DrawIt
		'
        label DrawIt  '  renders contours in small segments
		  '
		  '  Simulate Primary & Intermediate contours
		  '  ----------
		  if k=3 or k=6 or k=9 then  ' k is contour-level counter
            line x1,y1, x2,y2, color conPri
           else
            line x1,y1, x2,y2, color conInt
		  endif
		  '
        label Case0
      next m
      label noneintri
    next k
    label noneinbox
  next i
next j
  '        end CONREC Subroutine
  '  ================================
locate 40, 1    ' displace SB * Done * msg
end
