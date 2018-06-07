REM SmallBASIC
REM created: 07/10/2016
option predef load modules
import android
try
android.sensor_on(4)
catch e
? "errr
throw e
end try
while 1
s=android.sensor
? s.x
2? s.y
? s.z
? s.distance
? s.light
? s.name
delay 100
cls
wend


