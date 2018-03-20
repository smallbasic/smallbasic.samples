
'#sec:Main
10 DIM x(1000)
11 DIM y(1000)
12 DIM z(1000)
20 d = 150: t = .7: p = 2
22 poc = 1: PEN ON
24 po = 1: drau = 0: modo = 0
25 CY = 0: CX = 0: CZ = 0
60 GOSUB 100: GOTO 500

100 CLS : GOSUB 851: GOSUB 200: RETURN

150 REM calcula y dibuja un punto
152 xe = -px * st + py * ct
154 ye = -px * ct * cp - py * st * cp + pz * sp
156 ze = -px * sp * ct - py * st * sp - pz * cp + 4
158 sx = d * xe / ze + 80
160 sy = d * ye / ze + 80
161 pset sx,sy
162 RETURN

200 REM redibuja
202 st = SIN(t): ct = COS(t)
204 sp = SIN(p): cp = COS(p)
210 FOR i = 1 TO po
220 px = x(i) / 10: py = y(i) / 10: pz = z(i) / 10
230 GOSUB 150
240 NEXT i
250 RETURN

430 INPUT "cuantos valores desea BorRAR? ?"; BO
435 po = po - BO
440 GOSUB 100: GOTO 500

500 a$ = INKEY$: GOSUB 1200: IF a$ = "" AND pecom = 0 THEN GOTO 500
501 a = ASC(a$): IF pecom <> 0 THEN GOTO 532
502 IF a$ = "s" THEN GOSUB 1400: GOSUB 851: REM modo ver o dibujar
503 IF a$ = "k" THEN GOSUB 1000: REM graba data
504 IF a$ = "o" THEN GOSUB 1100: REM lee data
505 IF a$ = "a" THEN GOSUB 2600: REM angulo hor
506 IF a$ = "b" THEN GOSUB 2700: REM angulo ver
507 IF a$ = "e" THEN GOSUB 1500: REM esfera
508 IF a$ = "l" THEN GOSUB 1600: REM linea
509 IF a$ = "c" THEN GOSUB 1800: REM circulo
512 IF a$ = "m" THEN GOSUB 2400: REM mover
513 IF a$ = "f" THEN GOSUB 2500: REM grafica funcion
514 IF a$ = "z" THEN GOSUB 2800: REM zoom
519 IF a$ = "h" THEN GOSUB 5000: GOSUB 851: GOTO 500: REM home
521 IF a$ = "u" THEN CLS : GOSUB 100: REM redraw
522 IF a$ = "l" THEN po = 1: GOTO 20: REM borrar puntos
524 IF a$ = "g" THEN CX = 0: CY = 0: CZ = 0: GOSUB 851: GOTO 500: REM cero
526 IF a$ = "p" THEN CLS : GOTO 430: REM borrar puntos
528 IF ((drau = 0) AND (a$ = "i")) THEN drau = 1: GOSUB 851
530 IF ((drau = 1) AND (a$ = "i")) THEN drau = 0: GOSUB 851
532 IF modo = 1 AND pecom = 1 THEN CZ = CZ - 1: GOSUB 610
534 IF modo = 1 AND pecom = 9 THEN CZ = CZ + 1: GOSUB 610
536 IF modo = 1 AND pecom = 4 THEN CY = CY - 1: GOSUB 610
538 IF modo = 1 AND pecom = 6 THEN CY = CY + 1: GOSUB 610
540 IF modo = 1 AND pecom = 3 THEN CX = CX - 1: GOSUB 610
542 IF modo = 1 AND pecom = 7 THEN CX = CX + 1: GOSUB 610
543 IF pecom = 2 THEN d = d + 10: GOSUB 100
544 IF pecom = 8 THEN d = d - 10: GOSUB 100
545 IF modo = 0 AND pecom = 4 THEN t = t - .1: GOSUB 100
546 IF modo = 0 AND pecom = 6 THEN t = t + .1: GOSUB 100
547 IF modo = 0 AND pecom = 1 THEN p = p + .1:  GOSUB 100
548 IF modo = 0 AND pecom = 9 THEN p = p - .1:  GOSUB 100
599 GOTO 500
610 IF drau = 1 THEN GOSUB 700
605 IF drau = 0 THEN GOSUB 750
620 RETURN


700 x(po) = CX: y(po) = CY
705 z(po) = CZ
710 po = po + 1: i = 1: x(i) = CX
715 y(i) = CY: z(i) = CZ
720 px = CX / 10: py = CY / 10: pz = CZ / 10: GOSUB 150
725 GOSUB 851
730 RETURN

