
''' evDemo.bas
'' 20/05/2001
LABEL Main
d = 50
t = .7  : td = 0
p = 2.3 : pd = 0
c = 0   : cd = 1
tw = TXTW("#")
th = TXTH("#")
GOSUB sysEventLoop
END



LABEL sysEventLoop
GOSUB sysInit

evPaint$    = 1
evExit$     = 0
evPen$      = 0
evPenX$     = 0
evPenY$     = 0
evKey$      = 0
evKeyTmp$   = 0
evKeyExt$   = 0
evKeyCode$  = 0
evTimer$    = 1
evTimerTmp$ = TIMER
evTick$     = 1
evTickStep$ = TICKSPERSEC / 4
evTickTmp$  = TICKS + evTickStep$
PEN ON
REPEAT

 IF PEN(0)
  evPen$  = 1
  evPenX$ = PEN(4)
  evPenY$ = PEN(5)
  evX$    = evPenX$
  evY$    = evPenY$
 ENDIF

 evKeyTmp$ = INKEY
 evKey$    = LEN(evKeyTmp$)
 IF evKey$
  IF evKey$ = 2
   evKeyExt$  = 1
   evKeyCode$ = RIGHT(evKeyTmp$, 1)
  ELSE
   evKeyExt$  = 0
   evKeyCode$ = evKeyTmp$
  ENDIF
 ENDIF

 IF evTimerTmp$ <> TIMER
  evTimer$    = 1
  evTimerTmp$ = TIMER
 ENDIF

 IF TICKS >= evTickTmp$
  evTick$    = 1
  evTickTmp$ = evTickTmp$ + evTickStep$
 ENDIF

 IF evPen$
  GOSUB sysPen : evPen$ = 0
 ENDIF

 IF evKey$
  IF NOT evKeyExt$
   GOSUB sysKey
  ELSE
   GOSUB sysKeyExt
  ENDIF
  evKey$ = 0
 ENDIF

 IF evTimer$
  GOSUB sysTimer : evTimer$ = 0
 ENDIF


 IF evTick$
  GOSUB sysTick : evTick$ = 0
 ENDIF

 IF evPaint$
  GOSUB sysPaint : evPaint$ = 0
 ENDIF

 IF evExit$
  GOSUB sysExit
 ENDIF

UNTIL evExit$
RETURN



LABEL sysInit
XMIN$ = 2
YMIN$ = 6 + th
XMAX$ = XMAX - 2
YMAX$ = YMAX - 2
XC$   = (XMIN$ + XMAX$) / 2
YC$   = (YMIN$ + YMAX$) / 2
GOSUB usrInit
RETURN



LABEL sysPen
dPx1 = XMAX - 3 - tw : dPy1 = 2
dPx2 = XMAX - 3      : dPy2 = 2 + th
IF (evPenX$ >= dPx1) AND (evPenX$ < dPx2) AND (evPenY$ >= dPy1) AND (evPenY$ < dPy2)
 evExit$ = 1
ELIF (evPenX$ >= XMIN$) AND (evPenX$ < XMAX$) AND (evPenY$ >= YMIN$) AND (evPenY$ < YMAX$)
 GOSUB usrPen
ENDIF
RETURN



LABEL sysKey
GOSUB usrKey
RETURN



LABEL sysKeyExt
evKeyTmp$ = ASC(evKeyCode$)
IF evKeyTmp$ = 1
 GOSUB usrKeyUp
ELIF evKeyTmp$ = 2
 GOSUB usrKeyDown
ELIF evKeyTmp$ = 3
 GOSUB usrKeyDateBook
ELIF evKeyTmp$ = 4
 GOSUB usrKeyAddress
ELIF evKeyTmp$ = 5
 GOSUB usrKeyToDoList
ELIF evKeyTmp$ = 6
 GOSUB usrKeyMemoPad
ELSE
 GOSUB usrKeyExt
ENDIF
RETURN



LABEL sysTimer
GOSUB usrTimer
RETURN



LABEL sysTick
GOSUB usrTick
RETURN



LABEL sysPaint
dPx1 = 0        : dPy1 = 0
dPx2 = XMAX - 1 : dPy2 = YMAX - 1
RECT dPx1, dPy1, dPx2, dPy2
dPx1 = XMAX - 3 - tw : dPy1 = 2
dPx2 = XMAX - 3      : dPy2 = 2 + th
LINE dPx1, dPy1, dPx2, dPy2
LINE dPx1 + 1, dPy1, dPx2, dPy2 - 1
LINE dPx2, dPy1, dPx1, dPy2
LINE dPx2 - 1, dPy1, dPx1, dPy2 - 1
dPx1 = 0        : dPy1 = 4 + th
dPx2 = XMAX - 1 : dPy2 = 4 + th
LINE dPx1, dPy1, dPx2, dPy2
GOSUB usrPaint
RETURN



LABEL sysExit
GOSUB usrExit
RETURN



LABEL usrInit
XMIN1$ = XMIN$ : YMIN1$ = YMIN$
XMAX1$ = XC$   : YMAX1$ = YC$
XC1$   = (XMIN1$ + XMAX1$) / 2
YC1$   = (YMIN1$ + YMAX1$) / 2

XMIN2$ = XC$   : YMIN2$ = YMIN$
XMAX2$ = XMAX$ : YMAX2$ = YC$
XC2$   = (XMIN2$ + XMAX2$) / 2
YC2$   = (YMIN2$ + YMAX2$) / 2

XMIN3$ = XMIN$ : YMIN3$ = YC$
XMAX3$ = XC$   : YMAX3$ = YMAX$
XC3$   = (XMIN3$ + XMAX3$) / 2
YC3$   = (YMIN3$ + YMAX3$) / 2

XMIN4$ = XC$   : YMIN4$ = YC$
XMAX4$ = XMAX$ : YMAX4$ = YMAX$
XC4$   = (XMIN4$ + XMAX4$) / 2
YC4$   = (YMIN4$ + YMAX4$) / 2

kX = XMIN4$ : kY = YMIN4$
pX = 0      : pY = 0
r  = (YMAX3$ - YMIN3$ - 5) / 2
rh = r / 2.2
rm = r / 1.6
rs = r / 1.2
RETURN



LABEL usrPaint
CIRCLE XC3$, XC4$, r COLOR 0
RETURN



LABEL usrKeyUp
pd = pd - .1
RETURN



LABEL usrKeyDown
pd = pd + .1
RETURN



LABEL usrKeyDateBook
pd = 0
td = 0
RETURN



LABEL usrKeyAddress
td = td + .1
RETURN



LABEL usrKeyToDoList
td = td - .1
RETURN



LABEL usrKeyMemoPad
RETURN



LABEL usrKeyExt
RETURN



LABEL usrPen
IF NOT ((evPenX$ > XMIN1$) AND (evPenX$ <= XMAX1$) AND (evPenY$ > YMIN1$) AND (evPenY$ <= YMAX1$))
 RETURN
ENDIF

IF (pX = 0) AND (pY = 0)
 PSET evPenX$, evPenY$ COLOR 0
ELSE
 LINE pX, pY, evPenX$, evPenY$ COLOR 0
ENDIF
pX = evPenX$ : pY = evPenY$
RETURN



LABEL usrKey
IF kX + TXTW(evKeyCode$) > XMAX4$
 kX = XMIN4$
 IF kY + TXTH(evKeyCode$) > YMAX4$
  kY = YMIN4$
  RECT XMIN4$, YMIN4$, XMAX4$, YMAX4$ COLOR 15 FILLED
 ELSE
  kY = kY + TXTH(evKeyCode$)
 ENDIF
ENDIF
AT kX, kY : PRINT evKeyCode$;
kX = kX + TXTW(evKeyCode$)
RETURN



LABEL usrTimer
T$ = TIME$
D$ = DATE$
AT 2, 2 : PRINT D$; " "; T$;

LINE XC3$, YC3$, XC3$ + xs, YC3$ + ys COLOR 15
s  = VAL(RIGHT$(T$, 2))
xs = rs * COS(PI * (s / 30 - 0.5))
ys = rs * SIN(PI * (s / 30 - 0.5))
LINE XC3$, YC3$, XC3$ + xs, YC3$ + ys COLOR 0

LINE XC3$, YC3$, XC3$ + xm, YC3$ + ym COLOR 15
m  = VAL(MID$(T$, 4, 2))
xm = rm * COS(PI * (m / 30 - 0.5))
ym = rm * SIN(PI * (m / 30 - 0.5))
LINE XC3$, YC3$, XC3$ + xm, YC3$ + ym COLOR 0

LINE XC3$, YC3$, XC3$ + xh, YC3$ + yh COLOR 15
h  = VAL(LEFT$(T$, 2)) % 12
xh = rh * COS(PI * (h / 6 - 0.5))
yh = rh * SIN(PI * (h / 6 - 0.5))
LINE XC3$, YC3$, XC3$ + xh, YC3$ + yh COLOR 0

RETURN



LABEL usrTick
t = t + td
p = p + pd
c = c + cd
IF (c >15) OR (c < 0)
 cd = -cd
 c  = c + cd + cd
ENDIF
GOSUB DrawCube
RETURN



LABEL usrExit
CLS
RETURN



LABEL DrawCube
st = SIN(t) : ct = COS(t)
sp = SIN(p) : cp = COS(p)
RESTORE DrawCubeData
FOR f = 1 TO 4
 READ m3t2x, m3t2y, m3t2z
 GOSUB Map3DTo2D
 PSET sx,sy COLOR c
 FOR e = 1 TO 3
  READ m3t2x, m3t2y, m3t2z
  GOSUB Map3DTo2D
  LINE sx,sy COLOR c
 NEXT e
NEXT f
RETURN



LABEL Map3DTo2D
xe = -m3t2x * st + m3t2y * ct
ye = -m3t2x * ct * cp - m3t2y * st * cp + m3t2z * sp
ze = -m3t2x * sp * ct - m3t2y * st * sp - m3t2z * cp + 4
sx = d * xe / ze + XC2$
sy = d * ye / ze + YC2$
RETURN



LABEL DrawCubeData
DATA -1,-1,-1
DATA  1,-1,-1
DATA  1, 1,-1
DATA -1, 1,-1

DATA -1,-1, 1
DATA -1,-1,-1
DATA -1, 1,-1
DATA -1, 1, 1

DATA  1,-1, 1
DATA -1,-1, 1
DATA -1, 1, 1
DATA  1, 1, 1

DATA  1,-1,-1
DATA  1,-1, 1
DATA  1, 1, 1
DATA  1, 1,-1'
