
'
'';Galaxy Collision Program  ver 0.9
'';Keijo Koskinen 20/4/2005  for smallbasic
'';Displays collision, views from X-Y and X-Z direction
'';core algorithm modified from old  Galaxy Collision
'';Astronomy magazine Dec 88 page 92.
'';by M.C.Schroeder and Neil F. Comins,
''
DIM Xs(2,1000), Ys(2,1000), Zs(2,1000) ''; target gal=(1,) intruder=(2,) coordinates
dim  VXs(2,1000), VYs(2,1000), VZs(2,1000)  ''; speed
dim  NRR(2),NRS(2),NS(2),DR(2)
CLS
color 10,0

''; TARGET GALAXY
NRR(2) = 23                ''; orbits in target gal
NRS(2) = 10                ''; stars / orbit in target galaxy
NS(2) = NRR(2) * NRS(2)    ''; Total of stars in target galaxy
DR(2) = 20 / (NRR(2) - 1)
M2 = 6                     ''; Target galaxy mass
X2 = 200                   ''; initial Target galaxy coordinates
Y2 = 90
Z2 = 10
''; ***   Try here different  speed factor  to greate different action
'';       VX2=0.085       ; distroys totally galaxies
'';       VY2=0

'';       VX2=-0.085     ''; really hot relationship in the beginning
'';       VY2=0.065

'';       VX2= .085      ; galazies keep fighting over 1000 million years
'';       VY2=-0.29

'';       VX2= -0.4      ''; galazies keep dancing over and over
'';       VY2=-0.4

'';       VX2=-0.116      ''; What a tension
'';       VY2=-0.41

VX2=-0.116
VY2=0.52
                  '';
VZ2 = 0

''; INTRUDER GALAXY

NRR(1) = 23                 ''; rings in intruder galaxy
NRS(1) = 10                 ''; stars/ring in  intruder galaxy
NS(1) = NRR(1) * NRS(1)     ''; Total of stars in intruder galaxy
DR(1) = 20 / (NRR(1) - 1)
 M1 = 6                     ''; Intruder galaxy mass
 X1 = 150
 Y1 = 100                   ''; Initial coordinates of intruder galaxy
 Z1 = 0
 VX1 = 0                    ''; Intruder galaxy initial speed
 VY1 = 0
 VZ1 = 0
 
 ''; common factors
 SF2 = 2                    ''; softening factor
 k=0.1                      ''; size factor
 gsize=k*xmax/((NRR(1)+NRR(2))/2)
 
 NTSPR = 2000               ''; Time / millions of years
 TIIME = 0
 
''; place stars in orbits in target galaxy
''; from r=4 and p at intervals of dr
I=1
 FOR IR = 1 TO NRR(1)
  R = 4 + (IR/1 - 1) * DR(1)
 V = SQR(((M1*DR(1))/1) / R)
 TH = (.5 * V / R) * (180 / 3.14159)
 IF R <10 THEN V = .99 * V
 if R<7 then V=.98*V
 if R <5 then V=0.95*V
 FOR IT = 1 TO NRS(1)
  T = rnd * 360
 I = I + 1
''; initialize stars positions
 Xs(1,I) = R * COS(T / 57.2958) + X1
 Ys(1,I) = R * SIN(T / 57.2958) + Y1
 Zs(1,I) = Xz1+0
 VZs(1,I) = VZ1+0
''; init star velocities in orbits
 VXs(1,I) = -V * SIN(T/57.2958) +VX1
 VYs(1,I) = V * COS(T/57.2959) +VY1
 NEXT IT
 NEXT IR

''; place stars in orbits in  intruder galaxy
''; from r=4 and up at intervals of dr
I=1
 FOR IR = 1 TO NRR(2)
 R = 4 + (IR/1 - 1) * DR(2)
 V = SQR(((M2*DR(2))/1) / R)
 TH = (.5 * V / R) * (180 / 3.14159)
 IF R <9 THEN V = .93 * V
 if R<7 then V=.92*V
 if R <5 then V=0.9*V
 FOR IT = 1 TO NRS(2)
 T=rnd*360
 I = I + 1
''; initialize stars positions
 Xs(2,I) = R * COS(T / 57.2958) + X2
 Ys(2,I) = R * SIN(T / 57.2958) + Y2
 Zs(2,I) = Z2+0
 VZs(2,I) = VZ2+0
'';init star velocities in orbits
 VXs(2,I) = -V * SIN(T/57.2958)+VX2
 VYs(2,I) = V * COS(T/57.2958) +VY2
 NEXT IT
 NEXT IR
 
 scr_update
 
 ''; particle pusher routine
label timesteps
 FOR K = 1 TO NTSPR   ''; ok lets go
 
 ''; determine the forces pulling stars  in intruder gal
 J = 2
 FOR I = 1 TO NS(J)
 R1 = M1 / ((Xs(J,I) - X1) ^ 2 + (Ys(J,I) - Y1) ^ 2 + (Zs(J,I) - Z1) ^ 2 + SF2) ^ 1.5
 R2 = M2 / ((Xs(J,I) - X2) ^ 2 + (Ys(J,I) - Y2) ^ 2 + (Zs(J,I) - Z2) ^ 2 + SF2) ^ 1.5
''; calculate stars x,y,z accelerations
 AX = R1 * (X1 - Xs(J,I)) + R2 * (X2 - Xs(J,I))
 AY = R1 * (Y1 - Ys(J,I)) + R2 * (Y2 - Ys(J,I))
 AZ = R1 * (Z1 - Zs(J,I)) + R2 * (Z2 - Zs(J,I))