750 px = CX / 10: py = CY / 10: pz = CZ / 10: COLOR 9: GOSUB 150: COLOR 15: GOSUB 150
760 COLOR 0: GOSUB 851
770 RETURN

851 at 0, 0: a$ = "Dibujo Tridimensional": COLOR 9
852 PRINT a$: COLOR 10
857 a$ = "MOD=" + STR$(modo) + "  "
858 a$ = a$ + "PNTR="
859 a$ = a$ + STR$(po) + "     "
860 PRINT a$: COLOR 12
861 a$ = "STAT: cx=" + STR$(CX)
862 a$ = a$ + " cy=" + STR$(CY)
863 a$ = a$ + " cz=" + STR$(CZ) + "    "
864 PRINT a$: COLOR 13
865 a$ = "Draw="
866 IF (drau = 1) THEN a$ = a$ + "ON "
867 IF (drau = 0) THEN a$ = a$ + "OFF"
876 PRINT a$: COLOR 0
880 RETURN
910 IF ((vx = 0) AND (vy = 0) AND (vz = 0)) THEN GOTO 930
920 RETURN
930 vx = OVX: vy = OVY: vz = OVZ
940 RETURN

1000 REM graba en disco
1001 INPUT "Nombre del archivo a grabar? "; ar$: ar$ = ar$ + ".dat"
1010 OPEN ar$ FOR OUTPUT AS #1
1020 FOR i = 1 TO po
1030 PRINT #1, x(i)
1040 PRINT #1, y(i)
1050 PRINT #1, z(i)
1060 NEXT i
1065 CLOSE #1
1066 GOSUB 100
1070 RETURN

1100 REM lee del disco
1101 INPUT "Nombre del archivo a leer? "; ar$: ar$ = ar$ + ".dat"
1110 OPEN ar$ FOR INPUT AS #1: po = 1
1130 INPUT #1, x(po)
1140 INPUT #1, y(po)
1150 INPUT #1, z(po): po = po + 1
1160 IF NOT EOF(1) THEN 1130
1165 CLOSE #1
1166 GOSUB 100
1170 RETURN

1200 REM deteccion de pen
1210 IF PEN(0) THEN 1230
1220 pecom = 0: RETURN
1230 px = PEN(4): py = PEN(5)
1270 IF px < 50 THEN pecom = 1: GOTO 1300
1280 IF px < 110 THEN pecom = 2: GOTO 1300
1290 pecom = 3
1300 IF py < 50 THEN GOTO 1330
1310 IF py < 110 THEN pecom = pecom + 3: GOTO 1330
1320 pecom = pecom + 6
1330 RETURN

1400 REM modo ver o dibujar
1410 IF modo = 0 THEN modo = 1: RETURN
1420 IF modo = 1 THEN modo = 0
1430 RETURN

1500 REM ESFERA
1501 CLS
1502 INPUT "radio=(10)? "; RA
1503 IF (RA = 0) THEN RA = 10
1504 INPUT "<z desde (0)? "; PHIA
1506 INPUT "<z hasta (360)? "; PHIB
1507 IF (PHIB = 0) THEN PHIB = 360
1508 INPUT "<x desde (0)? "; TETA
1510 INPUT "<x hasta (360)? "; TETB: IF (TETA = 0) THEN LET TETA = 1
1511 IF (PHIA = 0) THEN PHIA = 1
1512 IF (TETB = 0) THEN TETB = 360
1513 TETA = TETA / 57.32
1514 TETB = TETB / 57.32
1516 PHIA = PHIA / 57.32
1518 PHIB = PHIB / 57.32
1520 SI = 1 / (RA * 6.28)
1522 IF (PHIA > 6.28) THEN PHIA = 6.28
1524 IF (TETA > 6.28) THEN TETA = 6.28
1526 FOR i = PHIA TO PHIB STEP SI
1528 sja = RA * SIN(90) * SIN(i)
1530 SJ = (1 * TETB) / (sja * 6.28)
1532 FOR J = TETA TO TETB STEP SJ
1540 x(po) = RA * COS(J) * SIN(i)
1542 y(po) = RA * SIN(J) * SIN(i)
1544 z(po) = RA * COS(i)
1546 x(i) = x(i) + CX
1548 y(i) = y(i) + CY: z(i) = z(i) + CZ
1550 po = po + 1
1560 NEXT J: NEXT i
1575 GOSUB 100
1580 RETURN

