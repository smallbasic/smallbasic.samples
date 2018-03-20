
rem Title: G_COL_pd
rem Description: Galaxy Collision for small Pda  PalmOs (like Sony Clie SJ22)
rem This is undocumented, because of memory requirements, If You want follow the documented source code , download  G_COL_09 for Your Windows  or Linux (not tested) machine.
rem Category: Applications
rem Copyright: Keijo Koskinen
rem Email: keijoko@csolve.net
rem Created: 26.04.2005
rem Version: 0.9
rem Sbver: SB 0.3  PalmOs
'
DIM Xs(2,300), Ys(2,300), Zs(2,300) 
dim  VXs(2,300), VYs(2,300), VZs(2,300)  
dim  NRR(2),NRS(2),NS(2),DR(2)
CLS
color 10,0
NRR(2) = 6
NRS(2) = 6  
NS(2) = NRR(2) * NRS(2)  
DR(2) = 10 / (NRR(2) - 1)
M2 = 6     
X2 = 180     
Y2 = 90
Z2 = 7
VX2 = -0.42   
VY2 =- .3
VZ2 = 0
NRR(1) = 6         
NRS(1) = 6   
NS(1) = NRR(1) * NRS(1)   
DR(1) = 10 / (NRR(1) - 1)
 M1 = 6       
 X1 = 150     
 Y1 = 100
 Z1 = 0
 VX1 = 0       
 VY1 = 0
 VZ1 = 0
 SF2 = 2          
 k=0.03          
 gsize=k*xmax/((NRR(1)+NRR(2))/2)
 NTSPR = 130              
 TIIME = 0
I=1
 FOR IR = 1 TO NRR(1)
  R = 4 + (IR/1 - 1) * DR(1)
 V = SQR(((M1*DR(1))/1) / R)
 TH = (.5 * V / R) * (180 / 3.14159)
 IF R <10 THEN V = .93 * V
 if R<7 then V=.92*V
 if R <5 then V=0.9*V
 FOR IT = 1 TO NRS(1)
  T = rnd * 360
 I = I + 1

 Xs(1,I) = R * COS(T / 57.2958) + X1
 Ys(1,I) = R * SIN(T / 57.2958) + Y1
 Zs(1,I) = Xz1+0
 VZs(1,I) = VZ1+0

 VXs(1,I) = -V * SIN(T/57.2958) +VX1
 VYs(1,I) = V * COS(T/57.2959) +VY1
 NEXT IT
 NEXT IR
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
 Xs(2,I) = R * COS(T / 57.2958) + X2
 Ys(2,I) = R * SIN(T / 57.2958) + Y2
 Zs(2,I) = Z2+0
 VZs(2,I) = VZ2+0
 VXs(2,I) = -V * SIN(T/57.2958)+VX2
 VYs(2,I) = V * COS(T/57.2958) +VY2
 NEXT IT
 NEXT IR
 scr_update
label timesteps
 FOR K = 1 TO NTSPR
 J = 2
 FOR I = 1 TO NS(J)
 R1 = M1 / ((Xs(J,I) - X1) ^ 2 + (Ys(J,I) - Y1) ^ 2 + (Zs(J,I) - Z1) ^ 2 + SF2) ^ 1.5
 R2 = M2 / ((Xs(J,I) - X2) ^ 2 + (Ys(J,I) - Y2) ^ 2 + (Zs(J,I) - Z2) ^ 2 + SF2) ^ 1.5
 AX = R1 * (X1 - Xs(J,I)) + R2 * (X2 - Xs(J,I))
 AY = R1 * (Y1 - Ys(J,I)) + R2 * (Y2 - Ys(J,I))
 AZ = R1 * (Z1 - Zs(J,I)) + R2 * (Z2 - Zs(J,I))
 VXs(J,I) = VXs(J,I) + AX
 VYs(J,I) = VYs(J,I) + AY
 VZs(J,I) = VZs(J,I) + AZ
 Xs(J,I) = Xs(J,I) + VXs(J,I)
 Ys(J,I) = Ys(J,I) + VYs(J,I)
 Zs(J,I) = Zs(J,I) + VZs(J,I)
 NEXT I
 J = 1
 FOR I = 1 TO NS(J)
 R1 = M1 / ((Xs(J,I) - X1) ^ 2 + (Ys(J,I) - Y1) ^ 2 + (Zs(J,I) - Z1) ^ 2 + SF2) ^ 1.5
 R2 = M2 / ((Xs(J,I) - X2) ^ 2 + (Ys(J,I) - Y2) ^ 2 + (Zs(J,I) - Z2) ^ 2 + SF2) ^ 1.5
 AX = R1 * (X1 - Xs(J,I)) + R2 * (X2 - Xs(J,I))      
 AY = R1 * (Y1 - Ys(J,I)) + R2 * (Y2 - Ys(J,I))       
 AZ = R1 * (Z1 - Zs(J,I)) + R2 * (Z2 - Zs(J,I))   
 VXs(J,I) = VXs(J,I) + AX
 VYs(J,I) = VYs(J,I) + AY
 VZs(J,I) = VZs(J,I) + AZ
 Xs(J,I) = Xs(J,I) + VXs(J,I)
 Ys(J,I) = Ys(J,I) + VYs(J,I)
 Zs(J,I) = Zs(J,I) + VZs(J,I)
 NEXT I
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
scr_update
 NEXT K
 end
sub scr_update
 XC = (M1 * X1 + M2 * X2) / (M1 + M2)
 YC = (M1 * Y1 + M2 * Y2) / (M1 + M2)
 ZC = (M1 * Z1 + M2 * Z2) / (M1 + M2)
 XX1 = (X1 - XC)
 YY1 = (Y1 - YC)
 ZZ1 = (Z1 - ZC)
 XX2 = (X2 - XC)
 YY2 = (Y2 - YC)
 ZZ2 = (Z2 - ZC)
 rect 1,1,xmax,ymax/2-5,0 filled
 rect 1,ymax/2+5,xmax,ymax,0 filled
 CIRCLE (XX1*gsize) + (xmax/2), (YY1*gsize) + (ymax*0.75), 2,1, 11
 CIRCLE (XX2*gsize) + (xmax/2), (YY2*gsize) + (ymax*0.75), 2,1, 15
 CIRCLE (XX1*gsize) + (xmax/2), (ZZ1*gsize) + (ymax*0.25), 2,1,11
 CIRCLE (XX2*gsize) + (xmax/2),(ZZ2*gsize)+(ymax*0.25), 2,1, 15
 J=1
FOR I = 1 TO NS(J)
  XP = (Xs(J,I) - XC): YP = (Ys(J,I) - YC): ZP = (Zs(J,I) - ZC)
  PSET (XP*gsize) + (xmax/2), (YP*gsize) + (ymax*0.75), 11
  PSET (XP*gsize) + (xmax/2),(ZP*gsize) + (ymax*0.25), 11
NEXT I
 J=2
FOR I = 1 TO NS(J)
 XP = (Xs(J,I) - XC): YP = (Ys(J,I) - YC): ZP = (Zs(J,I) - ZC)
  PSET (XP*gsize) + (xmax/2), (YP*gsize) + (ymax*0.75), 15
 ''; stars of target galaxy on X-Z view
   PSET (XP*gsize) + (xmax/2),(ZP*gsize) + (ymax*0.25), 15
NEXT I
 end sub

'
