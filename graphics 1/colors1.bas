

REM Jim Swenson 2014-02-23, on Windows 8,
REM Small Basic, FLTK Version 0.10.7
REM This program: draws a rectangle around all, then for each of several colors
REM   it draws coalligned square, 2 lines making an ""X"", and circle
REM   then it moves to another place to draw the next color.
REM In this version of Small Basic (FLTK Version 0.10.7 on Windows 8),
REM   the CIRCLE seems to exchange red and blue components of its RGB color,
REM     compared with RECT and LINE.

CONST r=50  : ' radius of circle
CONST d=9   : ' distance moved before drawing next color
CONST k=0   : ' for k=0, circle is inset in square

CONST m=255 : ' max brightness on 0-255 scale, 100% brightness
CONST h=127 : ' half brightness, half darkness, 50% brightness
CONST q=191 : ' one-quarter darkness, 75% brightness

' Make your colors:
CONST Lgray  = RGB(q,q,q)  : ' for the background, distinguishable from white & gray
 
CONST black  = RGB(0,0,0)
CONST white  = RGB(m,m,m)
CONST gray   = RGB(h,h,h)

CONST red    = RGB(m,0,0)
CONST green  = RGB(0,m,0)
CONST blue   = RGB(0,0,m)

CONST cyan   = RGB(0,m,m)
CONST magenta= RGB(m,0,m)
CONST yellow = RGB(m,m,0)

'set the scene:
COLOR red
RECT 0.5*r,0.5*r , 6.5*r,6.5*r
COLOR Lgray
PAINT r,r  : ' filling the retangle
  REM window comes back in some seconds; your program has not crashed. 
  REM Filling that rectangle is 4x faster than filling the whole window.

'use the colors:
x=2*r : y=2*r
 COLOR black   : gosub square_X_circle
 COLOR gray    : gosub square_X_circle
 COLOR white   : gosub square_X_circle
x=5*r : y=2*r
 COLOR red     : gosub square_X_circle
 COLOR green   : gosub square_X_circle
 COLOR blue    : gosub square_X_circle
x=5*r : y=5*r
 COLOR cyan    : gosub square_X_circle
 COLOR magenta : gosub square_X_circle
 COLOR yellow  : gosub square_X_circle
x=2*r : y=5*r
 COLOR black   : gosub square_X_circle
 COLOR black   : gosub square_X_circle

STOP

Label square_X_circle: 
 a = (r-k)
 RECT x-a,y-a , x+a,y+a
 LINE x-a,y-a , x+a,y+a
 LINE x-a,y+a , x+a,y-a
 CIRCLE x,y,r  
 gosub move
Return

Label move:
  x = x+d  :  y = y+(d/2)
Return

REM  unused remanants:

dim c(16)
c(0)=black : c(1)=white   : c(2)=gray
c(3)=red   : c(4)=green   : c(5)=blue
c(6)=cyan  : c(7)=magenta : c(8)=yellow
c(9)=black : REM Remaining array elements are black because DIM makes them all 0.
FOR i = 0 TO 9
 COLOR c(i) : gosub square_X_circle
NEXT i

