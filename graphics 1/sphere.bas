
' A small 3D globe rotation program 
' Converted  to SB(fltk) 23,may 2006, from an old basic code
' by Keijo koskinen
' You can download sphere.gif from:
'   http://users.csolve.net/~keiko/smallbasic/sphere.gif
' When sphere.gif appears to screen, ..right clic it and shoose save as ..to your bas_home directory
 
 img= env("Bas_Home")+"sphere.gif"
if (!exist(img)) then
  ? "Sphere.gif does not exist "
  ? "then we are rolling this text" 
  ? "with SmallBasic program"
else
  open img for input as #1
  w = imagew(#1,0)
  h = imageh(#1,0)
    x = 1
    y = 1
    image #1,0, x,y,0,0,w,h
  close #1
fi
 ' Sphere numbers
  r=80  ' radius  180
  n=100  ' number of lattitudes
  NumPoints=(n/1)*n*4+2  ' number of dots on sphere
  NumVerts=(n/1)*(n*4-2)+2  ' number of  triangles

DIM Points(NumPoints, 3)
DIM Vertices(NumVerts,4)
DIM Rotation(NumPoints,3)

DIM Sinus(628)
DIM CoSin(628)

 ' Precalc Sine and CoSinus tables
 FOR j = 1 TO 360
    trig=j*(2*pi)/360
    Sinus(j) = sin(trig)   'shl 8  'sin x 256
    CoSin(j) = cos(trig)          'shl 8  'cos x 256
 NEXT j

'*** Create a Sphere  ****

 ' pixel colors from bitmap image for maptexture
 jjj=0
  for yy=1 to n/2
   apu0=n*2
    for xx=1 to apu0
     m_col = point(xx,yy)  'get pixelcolor at x, y
      jjj=jjj+1
       Vertices(jjj,4)=m_col
    next
  next

'Clear the screen
cls

  xx=0
  yy=0
 IF r < 0 THEN r = -r
  IF n < 3 THEN n = 3

  iii=0
  jjj=0
  apu0=(n/2)-1
 FOR thh= 0 TO apu0  '// lluulisi navalta navalle pituus
    theta1 = thh * pi/(n/2)-pi/2   '2*pi / n - pi/2;
     theta2 = (thh + 1) * pi/(n/2)-pi/2   '2*pi / n - pi/2;
    jij=iii+1  ' seuraavan vertices eka piste
   FOR thn= 0 TO n
      iii=iii+1
       theta3 = thn * 2*pi / n
         Points(iii,1)= r*COS(theta2) * COS(theta3)
         Points(iii,2)= r*SIN(theta2)
         Points(iii,3)=r*COS(theta2) * SIN(theta3)
      iii=iii+1
         Points(iii,1)=r*COS(theta1) * COS(theta3)
         Points(iii,2)= r*SIN(theta1)
         Points(iii,3)=r*COS(theta1) * SIN(theta3)
    NEXT
         'jij=iii-(2*n+2)
     apu1=jij
     apu2=iii-2
    for jep = apu1 to apu2 step 2
      jjj=jjj+1
         Vertices(jjj,1)=jep
         Vertices(jjj,2)=jep+1
         Vertices(jjj,3)=jep+2
      jjj=jjj+1
         Vertices(jjj,1)=jep+3
         Vertices(jjj,2)=jep+2
         Vertices(jjj,3)=jep+1
     next
 NEXt

 NumPoints=iii
 NumVerts=jjj

' END of Sphere
goto vector

END                             'end of prog


label vector:   '  main loop for  rotation \

 '-- Rotate angles
 AngleX=1 'AngleX+0.2
  IF AngleX > 360 THEN AngleX = 1  
 AngleY=AngleY+1
  IF AngleY > 360 THEN AngleY = 1  
 AngleZ=1' AngleZ+0'.2
  IF AngleZ > 360 THEN AngleZ = 1
 
' rotate the points according to angles
 FOR i = 1 TO NumPoints
   X = Points(i, 1): Y = Points(i, 2): Z = Points(i, 3)

   Ty = Y * CoSin(AngleX) - Z  * Sinus(AngleX)  ' 
   Tz = Y * Sinus(AngleX) + Z  * CoSin(AngleX)
      
   Tx = X * CoSin(AngleY) - Tz * Sinus(AngleY)
   Tz = X * Sinus(AngleY) + Tz * CoSin(AngleY)
  Ox = Tx
   Tx = Tx * CoSin(AngleZ) - Ty * Sinus(AngleZ)
   Ty = Ox * Sinus(AngleZ) + Ty * CoSin(AngleZ)
 Nx=Tx
 Ny=Ty
   
  Rotation(i, 1) = Nx: Rotation(i, 2) = Ny: Rotation(i, 3) = Tz
 NEXT i
 
' check if face N is visible.
 FOR j = 1 TO NumVerts
   k = Vertices(j, 1): l = Vertices(j, 2): m = Vertices(j, 3):m_col=Vertices(j,4)

    X1 = Rotation(k, 1): X2 = Rotation(l, 1): X3 = Rotation(m, 1)
    Y1 = Rotation(k, 2): Y2 = Rotation(l, 2): Y3 = Rotation(m, 2)
    Z1 = Rotation(k, 3): Z2 = Rotation(l, 3): Z3 = Rotation(m, 3)

  VIS= (X3 - X1) * (Y2 - Y1) - ((X2 - X1) * (Y3 - Y1))  'VIS = value of visibility

 ' Render the Sphere
 IF VIS <-3 then  '    only clearly visible will be drawn

  'triangle vertices color 
  XX1=X1+200
  XX2=X2+200
  XX3=X3+200
  YY1=Y1+200
  YY2=Y2+200
  YY3=Y3+200
  
  '** triangles, globe is so small, so filling not actually needed = faster  
      Line XX1, YY1, XX2, YY2, m_col
      Line XX2, YY2, XX3, YY3, m_col
      Line XX3, YY3, XX1, YY1, m_col
   
  ' triangle centers = filling or drawing points
    l = (XX1 + XX2 + XX3) / 3
    m = (YY1 + YY2 + YY3) / 3
    
  '** if trianles used then they can be filled ****
     ' Paint l, m,m_col,m_col   ' can't use ..this overflows
    
  '** if triangles not used  ...use one of following  ***
     ' circle l,m,2,1,m_col filled
     ' rect l-2,m-2,l+2,m+2,m_col filled 
     ' PSET l,m,m_col
  
   END IF
 NEXT j
goto vector