1600 REM LINEA
1601 CLS
1602 INPUT "origen x=? "; OX
1604 INPUT "origen y=? "; OY
1610 INPUT "origen z=? "; OZ
1620 INPUT "destino x=? "; DX
1625 INPUT "destino y=? "; DY
1630 INPUT "destino z=? "; DZ
1635 GOSUB 1700
1650 FOR i = 0 TO 10 STEP (10 / t)
1660 x(po) = OX + i * ((DX - OX) / 10)
1662 y(po) = OY + i * ((DY - OY) / 10)
1663 z(po) = OZ + i * ((DZ - OZ) / 10)
1664 po = po + 1
1670 NEXT i
1675 IF AU = 1 THEN RETURN
1684 GOSUB 100
1690 RETURN

1700 REM USADO X LINEA
1701 ta = ((DX - OX) ^ 2)
1702 tb = ((DY - OY) ^ 2)
1704 tc = ((DZ - OZ) ^ 2)
1706 t = SQR(ta + tb + tc)
1720 RETURN

1800 REM CIRCULO
1810 INPUT "radio (10)? "; RA
1813 IF (RA = 0) THEN RA = 10
1814 INPUT "<x desde=(0)? "; TETA
1820 INPUT "<x hasta=(360)? "; TETB
1821 IF TETB = 0 THEN TETB = 360
1822 INPUT "cantidad=(1)"; ZZ: ES = 1
1823 IF (ZZ = 0) THEN ZZ = 1
1824 IF (ZZ > 1) THEN INPUT "espaciadas en=(2)? "; ES
1825 IF ((ZZ > 1) AND (ES = 0)) THEN ES = 2
1830 INPUT "0=xy 1=xz 2=zy ? "; pl
1834 TETA = TETA / 57.32
1835 TETB = TETB / 57.32
1836 SI = 1 / (RA * 6.28)
1838 EZ = 0: ZZ = ZZ * ES
1840 FOR i = TETA TO TETB STEP SI
1850 a = RA * COS(i)
1852 B = RA * SIN(i): C = EZ
1860 IF (pl = 0) THEN GOTO 1900
1870 IF (pl= 1) THEN GOTO 1903
1880 IF (pl= 2) THEN GOTO 1906
1890 NEXT i
1892 EZ = EZ + ES
1893 IF (EZ < ZZ) THEN GOTO 1840
1895 GOSUB 100
1896 RETURN
1900 x(po) = a + CX: y(po) = B + CY
1901 z(po) = C + CZ
1902 po = po + 1: GOTO 1890
1903 x(po) = a + CZ
1904 z(po) = B + CZ: y(po) = C + CZ
1905 po = po + 1: GOTO 1890
1906 z(po) = a + CZ
1907 y(po) = B + CY: x(po) = C + CX
1908 po = po + 1: GOTO 1890

2400 REM mover dibujo todo
2405 CLS
2410 INPUT "Eje ? "; e$
2420 INPUT "valor=? "; VA
2430 FOR i = 1 TO po - 1
2440 IF (e$ = "x") THEN x(i) = x(i) + VA
2450 IF (e$ = "y") THEN y(i) = y(i) + VA
2460 IF (e$ = "z") THEN z(i) = z(i) + VA
2470 NEXT i
2480 GOSUB 100
2490 RETURN

2500 REM FUNCION
2505 po = 1: a = 1: B = 2: C = 2
2510 FOR x = -5 TO 5 STEP .2
2520 FOR y = -10 TO 10 STEP .2
2530 az = (x ^ 2) / (a ^ 2)
2532 bz = (y ^ 2) / (B ^ 2)
2534 z = (1 / C) * (az - bz)
2540 x(po) = x: y(po) = y
2542 z(po) = z: po = po + 1
2550 NEXT y: NEXT x
2560 GOSUB 100
2570 RETURN

2600 REM angulo hor t
2610 INPUT "Angulo hor? "; t
2620 t = t / 57.29
2630 GOSUB 100
2640 RETURN

2700 REM angulo ver p
2710 INPUT "Angulo ver? "; p
2720 p = p / 57.29
2730 GOSUB 100
2740 RETURN

2800 REM zoom
2810 INPUT "Ingrese zoom? ", d
2820 GOSUB 100
2830 RETURN

5000 PRINT : PRINT "Ayuda programa Tridim (jmv 25.08.2001)"
5010 PRINT "E=esfera L=linea C=circulo"
5015 PRINT "N=distancia de vista (valor xyz+/-) "
5020 PRINT "M=mover todo el dibujo F=grafica funcion "
5030 PRINT "S=Modo mover o dibuja"
5032 PRINT "A=angulo hor, B=angulo ver"
5036 PRINT "O=lee data K=graba data"
5035 PRINT "A=angulo de vision V=vantage "
5040 PRINT "U=redraw B=borrar H=home "
5050 PRINT "L=borrar puntos I=draw on/off"
5065 pause
5066 GOSUB 100
5100 RETURN


'
