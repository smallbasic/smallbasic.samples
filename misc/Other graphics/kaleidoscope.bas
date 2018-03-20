'kaleidoscope.bas 2015-08-30 adapted for SmallBASIC by MGA/B+ from
REM Adapted from Phix to Yabasic 2.769 by Galileo, 2015/08 640x520
randomize
const sw=xmax-100
const sh=ymax-10
color 15,0:cls
ncolors=16  
kcol = int(rnd*ncolors)

'alternate borders based on screen dimensions
 lt = 0      :  tp = 0      :  bt = .65*sh :  rt = .65*sw
lt1 = .35*sw : tp1 = 0      : bt1 = .65*sh : rt1 = sw
lt2 = 0      : tp2 = .35*sh : bt2 = sh     : rt2 = .65*sw
lt3 = .35*sw : tp3 = .35*sh : bt3 = sh     : rt3 = sw


'alternate init based on screen dimensions
   x = .37*sw :    x1 = .32*sw :    y = .15*sh :    y1 = .42*sh
  xx = .61*sw :   xx1 = .66*sw :   yy = .15*sh :   yy1 = .42*sh
 xxx = .37*sw :  xxx1 = .32*sw :  yyy = .77*sh :  yyy1 = .5*sh
xxxx = .61*sw : xxxx1 = .66*sw : yyyy = .77*sh : yyyy1 = .5*sh


 a = 3 :  b = a :  c = 6 :  d = a
a1 = a : b1 = b : c1 = c : d1 = d
a2 = a : b2 = b : c2 = c : d2 = d
a3 = a : b3 = b : c3 = c : d3 = d

repeat
   k=inkey
   if len(k)=1 and asc(k)=27 then exit
   draw_it()
until esc

sub value()
       x = x - a     :    y = y - b     :    x1 = x1 - c     :    y1 = y1 - d
      xx = xx + a1   :   yy = yy - b1   :   xx1 = xx1 + c1   :   yy1 = yy1 - d1
     xxx = xxx - a2  :  yyy = yyy + b2  :  xxx1 = xxx1 - c2  :  yyy1 = yyy1 + d2
    xxxx = xxxx + a3 : yyyy = yyyy + b3 : xxxx1 = xxxx1 + c3 : yyyy1 = yyyy1 + d3
end sub

sub xyopp()
    if  x < lt or  x > rt then a = -a
    if  y < tp or  y > bt then b = -b
    if x1 < lt or x1 > rt then c = -c
    if y1 < tp or y1 > bt then d = -d
end sub

sub xyopp2()
    if  xx < lt1 or  xx > rt1 then a1 = -a1
    if  yy < tp1 or  yy > bt1 then b1 = -b1
    if xx1 < lt1 or xx1 > rt1 then c1 = -c1
    if yy1 < tp1 or yy1 > bt1 then d1 = -d1
end sub

sub xyopp3()
    if  xxx < lt2 or  xxx > rt2 then a2 = -a2
    if  yyy < tp2 or  yyy > bt2 then b2 = -b2
    if xxx1 < lt2 or xxx1 > rt2 then c2 = -c2
    if yyy1 < tp2 or yyy1 > bt2 then d2 = -d2
end sub

sub xyopp4()
    if  xxxx < lt3 or  xxxx > rt3 then a3 = -a3
    if  yyyy < tp3 or  yyyy > bt3 then b3 = -b3
    if xxxx1 < lt3 or xxxx1 > rt3 then c3 = -c3
    if yyyy1 < tp3 or yyyy1 > bt3 then d3 = -d3
end sub

sub draw_it()
   if segment >= 650 then cls : segment = 1
   segment = segment + 1
   if segment mod 30 = 0 then kcol = int(rnd*ncolors)
   line    x + a ,    y +  b,    x1 + c ,    y1 + d ,kcol
   line  xxx + a2,  yyy + b2,  xxx1 + c2,  yyy1 + d2,kcol
   line   xx + a1,   yy + b1,   xx1 + c1,   yy1 + d1,kcol
   line xxxx + a3, yyyy + b3, xxxx1 + c3, yyyy1 + d3,kcol
   value() :xyopp() :xyopp2() :xyopp3() :xyopp4()
end sub

