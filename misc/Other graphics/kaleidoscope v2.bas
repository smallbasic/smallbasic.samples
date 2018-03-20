'kaleidoscope v2.bas 2015-08-31 adapted for SmallBASIC by MGA/B+ from
REM Adapted from Phix to Yabasic 2.769 by Galileo, 2015/08 640x520
randomize
const sw=1200 'your screen width here
const sh=680 'your screen height here
color 15,0:cls
ncolors=16

while !esc  

   'alternate borders based on screen dimensions
    lt = 0      :  tp = 0      :  bt = .75*sh :  rt = .75*sw
   lt1 = .25*sw : tp1 = 0      : bt1 = .75*sh : rt1 = sw
   lt2 = 0      : tp2 = .25*sh : bt2 = sh     : rt2 = .75*sw
   lt3 = .25*sw : tp3 = .25*sh : bt3 = sh     : rt3 = sw

   'alternate init based on screen dimensions
   x = .37*sw :    x1 = .31*sw :    y = .25*sh :    y1 = .45*sh
   xx = .63*sw :   xx1 = .69*sw :   yy = .25*sh :   yy1 = .45*sh
   xxx = .37*sw :  xxx1 = .31*sw :  yyy = .75*sh :  yyy1 = .55*sh
   xxxx = .63*sw : xxxx1 = .69*sw : yyyy = .75*sh : yyyy1 = .55*sh

   'a=0:b=0:c=0:d=1 'yeah that works too but not very interesting
   a =rnd*5  :  b = rnd*5 :  c = rnd*5  :  d = rnd*5+1
   a1 = a : b1 = b : c1 = c  : d1 = d
   a2 = a : b2 = b : c2 = c  : d2 = d
   a3 = a : b3 = b : c3 = c  : d3 = d

   repeat
      k=inkey
      if len(k)=1 and asc(k)=27 then esc=1:exit  'quit
      if k="r" then cls:exit 'reset initial rnd numbers
      draw_it()
   until esc
wend

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
   if segment mod 30 = 0 then kcol = int(rnd*ncolors)
   segment = segment + 1
   line    x + a ,    y +  b,    x1 + c ,    y1 + d ,kcol
   line   xx + a1,   yy + b1,   xx1 + c1,   yy1 + d1,kcol
   line  xxx + a2,  yyy + b2,  xxx1 + c2,  yyy1 + d2,kcol
   line xxxx + a3, yyyy + b3, xxxx1 + c3, yyyy1 + d3,kcol
   value() :xyopp() :xyopp2() :xyopp3() :xyopp4()
end sub

