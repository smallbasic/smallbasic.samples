
#!/usr/local/bin/sbrun -g
cls
midy = ymax/2
midx = xmax/2
otx=midx
oty=midy
n=1.6180339887499
n=n+(n/4.25)
ot=1
dim t(2)
t(1)=1
for j=1 to 12
ot=t(1)+t(2)
if ot>0
? ot
a=a+1 
if a=1 then tx=midx+ot: ty=midy+ot:midx=tx+ot:midy=ty+ot:arc tx+ot,ty-ot, ot*n, RAD(90), RAD(180)
if a=2 then tx=midx+ot: ty=midy-ot:midx=tx+ot:midy=ty-ot:arc tx-ot,ty-ot, ot*n, RAD(0), RAD(90)
if a=3 then tx=midx-ot: ty=midy-ot:midx=tx-ot:midy=ty-ot:arc tx-ot,ty+ot, ot*n, RAD(270), RAD(0)
if a=4 then tx=midx-ot: ty=midy+ot:midx=tx-ot:midy=ty+ot:arc tx+ot,ty+ot, ot*n, RAD(180), RAD(270):a=0

line tx-ot,ty+ot,tx+ot,ty+ot
line tx-ot,ty-ot,tx+ot,ty-ot
line tx-ot,ty-ot,tx-ot,ty+ot
line tx+ot,ty-ot,tx+ot,ty+ot
ax=j-sin(j)
ay=j-cos(j)

endif
t(1)=t(2)
t(2)=ot
next j
? "Press any key to exit"
while ok=""
ok=inkey
wend
end
