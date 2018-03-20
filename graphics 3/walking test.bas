
'
' Walking Test
'

for a = 1 to 8
open "assets/" + str$(a) + ".png" as #a
next a

a = 1
x = 0
while 1
cls
gosub moveman1
gosub moveman2
gosub moveman3
gosub moveman4
gosub moveman5
gosub moveman6
delay 75
if inkey = chr$(27) then exit
wend

for a = 1 to 8
close #a
next

end

label moveman1
i = image(#a)
i.show(x,0)
a = a + 1
x = x + 4
if x > xmax then x = -90
if a = 9 then a = 1
return

label moveman2
j = image(#a)
j.show(x2,75)
a2 = a2 + 1
x2 = x2 + 5
if x2 > xmax then x2 = -90
if a2 = 9 then a2 = 1
return

label moveman3
k = image(#a)
k.show(x3,150)
a3 = a3 + 1
x3 = x3 + 6
if x3 > xmax then x3 = -90
if a3 = 9 then a3 = 1
return

label moveman4
l = image(#a)
l.show(x4,225)
a4 = a4 + 1
x4 = x4 + 7
if x4 > xmax then x4 = -90
if a4 = 9 then a4 = 1
return

label moveman5
m = image(#a)
m.show(x5,300)
a5 = a5 + 1
x5 = x5 + 8
if x5 > xmax then x5 = -90
if a5 = 9 then a5 = 1
return

label moveman6
n = image(#a)
n.show(x6,375)
a6 = a6 + 1
x6 = x6 + 9
if x6 > xmax then x6 = -90
if a6 = 9 then a6 = 1
return

for a = 1 to 8
close #a
next
