
'Snow Snake.bas SmallBASIC 0.12.0 05-11-2015 update by MGA/B+
'translated and modified snow snake from PeterMaria BP.org 2015-10-22 post
'
color 0,9
while asc(inkey)<>27
   cls
   for t=0 to 1 Step .01
      xs=.6*xmax+100*cos(a*t)
      ys=ymax/2-100*sin(t*8)
      if sin(t*100)>0 then c=15 else c=0
      circle xs-100,i+ys,20,1,c filled
   next
   circle xs-117,ys,3,1.5,12 filled
   circle xs-83,ys,3,1.5,12 filled
   if m mod 10=0 then
      rect xs-101,ys+5,xs-99,ys+18,12 filled
      line xs-101,ys+18,xs-103,ys+23,12
      line xs-99,ys+18,xs-97,ys+23,12
      line xs-103,ys+6,xs-97,ys+6,12
      flag=1
   else
      line xs-101,ys+6,xs-99,ys+6,12
      flag=0
   end if
   a +=.1:if a>=16 then a=-a
   m+=1
   at 0,0:?"Also try w, k, b, r keys..."
   at 100,40:? "Hsssterical Snow Snake"
   showpage
   if flag then delay 60 else delay 10
   k=inkey
   if k="w" then color 0,15
   if k="k" then color 15,0
   if k="r" then color 15,12
   if k="b" then color 0,9
wend
