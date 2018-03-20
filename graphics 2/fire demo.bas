
REM fire by harixxx.bas 2016-02-12 SmallBASIC 0.12.0 [B+=MGA]
'fire demo for smallbasic

messa="SmallBASIC Fire >Run on Jellybean "
tw=txtw(messa)+20
th=txth(messa)+20

dim f(41,41)'fire
dim r(9999)'random table
dim p(2500)'pal colors
dim t(tw,3*th)'message buffers

?messa
'store message buffers
for j=0 to th
for i=0 to tw
'store the red part of rgb
t(i,j)=(-point(i,j) & 255)\4
next i
next j

'it is 192 palettes only
'other for fix the calculations
for i=0 to 63
p(i+1000)=rgbf(i/63,0,0)
p(i+1064)=rgbf(1,i/63,0)
p(i+1128)=rgbf(1,1,i/63)
next
for i=1192 to 2500
p(i)=p(1191)
next

'make random table
for i=0 to 9999
r(i)=(rnd*2240-1000)\1
next

a=xmax*1.03/41
b=ymax*1.08/41
n=340

'main loop
while 1
'scroll xpos message
n=(n+1)mod tw

for i=1 to 40
x=i*a-a
s=1-s
s1=(i+n)mod tw
s2=(i+n+1)mod tw

'random fire seeds
f(i,41)=r(m)
m=(m+1)mod 10000

for j=40 to 0 step -1
 
'make fire
c=f(i-1,j)+f(i,j+1)+f(i+1,j+1)
c=c\3-2-s
f(i,j)=c

'mix fire with message
c=p(1000+c+2*t(s2,j+1)-t(s1,j))

'draw rectangle with mixed palette
rect x,j*b,step a+1,b+2,c filled
next
next

'display screen
showpage
wend
