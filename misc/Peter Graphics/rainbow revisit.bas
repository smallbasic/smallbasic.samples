' Rainbow revisit.bas adapted to SmallBASIC from NaaLaa
' NaaLaa Rainbow ribbon.txt revised 2015-04-22 B+
maxx=600 :maxy=600:mx=300:my=340
c=Rgb(80,0,230) '========== sky above
rect 0,0,maxx,my,c filled
dc=255 '==================  sky below
for i=0 to 255
   dc=dc-1 :if dc<0 then dc=0
   c=rgb(dc,dc,255)
   circle mx,my,i,1,c 
next
while 1
for i=230 to 255 step 2'======= here is rainbow
   c=rgb(int(rnd*256),int(rnd*256),int(rnd*256))
   circle mx,my,i,1,c 
next
for i=0 to 260 '========== ' now for earth
   rs=i:if rs>255 then rs=255
   bs=180-i:if bs<0 then bs=0
   c=rgb(rs,150,bs)
   line 0,my+i,maxx,my+i,c
next i
for cnt=1 to 50000
   x=rnd*maxx
   y=rnd*260+my
   dc=rnd*100
   c=rgb(125-dc,125-dc,125-dc)
   pset x,y,c
next cnt
k=0
while k=0:k=inkey:wend
if asc(k)=27 then end
wend

rem RED - 255,0,0
rem ORANGE - 255,165,0
rem YELLOW - 255,255,0
rem GREEN - 50,205,50
rem BLUE - 0,191,255
rem INDIGO - 111,0,255
rem VIOLET - 148,0,211

