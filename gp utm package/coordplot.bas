
'#sec:Main
t9 = 500
bf = 1
IF bf = 1 THEN
  fh = FREEFILE
  REPEAT
    PRINT "Dataset? ";
    LINEINPUT fn
  UNTIL EXIST(fn)
  OPEN fn FOR INPUT AS #fh
ENDIF
DIM x(0 TO t9)
DIM y(0 TO t9)
DIM s(0 TO t9)
WHILE 1
  FOR t = 0 TO t9
    IF bf THEN
      IF EOF(fh) THEN
        CLOSE #fh
        bf = 0
        EXIT FOR
      ENDIF
      INPUT #fh,xt,yt
      x(t) = VAL(xt)
      y(t) = VAL(yt)
    ELSE
      PRINT "Next x,y ? ";
      LINEINPUT in$
      SPLIT in$,",",coords
      IF LEN(coords) = 0 THEN
        IF t > 0 THEN
          EXIT FOR
        ELSE
          EXIT LOOP
        ENDIF
      ELSEIF UBOUND(coords) > 0
        x(t) = VAL(coords(0))
        y(t) = VAL(coords(1))
      ELSE
        PRINT "Error - reenter"
        t = t - 1
      ENDIF
    ENDIF
  NEXT
  mode = "plot"
  WHILE t > 0
    IF t = 1 THEN
      m = x(0)
      b = y(0)
      IF m <> 0 THEN
        PRINT "&#65533;(x) = ";
        IF m = -1 THEN
          PRINT "-";
        ELSEIF m <> 1 THEN
          PRINT ROUND(m,2);
        ENDIF
        PRINT "x";
        IF b <> 0 THEN
          PRINT MID(" - + ",2 + SGN(b),3);ROUND(ABS(b),2);
        ENDIF
        PRINT
      ELSE
        PRINT "y = ";ROUND(b,2); "  (Not a function)"
        EXIT LOOP
      ENDIF
      IF b = 0 THEN
        IF ABS(m) < 1 THEN
          x(0) = -3 * SGN(m)
          y(0) = x(0) * m
          x(1) = 3 * SGN(m)
          y(1) = x(1) * m
        ELSE
          y(0) = -3 * SGN(m)
          x(0) = y(0) / m
          y(1) = 3 * SGN(m)
          x(1) = y(1) / m
        ENDIF
      ELSE
        logs = ALOG(ABS(b))
        IF ABS(m) < 1 THEN
          x(0) = -b / m - SGN(m) * SGN(b) * 10 ^ logs
          y(0) = m * x(0) + b
          x(1) = -SGN(-b / m)
          y(1) = m * x(1) + b
        ELSE
          y(0) = b + SGN(b) * 10 ^ logs
          x(0) = (y(0) - b) / m
          y(1) = -SGN(b)
          x(1) = (y(1) - b) / m
        ENDIF
      ENDIF
      t = 2
      mode = "mxb"
    ELSE
      PRINT t;" points"
    ENDIF
    area = 0
    cx = 0
    cy = 0
    perim = 0
    INPUT "Force origin? (Yn) ",in$
    fo = LCASE(LEFT(in$,1)) <> "n"
    IF  fo THEN
      x0 = 0
      x1 = 0
      y0 = 0
      y1 = 0
    ELSE
      x0 = x(0)
      x1 = x(0)
      y0 = y(0)
      y1 = y(0)
    ENDIF
    INPUT "Show (p)ts, (A)rea/len/eq, (b)oth? ",in$
    show = (LCASE(LEFT(in$,1)) = "p") + 2 * (LCASE(LEFT(in$,1)) = "a" OR in$ = 0) + 3 * (LCASE(LEFT(in$,1)) = "b")
    FOR i = 0 TO t - 1
      j = (i + 1) MOD t
      ai = x(i) * y(j) - x(j) * y(i)
      cx = cx + (x(i) + x(j)) * ai
      cy = cy + (y(i) + y(j)) * ai
      area = area + ai
      s(i) = SQR((x(i) - x(j)) ^ 2 + (y(i) - y(j)) ^ 2)
      perim = perim + s(i)
      x0 = MIN(x0,x(i))
      x1 = MAX(x1,x(i))
      y0 = MIN(y0,y(i))
      y1 = MAX(y1,y(i))
    NEXT
    IF area <> 0 THEN
      cx = cx / (3 * area)
      cy = cy / (3 * area)
    ENDIF
    CLS
    logs = ALOG(MAX(x1 - x0, y1 - y0))
    scale = 10 ^ logs
    x0 = SFLOOR(x0)
    x1 = SCEIL(x1)
    y0 = SFLOOR(y0)
    y1 = SCEIL(y1)
    tix = MIN(MAX(INT(160 * scale / (MAX(x1 - x0, y1 - y0) + 2 * scale)), 8),64)
    tix = tix - tix MOD 4
    xo = (x1 + x0) / 2
    IF cx < xo THEN
      xo = SFLOOR(xo)
    ELSE
      xo = SCEIL(xo)
    ENDIF
    yo = (y1 + y0) / 2
    IF cy < yo THEN
      yo = SFLOOR(yo)
    ELSE
      yo = SCEIL(yo)
    ENDIF
    FOR i = 159 - 80 MOD tix TO 0 STEP -tix
      LINE i, 0, i, 159 COLOR 13
      LINE 0, i, 159, i COLOR 13
    NEXT
    IF NOT (PX(0) < 0 OR PX(0) > 159)THEN
      LINE PX(0), 0, PX(0), 159 COLOR 7
    ENDIF
    IF NOT (PY(0) < 0 OR PY(0) > 159) THEN
      LINE 0, PY(0), 159, PY(0) COLOR 7
    ENDIF
    FOR i = 0 TO t - 1
      j = (i + 1) MOD t
      LINE PX(x(i)), PY(y(i)),PX(x(j)), PY(y(j))
    NEXT
    AT 0,160 - TXTH("A")
    PRINT "Scale = ";scale;
    IF show \\ 2 THEN
      PAUSE
      IF area <> 0 THEN
        CIRCLE PX(cx), PY(cy), 2
        PSET PX(cx), PY(cy)
        AT 0,0
        PRINT "A = "; ROUND(ABS(area) / 2,2);
        AT 82,0 
        PRINT "C = (";ROUND(cx,2);",";ROUND(cy,2);")";
        AT 0,160 - 2 * TXTH("A")
        PRINT "P = "; ROUND(perim,2)
      ELSE
        IF mode = "plot" THEN
          AT 0,160 - 2 * TXTH("A")
          PRINT "L = "; ROUND(perim / 2, 2); 
          IF x(0) = x(1) THEN
            m = 1E98
          ELSE
            m = (y(1) - y(0)) / (x(1) - X(0))
          ENDIF
          b = y(1) - m * x(1)
        ENDIF
        AT 0,0
        IF m <> 0 THEN
          PRINT "&#65533;(x) = ";
          IF m = -1 THEN
            PRINT "-";
          ELSEIF m <> 1 THEN
            PRINT ROUND(m,2);
          ENDIF
          PRINT "x";
          IF b <> 0 THEN
            PRINT MID(" - + ",2 + SGN(b),3);ROUND(ABS(b),2);
          ENDIF
        ELSE
          PRINT "y = ";ROUND(b,2);"  (Not a function)";
        ENDIF
      ENDIF
    ENDIF
    IF show MOD 2 THEN
      PAUSE
      CLS
      FOR i = 0 TO t - 1
        PRINT "p"; i + 1; " = ("; ROUND(x(i),2); ","; ROUND(y(i),2); ")  d = ";ROUND(s(i),2)
        IF (i MOD 12) = 11 THEN
          PAUSE
          CLS
        ENDIF   
      NEXT
    ENDIF
    AT 76,160 - TXTH("A")
    INPUT "Replot data? (Yn) ",in$
    IF LCASE(LEFT(in$,1)) = "n" THEN
      t = 0
    ENDIF
    CLS
  WEND
WEND
END

FUNC ALOG(x)
  LOCAL y
  y = LOG10(x)
  IF y = INT(y) THEN
        y = y - (y > 0)
      ELSE
        y = FLOOR(y)
      ENDIF
  ALOG = y
END

FUNC PX(x)
  PX = ROUND(79 + (x - xo) * tix / scale)
END

FUNC PY(y)
  PY = ROUND(79 - (y - yo) * tix / scale)
END

FUNC SFLOOR(x)
  LOCAL s
  IF x < 0 THEN
    SFLOOR = -SCEIL(-x)
  ELSE
    IF scale = 1 THEN
      s = x
    ELSE
      s = ROUND(x / scale, ABS(logs))
    ENDIF
    SFLOOR = INT(s) * scale
  ENDIF
END

FUNC SCEIL(x)
  LOCAL s
  IF x < 0 THEN
    SCEIL = -SFLOOR(-x)
  ELSE
    IF scale = 1 THEN
      s = x
    ELSE
      s = ROUND(x / scale, ABS(logs))
    ENDIF
    SCEIL = FIX(s) * scale
  ENDIF
END
'
