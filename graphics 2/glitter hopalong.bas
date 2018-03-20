
'Glitter hopalong.bas for SmallBASIC 0.12.0
' modified from: Hopalong-like fractal maths derived from a 1980''s Acorn User one-line program
' converted to SmallBASIC by Martin Latter, 7 Nov 2006
' color changes for the night shift updated for Android 2015-11-26 MGA/B+

while 1
   at 0,0:? "Glitter Hopalong ... click lower to restart, upper to quit."
   j = RND * 100
   k = RND * 100
   x = 0:y = 0:r = 0:n = 0
   xoffs = XMAX / 2
   yoffs = YMAX / 2-20
   FOR i = 1 TO 1000000
     r = RND * 4000
     IF r > 3950 THEN cc=1+RND*15
     xx = y - SGN(x) * SQR(ABS(k * x - 1))
     y = j - x
     x = xx
     xp = x * 3 + xoffs
     yp = y * 3 + yoffs
     if yp>20 then rect xp, yp step 2,2,cc filled
     if i mod 1000=0 then 
       pen on
       showpage
       delay 10
       if pen(3) then
         if pen(5)>ymax/2 then
           i=1000000
         else
           pen off:cls:showpage:end
         fi
       fi
       pen off
     fi 
   NEXT
   cls
wend