''; update star positions and velocities
 VXs(J,I) = VXs(J,I) + AX
 VYs(J,I) = VYs(J,I) + AY
 VZs(J,I) = VZs(J,I) + AZ
 Xs(J,I) = Xs(J,I) + VXs(J,I)
 Ys(J,I) = Ys(J,I) + VYs(J,I)
 Zs(J,I) = Zs(J,I) + VZs(J,I)
 NEXT I
 
 ''; determine the forces pulling stars  in target gal
 J = 1
 FOR I = 1 TO NS(J)
 R1 = M1 / ((Xs(J,I) - X1) ^ 2 + (Ys(J,I) - Y1) ^ 2 + (Zs(J,I) - Z1) ^ 2 + SF2) ^ 1.5
 R2 = M2 / ((Xs(J,I) - X2) ^ 2 + (Ys(J,I) - Y2) ^ 2 + (Zs(J,I) - Z2) ^ 2 + SF2) ^ 1.5
''; calculate stars x,y,z accelerations
 AX = R1 * (X1 - Xs(J,I)) + R2 * (X2 - Xs(J,I))       ''kokeilu nurin   x1 ja x2
 AY = R1 * (Y1 - Ys(J,I)) + R2 * (Y2 - Ys(J,I))        '' samoin
 AZ = R1 * (Z1 - Zs(J,I)) + R2 * (Z2 - Zs(J,I))         '' kuin myos
''; update star positions and velocities
 VXs(J,I) = VXs(J,I) + AX
 VYs(J,I) = VYs(J,I) + AY
 VZs(J,I) = VZs(J,I) + AZ
 Xs(J,I) = Xs(J,I) + VXs(J,I)
 Ys(J,I) = Ys(J,I) + VYs(J,I)
 Zs(J,I) = Zs(J,I) + VZs(J,I)
 NEXT I
 
 ''; update postions and velocities of the galactic centers
 RR = ((X1 - X2) ^ 2 + (Y1 - Y2) ^ 2 + (Z1 - Z2) ^ 2 + SF2) ^ 1.5
 AX = (X2 - X1) / RR: AY = (Y2 - Y1) / RR: AZ = (Z2 - Z1) / RR
 VX1 = VX1 + M2 * AX: VY1 = VY1 + M2 * AY: VZ1 = VZ1 + M1 * AZ     ''; +M1*AZ
 VX2 = VX2 - M1 * AX: VY2 = VY2 - M1 * AY: VZ2 = VZ2 - M1 * AZ
 X1 = X1 + VX1
 Y1 = Y1 + VY1
 Z1 = Z1 + VZ1
 X2 = X2 + VX2
 Y2 = Y2 + VY2
 Z2 = Z2 + VZ2
 TIIME = TIIME + 1

 '';FOR III = 0 TO 100: NEXT    ''; use this if your program is running too fast
 
scr_update
 NEXT K
 end

'' ;update screen display
sub scr_update
''; calculate center of mass of whole system
 XC = (M1 * X1 + M2 * X2) / (M1 + M2)
 YC = (M1 * Y1 + M2 * Y2) / (M1 + M2)
 ZC = (M1 * Z1 + M2 * Z2) / (M1 + M2)
 
''; calculate position of galactic centers and display on screem
 XX1 = (X1 - XC)
 YY1 = (Y1 - YC)
 ZZ1 = (Z1 - ZC)
 XX2 = (X2 - XC)
 YY2 = (Y2 - YC)
 ZZ2 = (Z2 - ZC)
  ''; make black backgrounds
 rect 1,1,xmax,ymax/2-5,0 filled
 rect 1,ymax/2+5,xmax,ymax,0 filled
 
 ''; galaxy centers on X-Y view
 CIRCLE (XX1*gsize) + (xmax/2), (YY1*gsize) + (ymax*0.75), 2,1, 9  '';11
 CIRCLE (XX2*gsize) + (xmax/2), (YY2*gsize) + (ymax*0.75), 2,1, 13  '';15
 
 ''; galaxy centers on X-YZ view
 CIRCLE (XX1*gsize) + (xmax/2), (ZZ1*gsize) + (ymax*0.25), 2,1,9  '';11
 CIRCLE (XX2*gsize) + (xmax/2),(ZZ2*gsize)+(ymax*0.25), 2,1, 13  '';15
''; place stars on screen
 J=1
FOR I = 1 TO NS(J)
  XP = (Xs(J,I) - XC): YP = (Ys(J,I) - YC): ZP = (Zs(J,I) - ZC)
 ''; stars of intruder galaxy on X-Y view
  PSET (XP*gsize) + (xmax/2), (YP*gsize) + (ymax*0.75), 11
 ''; stars of intruder galaxy on X-Z view
  PSET (XP*gsize) + (xmax/2),(ZP*gsize) + (ymax*0.25), 11
NEXT I

 J=2
FOR I = 1 TO NS(J)
 XP = (Xs(J,I) - XC): YP = (Ys(J,I) - YC): ZP = (Zs(J,I) - ZC)
 ''; stars of target galaxy on X-Y view
  PSET (XP*gsize) + (xmax/2), (YP*gsize) + (ymax*0.75), 15
 ''; stars of target galaxy on X-Z view
   PSET (XP*gsize) + (xmax/2),(ZP*gsize) + (ymax*0.25), 15
NEXT I

 ''; print out display headings
LOCATE 1,1: PRINT "Upper View = X-Z                             ....Time > ", TIIME ,"Million years"
LOCATE 2,1: PRINT "Lower View = X-Y"

 end sub

'
