
'#sec:Main
''Wet and Dry Bulb 
print
Input "Wet Bulb";wet
Input "Dry Bulb";dry
Input "Pressure";Pressure

ed=6.11*exp(17.27*dry/(dry+237.3))
ew=6.11*exp(17.27*wet/(wet+237.3))
wd=.62197*ed/(pressure-ed)
ww=.62197*ew/(pressure-ew)
w=(2500*ww-1.0046*(dry-wet))/(2500+1.81*(dry-wet))
f=w/wd
v=pressure*w/(.62197+w)
td=(237.3*LOG10(v)-186.527)/(8.286-LOG10(v))

cls
Print "Reletive Humidity"
locate 4,2
print"Wet Bulb"
print "Dry Bulb"
print "Pressure"
print "Dewpoint"
print "Reletive Humidity"

locate 4,16
print wet
locate 5,16
print dry
locate 6,16
print pressure
locate 7,16
print round (td,1);" deg C"
locate 8,16
print round(f*100,1);"%"
print
print
pause 30'
