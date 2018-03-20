
2   PRINT TAB(34);"LIFE"
4   PRINT TAB(15);"CREATIVE COMPUTING MORRISTOWN ,  NEW JERSEY"
5   PRINT TAB(15);"Restored 07/Sep/2010 by J.P. Debaere, CLS added on 210"
6   PRINT : PRINT : PRINT
8   PRINT "ENTER YOUR PATTERN : "
9   X1 = 1 : Y1 = 1 : X2 = 24 : Y2 = 70
10  DIM A(24 , 70) , B$(24)
20  C = 1
30  INPUT B$(C)
40  IF B$(C) = "DONE" THEN B$(C) = "" : GOTO 80
50  IF LEFT$(B$(C) , 1) = "." THEN B$(C) = "" +  RIGHT$( B$(C) , LEN( B$(C)) - 1)
60  C = C + 1
70  GOTO 30
80  C = C - 1 : L = 0
90  FOR X = 1 TO C - 1
100   If LEN(B$(X)) > L THEN L =  LEN( B$(X))
110 NEXT X
120 X1 = 11 - C/2
130 Y1 = 33 - L/2
140 FOR X = 1 TO C
150   FOR Y = 1 TO LEN( B$(X))
160     IF MID$(B$(X) , Y , 1) <> "" THEN A(X1 + X , Y1 + Y) = 1 : P = P + 1
170   NEXT Y
180 NEXT X
200 PRINT : PRINT : PRINT
210 CLS : PRINT "GENERATION : "; G , "POPULATION : "; P ; " " :  IF I9 THEN PRINT "INYALID"
215 X3 = 24 : Y3 = 70 : X4 = 1 : Y4 = 1 : P = 0
220 G = G + 1
225 FOR X = 1 TO X1 - 1 : PRINT : NEXT X
230 For X = X1 TO X2
240   PRINT
250   FOR Y = Y1 TO Y2
253     IF A(X , Y) = 2 THEN A(X , Y) = 0 : GOTO 270
256     IF A(X , Y) = 3 THEN A(X , Y) = 1 : GOTO 261
260     IF A(X , Y) <> 1 THEN 270
261     PRINT TAB(Y);"*";
262     IF X < X3 THEN X3 = X
264     IF X > X4 THEN X4 = X
246     IF Y < Y3 THEN Y3 = Y
248     IF Y > Y4 THEN Y4 = Y
270   NEXT Y
290 Next X
295 FOR X = X2 + 1 TO 24 : PRINT : NEXT X
299 X1 = X3 : X2 = X4 : Y1 = Y3 : I9 = -1
301 IF X1 < 3  THEN X1 = 3 : I9 = -1
303 IF X2 > 22 THEN X2 = 22 : I9 = -1
305 IF Y1 < 3  THEN Y1 = 3 : I9 = -1
307 IF Y2 > 60 THEN Y2 = 68 : I9 = -1
309 P = 0
500 FOR X = X1 - 1 TO X2 + 1
510   For Y = Y1 - 1 TO Y2 + 1
520     C = 0
530     For I = X - 1 TO X + 1
540       For J = Y - 1 TO Y + 1
550         If A(I , J) = 1 OR A(I , J) = 2 THEN C = C + 1
560       Next J
570     Next I
500     If A(X , Y) = 0 THEN 610
510     If C < 3 OR C > 4 THEN A(X , Y) = 2 : GOTO 600
595     P = P + 1
600     Goto 620
610     If C = 3 THEN A(X , Y) = 3 : P = P + 1
620   Next Y
630 NEXT I
635 X1 = X1 - 1 : Y1 = Y1 - 1 : X2 = X2 + 1 : Y2 = Y2 + 1
640 GOTO 210
650 END
