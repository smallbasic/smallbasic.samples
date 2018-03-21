option predef antialias off

' Note: tested with SmallBASIC version 0.12.6 for Linux.
Const CSI_EL = Chr(27) + "[K"  ' EL - Erase in Line (clear to end of line).

Sub title(txt) 
  Locate 0, 0: Color 7, 0: ? CSI_EL; txt;
End Sub

' Draw a demo image with text on screen:
title("Draw a demo image")
Pset 100, 100
Circle Step 0, 0, 50 Color 7 Filled
Circle Step 0, 0, 35 Color 1 Filled
text = "Hello"
At Point(0) - Txtw(text) \ 2, Point(1) - (Txth(".") \ 2)
Color 14, 1: Print text;
Pause

title("Create image from screen")
i = Image(50, 50, 102, 102)  ' Create image from screen (x, y, width, height)
i.Show(350, 50)              ' Show the image at location (x, y)
Pause

title("Hide the image")
i.Hide()                     ' Hide the image
Pause

title("Save the image to 2-D array (y, x) of pixels")
i.Save(a)                    ' Save the image to 2-D array (y, x) of pixels
i2 = Image(a)                ' Create a new image from the 2-D array
i2.Show(200, 90)             ' Show the new image at location (x, y)
Pause

title("Modify the colors of the 2-D array (y, x)")
For y = 0 To Ubound(a, 1)    ' Modify the colors of the 2-D array (y, x)
  For x = 0 To Ubound(a, 2)
    c = a(y,x)
    r = ((c band 0xff0000) rshift 16)
    g = ((c band 0xff00) rshift 8)
    b = (c band 0xff)
'    logprint c + " " + rgb(r,g,b)
    a(y, x) = -rgb(r,g,b)
  Next
Next
i2 = Image(a)                ' Create a new image from the modified 2-D array
i2.Show(350, 50)             ' Show the new image at location (x, y)
Pause

title("Copy the top-left of the 2-D array (y, x)")
half_y = Ubound(a, 1) / 2    ' Copy the top-left of the 2-D array (y, x)
half_x = Ubound(a, 2) / 2
Dim a2(half_y, half_x)

For y = 0 To half_y
  For x = 0 To half_x
    a2(y, x) = a(y, x)
  Next
Next

i2 = Image(a2)               ' Create a new image from the top-left 2-D array
i2.Show(200, 90)             ' Show the new image at location (x, y)
Pause

' Note: 'zindex' is probably order of layers - above/under other image(s).
title("Show original image using zindex & opacity")
i.Show(400, 100, 1, 50)      ' Show original image (x, y, zindex, opacity)
Pause

i3 = Image(i)                ' Create a new image from original image
i3.Show(440, 130, 0)         ' Show the new image (x, y, zindex)
Pause


' Note: file name is case sensitive on Linux.

title("Save & Load original image as a PNG file")
Open "circle.png" For Output As #1
i.Save(#1)                   ' Save original image as a PNG file
Close #1

Open "circle.png" For Input As #1
i4 = Image(#1)               ' Load image from a PNG file
Close #1

i4.Show(600, 20)             ' Show loaded image (x, y)
Pause