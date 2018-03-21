REM SmallBASIC
REM created: 07/05/2016

' What's new in version 2.2:
' 1. Water Pressure implemented. (Pressure is Speed... of Atoms...);
'    e.g. If Pressure = 5 Then each drop = 5 drops.
' 2. Bug fix for SB 0.12.2: BAND instead of AND which returns 1 OR -1
' 3. User is prompt to choose factors.
' 4. MaxX = 800 to avoid error in high pressure.
' 5. Minimum MaxDrops is 100 (for high pressure).

'===========================================================================
' Subject: WATER SIMULATION Date: 08-19-98 (13:57)
' Author: Joe Huber, Jr. Code: QB, QBasic, PDS
' Origin: huberjjr@nicom.com Packet: GRAPHICS.ABC
'===========================================================================

' Hit TAB To pull the plug, ESC To exit (N/A) - just hit Ctrl+B to Stop...

' If anybody has any ideas about how To implement pressure, please email me

' please send any comments, questions, ect. To huberjjr@nicom.com


' Prompt user to enter a factor:
Func factor(prompt, minv, maxv, is_int, defv)
  Local n

  prompt = "\tEnter " + prompt + " [" + minv + ".." + maxv + "] "

  Color 15: ? Cbs(prompt + "(Default=" + defv +"): " + Chr(7));
  Lineinput n

  If Empty(Trim(n)) Then ' user just pressed Enter, so use default value
    n = defv
  Else
    n = Val(n)
    If is_int Then n = Int(n) ' use Integer value (not Real)
    If n < minv Or n > maxv Then n = defv ' invalid value, so use Default
  Fi
  Color 14: ? Cbs("\t") + n

  factor = n
End Func


' Initialize variables (also let user enter factor values):
? Cbs(Cat(0) + Chr(12) + "\n\t" + Cat(2) + "WATER SIMULATION\n")
? Cbs(Cat(0) + "\t\t( Press ENTER for using default values... )\n")

' Pressure 1 is default (low-pressure)
Const Pressure     = factor("Water Pressure", 1, 5, True, 1)
' MaxDrops 6000 is default; less=faster. On my P133, I can get (author's PC)
Const MaxDrops     = factor("Maximum Drops", 100, 9000, True, 6000)
' SpreadChance 0.5 is default (50-50 for RND); try 0..1 For interesting effects
Const SpreadChance = factor("Spread Chance", 0, 1, False, 0.5)
' SpreadTime 3 is default; how many cycles of free-fall it takes
Const SpreadTime   = factor("Spread Time", 1, 9, True, 3)

? Cbs(Cat(0) + "\nPress any key to start...")
Showpage: Pause ' Pause after prompt for factors...

Const MaxX         = 800  ' 320  ' about 33 fps compiled with 6000 drops
' Const MaxY       = 200  ' and 20 fps in QBasic w/1000 drops
Const MaxY         = Ymax

Const Half_MaxX    = MaxX \ 2

Const h2o = Rgb(0, 128, 255) ' Water color
Const BLACK = 0              ' Empty color (no water no lines no nothing)


' The water To spread     ' (in some languages 1-D array is faster...)
Dim Water_X(1 To MaxDrops)
Dim Water_Y(1 To MaxDrops)
Dim Water_FreeTime(1 To MaxDrops)
Dim Water_LastDir(1 To MaxDrops)

For i = 1 To MaxDrops
  Water_X(i) = Half_MaxX
  Water_Y(i) = 1
  Water_FreeTime(i) = 0
Next i


' Draw all the construction before start:
Sub draw_construction
  Local lm, rm, p, m = Half_MaxX ' middle of construction
  Local lmh = m - Pressure + 1   ' Left to the middle factor  (for horizontal)
  Local rmh = m + Pressure - 1   ' Right to the middle factor (for horizontal)
  Local pr = Pressure - 1        ' (for extending vertical)

  For p = 0 To Pressure - 1 ' you need strong pipes for strong pressure

    lm = m - p  ' Left to the middle factor
    rm = m + p  ' Right to the middle factor

    ' Draws box at top
    Line lm - 20 , 1     ,  lm - 20 , 20     Color 15 ' vertical
    Line rm + 20 , 1     ,  rm + 20 , 20     Color 15 ' vertical
    Line lmh - 20, 20 + p,  rmh + 20, 20 + p Color 15 ' horizontal

    ' Draws Pipe
    Line lm - 4 , 20    ,  lm - 4  , 44     Color 15 ' vertical
    Line rm + 4 , 20    ,  rm + 4  , 50     Color 15 ' vertical
    Line lmh - 4, 44 - p,  lmh - 40, 44 - p Color 15 ' horizontal
    Line rmh + 4, 50 + p,  lmh - 40, 50 + p Color 15 ' horizontal

    ' Draws slanted line (draw few lines to fill up few holes)
    Line lmh - 110, 50 + p,  rmh + 40, 110 + p Color 15 ' slanted
    Line lmh - 110, 51 + p,  rmh + 40, 111 + p Color 15 ' slanted
  ' Line lmh - 110, 52 + p,  rmh + 40, 112 + p Color 15 ' slanted

    ' Draws box under slanted lines
    Line lm - 10 , 130    ,  lm - 10 , 150     Color 15 ' vertical
    Line rm + 90 , 130    ,  rm + 90 , 150     Color 15 ' vertical
    Line lmh - 10, 150 + p,  rmh + 90, 150 + p Color 15 ' horizontal

    ' Draw two boxes under box
    Line lm - 40 , 170    ,  lm - 40 , 210     Color 15 ' vertical
    Line rm + 0  , 180    ,  rm + 0  , 210     Color 15 ' vertical
    Line lmh - 40, 210 + p,  rmh + 0 , 210 + p Color 15 ' horizontal

    Line rm + 70  , 180    ,  rm + 70  , 210 + pr Color 15 ' vertical
    Line rm + 110 , 170    ,  rm + 110 , 210      Color 15 ' vertical
    Line rmh + 70 , 210 + p,  rmh + 110, 210 + p  Color 15 ' horizontal

    ' Draw pipe between boxes
    Line rmh + 1 , 180 + p,  rmh + 30, 180 + p Color 15 ' horizontal
    Line rmh + 40, 180 + p,  rmh + 70, 180 + p Color 15 ' horizontal

    ' Draw lowest catchment
    Line rm + 20 , 210    ,  rm + 20 , 270 + pr Color 15 ' vertical
    line rm + 50 , 210    ,  rm + 50 , 270      Color 15 ' vertical
    Line rmh + 20, 270 + p,  rmh + 50, 270 + p  Color 15 ' horizontal
  Next p
