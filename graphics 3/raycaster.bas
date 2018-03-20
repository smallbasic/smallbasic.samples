
'Raycaster with definekey.bas for SmallBASIC 0.12.6 [B+=MGA] 2016-06-17
' started by Johnno
' Raycaster maze Ricks copy from SB 2016-06-17
' MGA modified with definekey all inkey stuff removed
' still quits with esc and now q

' uses a simple ray casting technique (see lodev.org for tutorial) to draw
' vertical stripes down the graphics window.

' Each stripe is drawn to a size dependent upon the distance of the wall from the viewer.
' "Rays" are cast across a viewing plane in front of the viewer, from left to right.
' the height of the wall stripe depends on the distance of the wall from the viewer.

'InitialSetup
' set up screen width and height
' values also used to determine the width and height of the "viewing plane"
' "size" is used to determine the width of each vertical line drawn.
' a smaller value makes the walls sharper, but draws slower (there are more lines)
' a larger value makes the walls blockier, but draws more quickly

'these replace INKEY catching
definekey 0xFF04, moveLeft    'press left arrow or ccw
definekey 0xFF05, moveRight   'press right arrow or cw
definekey 0xFF09, moveForward 'press up arrow, forward
definekey 0xFF0A, moveBack    'press down arrow, back
definekey 0x0071, quit        'press q
definekey 0x001B, quit        'press esc

w = xmax-1
h = ymax-1
' default size was 8
size = 2.0

'intensity of light source. The lower the number the further you can see.
intensity = .2

dim worldMap(21,21)
dim mapLine(21)
'
' set up the player's start position and direction
' these are the x/y co-ordinates of the world map
' nb absolute values place the player at grid intersections!!
posX = 2.5 '5.5
posY = 2.5 '10.5
dirX = 1
dirY = 0
planeX = 0
'
' plane y is the size of the viewing plane in degrees
' (altering this gives different perspective views)
planeY = 0.66
completed = 1
'
' moveSpeed is how far forward you move each step.
' bigger values create bigger steps, lower values mean smaller (smoother) steps
' RotSpeed is how much you rotate left/right when you turn
' a value of 1/3 of RotSpeed seems about right
moveSpeed = 0.2
RotSpeed = 0.07
cx = XMAX/2 : cy = YMAX /2
View ( cx-400,cy-330,cx+400,cy+330,Rgb(0,0,0),Rgb(100,200,255) )
'=========================================================================

sub main
  completed = 0
  local x = 0
  For x = 0 To w / size ' calculate ray position and direction
    cameraX = 2 * x / (w / size ) - 1 ' x-coordinate in camera space Added fix for divide by 0 error (Rick3137)
    rayPosX = posX
    rayPosY = posY
    rayDirX = dirX + planeX * cameraX
    rayDirY = dirY + planeY * cameraX
    '
    'which box of the map we're in
    mapX = Floor(rayPosX)
    mapY = Floor(rayPosY)
    
    ' length of ray from current position to next x or y-side
    sideDistX = 0
    sideDistY = 0

    ' length of ray from one x or y-side to next x or y-side
    deltaDistX = Sqr(1 + (rayDirY * rayDirY) / (rayDirX * rayDirX))
    deltaDistY = Sqr(1 + (rayDirX * rayDirX) / (rayDirY * rayDirY))
    perpWallDist = 0
    
    'what direction to step in x or y-direction (either +1 or -1)
    stepX = 0
    stepY = 0
    hit = 0 ' was there a wall hit?
    side = 0 ' was a NS or a EW wall hit?
    
    ' calculate step and initial sideDist
    If rayDirX < 0 Then
      stepX = -1
      sideDistX = (rayPosX - mapX) * deltaDistX
    Else
      stepX = 1
      sideDistX = (mapX + 1.0 - rayPosX) * deltaDistX
    End If
    If rayDirY < 0 then
      stepY = -1
      sideDistY = (rayPosY - mapY) * deltaDistY
    Else
      stepY = 1
      sideDistY = (mapY + 1.0 - rayPosY) * deltaDistY
    End If
    
    ' perform DDA
    ' trace a "ray" until it hits a wall, and determine if it's an "X" (horizontal) or "Y" (vertical) wall
    While hit = 0 ' jump to next map square, OR in x-direction, OR in y-direction
      If sideDistX < sideDistY Then
        sideDistX = sideDistX + deltaDistX
        mapX = mapX + stepX
        side = 0
      Else
        sideDistY = sideDistY + deltaDistY
        mapY = mapY + stepY
        side = 1
      End If
      
      ' Check if ray has hit a wall
      If worldMap(mapX,mapY) > 0 Then hit = 1
    Wend

    ' Calculate distance projected on camera direction.
    If side = 0 Then
      perpWallDist = Abs((mapX - rayPosX + (1 - stepX) / 2) / rayDirX)
    Else
      perpWallDist = Abs((mapY - rayPosY + (1 - stepY) / 2) / rayDirY)
    End If
    
    ' Calculate height of line to draw on screen
    lineHeight = Abs(h / perpWallDist)
    lineHeight = int(lineHeight)
    'if height if line to be drawn is > than height of graphics window then limit height of line
    If lineHeight > h Then lineHeight = h
    '
    ' calculate lowest and highest pixel to fill in current stripe
    drawStart = (lineHeight * -1) / 2 + h / 2
    If drawStart < 0 Then drawStart = 0
    drawEnd = lineHeight / 2 + h / 2
    If drawEnd >= h Then drawEnd = h - 1

    ' set up the colours depending on the block numbers
    ' default colour is grey (RGB values are equal)
    colAdj2 = (lineHeight / h) * 250
    colAdj = (lineHeight / h) * 250 - (intensity - colAdj2)
    If colAdj < 0 Then colAdj = 0
    If colAdj > 200 Then colAdj = 200
    colDistR = colAdj
    colDistG = colAdj
    colDistB = colAdj
    
    ' colours are extracted from the 'setupmap' subroutine
    Select Case worldMap(mapX, mapY)
    Case 2 'red
      colDistR = colAdj
      colDistG = 0
      colDistB = 0
    Case 3 'green
      colDistR = 0
      colDistG = colAdj
      colDistB = 0
    Case 4 'blue
      colDistR = 0
      colDistG = 0
      colDistB = colAdj
    Case 5 'magenta
      colDistR = colAdj
      colDistG = 0
      colDistB = colAdj
    Case 6 'yellow
      colDistR = colAdj
      colDistG = colAdj
      colDistB = 0
    End Select
    
    colour = Rgb(colDistR, colDistG, colDistB)
    If side = 1 Then colour = Rgb(colDistR / 1.3, colDistG / 1.3, colDistB / 1.3)
    
    'Here is what wehave all been waiting for!
    'draw the stripe as a vertical line
    Color colour
    Line x * size, drawStart, x * size, drawEnd
    Color Rgb(200, 150, 150)
    Line x * size, 0, x * size, drawStart
    Color Rgb(40, 40, 30)
    Line x * size, drawend, x * size, h
  Next x
  completed = 1
