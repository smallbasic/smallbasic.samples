option predef load modules
import android
android.sensor_on(0)
s = android.sensor
j = s.z
i = 250
dur = 60

x=xmax/2
y=ymax/2
r1=min(x,y)*.5
r2=min(x,y)*.3
er=20
ew=r1/2.5
eh=r1/3

while 1 
  s = android.sensor
  f = int(s.z * 50)
  if (abs(f - j) > 15) then
    j = f
    f1 = f * rnd * 100
    f2 = f1 + 800
    for f = f1 to f2 step i: sound f, dur: next f
    for f = f2 to f1 step i: sound f, dur: next f

    cls
    circle x,y,r1 
    if (rnd > .5) then
      circle x+ew, y-eh, er color 7 filled
    else
      circle x+ew, y-eh, er
    endif
    if (rnd > .5) then
      circle x-ew, y-eh, er color 7 filled
    else
      circle x-ew, y-eh, er
    endif
    if (j > 400) then
      arc x, y, r2, rad(30), rad(150)
    else
      line x-r2, y+eh, x+r2, y+eh
    endif
    showpage
    
  endif
  delay 100
wend
