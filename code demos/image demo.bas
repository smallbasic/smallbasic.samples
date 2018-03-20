
color 2,1
cls

' open some random image I found on the net
open "http://img2.wikia.nocookie.net/__cb20150113215904/farmville/images/9/92/Lumberjack_Gnome-icon.png" as #1

' the IMAGE function creates a 'system' object, this is stored in variable "i"
' the completed 'i' variable will then have three commands - SHOW, HIDE and SAVE
i = image(#1)

' SHOW takes 0, 2, 3 or 4 arguments [x,y [,zindex [, opacity]]]
i.show(100,50)

' printing 'i' will reveal all of its properties, these can be modified directly
' before calling show
print i
pause 2

i.show(20,20,1)
print i
pause 2

i.show(201,20,1, 56)
print i
pause 2

i.show(120,20,1, 56)
print i
pause 2

i.show(40,120,1,100)
print i

' you can create a second variable using the same image handle
' this allows you to manipulate the same image with a different set of properties
j = image(#1)
j.show(10,25,0,5)
pause true
