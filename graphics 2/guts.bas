
'Guts.bas SmallBASIC 0.12.0 2015-11-17 MGA/B+ 
'modified  > GUTS
REM Original ARM BBC BASIC version by Jan Vibe
'800x600

DIM bX(15),bY(15),bZ(15),COLR(15)
bX(1) = -100 : A = 0
FOR N = 1 TO 15
  COLR(16-N)=rgb(7*N+150,14*N+45,14*N+45)
NEXT

X1 = RND*XMAX : Y1 = RND*YMAX : DX1 = (RND*16+1)*(RND-.5) : DY1 = (RND*16+1)*(RND-.5)
X2 = RND*XMAX : Y2 = RND*YMAX : DX2 = (RND*16+1)*(RND-.5) : DY2 = (RND*16+1)*(RND-.5)

while 1
  H = X1+DX1 : IF H< 0 OR H> xmax THEN DX1 = (RND*16+1)*-SGN(DX1)
  H = Y1+DY1 : IF H< 0 OR H> ymax THEN DY1 = (RND*16+1)*-SGN(DY1)
  X1 += DX1  : Y1 += DY1
  IF X2< X1 AND  DX2< 24 THEN DX2 += 1
  IF X2> X1 AND DX2> -24 THEN DX2 -= 1
  IF Y2< Y1 AND  DY2< 24 THEN DY2 += 1
  IF Y2> Y1 AND DY2> -24 THEN DY2 -= 1
  X2 += DX2 : Y2 += DY2 : A = (A+10) MOD 360 : Z = (SIN(RAD(A))+1)+2
  FOR N = 2 TO 15
    bX(N-1) = bX(N) : bY(N-1) = bY(N) : bZ(N-1) = bZ(N)
  NEXT
  bX(15) = X2 : bY(15) = Y2 : bZ(15) = Z
  FOR N = 1 TO 15 : CIRCLE bX(N),bY(N),N*bZ(N),1,COLR(N) FILLED : NEXT
  showpage
  delay 10
wend
