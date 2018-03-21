' Spiral Pearl Swirl 4 SB.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-03-01
'from Spiral Pearl Swirl.bas for FreeBASIC [B+=MGA] 2017-02-28
'from SdlBasic 3d version 2017-02-28
' inspired by spiral Bang

'whatever screen size your device here is middle
cx = xmax/2 : cy = ymax/2  
While 1 'checking for key press slows down interpeter too much
  size = 1
  radius = .06
  angle = sangle
  cls
  While radius < 400
    x = cos(angle) * radius
    y = sin(angle) * radius
    r2 = (x ^ 2 + y ^ 2) ^ .5
    size = 4 * r2 ^ .25
    For r = size to 1 step - 2
      cc = 160 + 95 * radius/400 - r/size*120
      Color (rgb(cc, cc, cc))
      Circle cx + x, cy + y, r filled
    Next
    angle -= .4
    radius += 1
  Wend
  showpage ' update screen with new image
  'no delay needed as SB isn't as fast as an FB .exe
  sangle = sangle + pi/18
Wend