End Sub


' Display the time it took, and stop the program:
Sub Quit_Program
  Local end_time = timer ' check how long it takes...

  At MaxX, 20: Color 14, 1
  ? " That took: "; end_time - start_time + 1; " seconds. "
  Showpage
  Stop
End Sub


' Open the cork to let the water flow:
Sub Break_the_cork
  Local i, p

  For p = 0 To Pressure - 1 ' you need strong pipes for strong pressure
    For i = 0 To 3
      Vscrn(Half_MaxX + i, 20 + p) = BLACK ' update virtual screen
      Vscrn(Half_MaxX - i, 20 + p) = BLACK
      Pset Half_MaxX + i, 20 + p, BLACK    ' update real screen
      Pset Half_MaxX - i, 20 + p, BLACK
    Next i
  Next p
  Showpage
End Sub


Color 7, BLACK: Cls
draw_construction

' Update Virtual screen (Vscrn should be faster then POINT):
Dim Vscrn(1 To MaxX, 1 To MaxY)
For x = 1 To maxX
  For y = 1 To MaxY
    Vscrn(x, y) = Point(x, y)
  Next y
Next x


' INKEY is too slow in SB 0.12.2; Maybe DEFINEKEY is a bit faster...?
' Definekey 27, Quit_Program   ' Escape key to Stop
' Definekey  9, Break_the_cork ' Tab key Break the cork

Break_the_cork ' Don't use DEFINEKEY, for speeding up (Ctrl+B to Stop).
Showpage
Randomize Timer
start_time = timer ' check how long it takes...

' Main loop (Hit TAB To pull the plug, ESC To exit) - just hit Ctrl+B to Stop:
Label Start_Main_Loop

For i = 1 To MaxDrops
  OldX = Water_X(i) ' For erase (and for speed...)
  OldY = Water_Y(i)

  WLeft  = OldX - Pressure ' Precalcs posision To the left,
  WRight = OldX + Pressure ' ... To the right,
  WDown  = OldY + Pressure ' ... And below

  Select Case Vscrn(OldX, WDown) ' Check point-down below droplet
  Case BLACK
    If Water_FreeTime(i) = SpreadTime Then ' spread effect
      If Rnd < SpreadChance Then
        Select Case Rnd < .5 ' (50-50 chance) space to Right or Left is free?
        Case 1:   If Vscrn(WRight, WDown) = BLACK Then Water_X(i) = WRight
        Case Else: If Vscrn(WLeft, WDown) = BLACK Then Water_X(i) = WLeft
        End Select
      Fi
      Water_FreeTime(i) = 0
    Fi
    Water_Y(i) = WDown
    Water_FreeTime(i)++
    Water_LastDir(i) = 0
    Move = True

  Case Else ' Not BLACK
    PntLeft  = (Vscrn(WLeft, OldY) = BLACK)  ' can't fall down, so
    PntRight = (Vscrn(WRight, OldY) = BLACK) ' check To right & left
    Move = (PntLeft Or PntRight)

    If Move Then
      Select Case 1 ' (Select Case should be faster then If..Then)
      Case (PntLeft Band PntRight) ' Bug fix for SB0.12.2: BAND instead of AND
        Select Case Water_LastDir(i)
        Case 0    ' are free, travel
          Select Case Rnd < .5  ' in last known dir,
          Case 1
            Water_X(i) = WLeft  ' Else pick a new one
            Water_LastDir(i) = -Pressure
          Case Else ' (50-50 chance)
            Water_X(i) = WRight
            Water_LastDir(i) = Pressure
          End Select
        Case Else ' <> 0
          Water_X(i) += Water_LastDir(i) ' If both directions
        End Select

      Case PntLeft ' if the left is open, go there...
        Water_X(i) = WLeft
        Water_LastDir(i) = -Pressure

      Case Else ' PntRight   ' ...or go right
        Water_X(i) = WRight
        Water_LastDir(i) = Pressure
      End Select
    Fi ' if Move
  End Select

  ' did it move (OldX <> Water_X(i) Or OldY <> Water_Y(i))?
  If Move Then
    Pset OldX, OldY, BLACK ' yes, erase
    Pset Water_X(i), Water_Y(i), h2o ' and draw
    ' update virtual screen
    Vscrn(OldX, OldY) = BLACK ' yes, erase
    Vscrn(Water_X(i), Water_Y(i)) = h2o ' and draw
    Move = False ' reset flag
  Fi
Next i

Showpage ' Using SHOWPAGE should speed-up main loop

Goto Start_Main_Loop ' Unconditional jump (as fast as the light...)

End