End sub

sub moveForward
  if completed = 1 then
    moveX = dirX * moveSpeed
    moveY = dirY * moveSpeed
    If worldMap(floor(posX + moveX),floor(posy)) = 0 Then posX = posX + moveX
    If worldMap(floor(posx),floor(posY + moveY)) = 0 Then posY = posY + moveY
    'main
  fi
end

sub moveBack
  if completed = 1 then
    moveX = dirX * moveSpeed
    moveY = dirY * moveSpeed
    If worldMap(floor(posX - dirX * moveX),floor(posy)) = 0 Then posX = posX - moveX
    If worldMap(floor(posx),floor(posY - moveY)) = 0 Then posY = posY - moveY
  fi
end

sub moveLeft 'counter-clockwise
  if completed = 1 then
    oldDirx = dirX
    cosRotSpeedL = Cos(-1 * RotSpeed)
    sinRotSpeedL = Sin(-1 * RotSpeed)
    dirX = dirX * cosRotSpeedL - dirY * sinRotSpeedL
    dirY = oldDirX * sinRotSpeedL + dirY * cosRotSpeedL
    oldPlanex = planeX
    planeX = planeX * cosRotSpeedL - planeY * sinRotSpeedL
    planeY = oldPlaneX * sinRotSpeedL + planeY * cosRotSpeedL
  fi
end

sub moveRight 'clockwise
  if completed = 1 then
    oldDirx = dirX
    COSRotSpeedR = Cos(RotSpeed)
    SinRotSpeedR = Sin(RotSpeed)
    dirX = dirX * CosRotSpeedR - dirY * SinRotSpeedR
    dirY = oldDirX * SinRotSpeedR + dirY * CosRotSpeedR
    oldPlaneX = planeX
    planeX = planeX * CosRotSpeedR - planeY * SinRotSpeedR
    planeY = oldPlaneX * SinRotSpeedR + planeY * CosRotSpeedR
  fi
end

Sub setupMap
  mapwidth = 21
  mapheight = 21
  'define the map in the mapLine array as strings
  mapLine(1) = "155555511111111555555"
  mapLine(2) = "600000000000000000005"
  mapLine(3) = "600000002000005000051"
  mapLine(4) = "600000000000305000051"
  mapLine(5) = "600000002600305022201"
  mapLine(6) = "604020006000005000001"
  mapLine(7) = "604031006016604444441"
  mapLine(8) = "600000000010004000001"
  mapLine(9) = "600230000010004000001"
  mapLine(10) = "100000000000004000003"
  mapLine(11) = "100002200022000000003"
  mapLine(12) = "100000000000000000033"
  mapLine(13) = "100002200022000333033"
  mapLine(14) = "100000000000000033031"
  mapLine(15) = "103333311111111011011"
  mapLine(16) = "100000011110000000002"
  mapLine(17) = "100000001110000000002"
  mapLine(18) = "100200000110000000002"
  mapLine(19) = "100000000116543211302"
  mapLine(20) = "100000000000000000003"
  mapLine(21) = "111111111116543211222"
  '
  ' define some parameters that state how big the map is
  mapSizeX = 21 'Text.GetLength (mapLine[1])
  mapSizeY = 21 'array.GetItemCount (mapLine)
  '
  'try to read this in and convert it into a two dimensional array
  For yLoop = 1 To mapSizeY
    For xLoop = 1 To mapSizeX
      worldmap(xloop,yloop) = val(mid(mapLine(yloop),xloop,1))
    Next
  Next
End Sub

Sub quit
  stop
End sub
'=========================================================================
' call the setupmap subroutine to draw the initial map view
setupMap()
While 1
  main
  Showpage
  Delay 10  'the right delay here may make your room sweeps smoother
Wend
