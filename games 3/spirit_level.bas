REM SmallBASIC
REM created: 08/12/2016
option predef load modules
import android

sub drawa(xo,yo,zo)
  x =xmax/2
  y =ymax/2
  r = x-50
  a= 3-(zo-9.5)
  br= (r/a)
  xd=-(r*xo/9)
  yd=(r*yo/9)
  cls
  circle x,y,r color 14 filled
  circle x-xd,y-yd,br color 0 filled
rem  ? xo
rem ? yo
 ? zo
  showpage
end

android.sensor_on(0)
while 1
 s=android.sensor
 drawa(s.x,s.y,s.z)
 delay 50
wend






