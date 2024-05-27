
'#sec:Main
Print "Easter by the method of ";cat(1);"Mallen";cat(-1)
Repeat
    Input "Enter a year : ",y
    If y=0 Then Stop
    EasterDate d,m,y
    Print "Sunday, ";mid$("March April ",1+6*(m-3),6);d;", ";y
Until

Sub EasterDate (Byref d, Byref m, y)

   FirstDig = y \ 100
   Remain19 = y Mod 19

   temp = (FirstDig - 15) \ 2 + 202 - 11 * Remain19
   If FirstDig > 26 Then temp = temp - 1
   If FirstDig > 38 Then temp = temp - 1
   
   If ((FirstDig = 21) Or (FirstDig = 24) Or (FirstDig = 25) Or (FirstDig = 33) Or (FirstDig = 36) Or (FirstDig = 37)) Then temp = temp - 1
   
   temp = temp Mod 30

   tA = temp + 21
   If temp = 29 Then tA = tA - 1
   If (temp = 28 And Remain19 > 10) Then tA = tA - 1
    
   tB = (tA - 19) Mod 7
    
   tC = (40 - FirstDig) Mod 4
   If tC = 3 Then tC = tC + 1
   If tC > 1 Then tC = tC + 1
        
   temp = y Mod 100
   tD = (temp + temp \ 4) Mod 7
    
   tE = ((20 - tB - tC - tD) Mod 7) + 1
   d = tA + tE

   If d > 31 Then
      d = d - 31
      m = 4
   Else
      m = 3
   EndIf

End Sub
'
