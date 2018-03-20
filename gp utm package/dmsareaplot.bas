
'#sec:Main
CONST pausing = 1
CONST plotsize = 135 + 5 * (NOT pausing)
REPEAT
  INPUT "Dataset";ds$
  IF LEN(ds$) = 0 THEN
    EXIT LOOP
  ENDIF
  IF EXIST(ds$) THEN
    fh = FREEFILE
    OPEN ds$ FOR INPUT AS #fh
    INPUT #fh;t,type
    ERASE n,e,b$,l
    DIM n(0 TO t)
    DIM e(0 TO t)
    DIM b$(0 TO t)
    DIM l(0 TO t)
    n(t) = 0
    e(t) = 0
    INPUT "" + type + " - confirm";type
    closed = LCASE(LEFT(type,1))="c"
    err = 0
    FOR i = 0 TO t - 1
      INPUT #fh;cn,b1$,dg, mn, sc,b2$, h
      IF cn <1 OR cn > t THEN
        PRINT "Erroneous course nbr - ";cn
        err = 1
        EXIT FOR
      ENDIF
      IF UCASE(b1$) = "N" THEN
        ns = 1
      ELSEIF UCASE(b1$) = "S" THEN
        ns = -1
      ELSE
        PRINT "Course ";cn;" dir err - ";b1$
        err = 1
        EXIT FOR
      ENDIF
      IF UCASE(b2$) = "E" THEN
        es = 1
      ELSEIF UCASE(b2$) = "W" THEN
        es = -1
      ELSE
        PRINT "Course ";cn;" dir err - ";b2$
        err = 1
        EXIT FOR
      ENDIF
      th = RAD(dg + mn / 60 + sc / 3600)
      b$(cn - 1) = brng$(ns,DEG(th),es)
      l(cn - 1) = h
      n(cn - 1) = ns * COS(th) * h
      n(t) = n(t) - n(cn - 1)
      e(cn - 1) = es * SIN(th) * h
      e(t) = e(t) - e(cn - 1)
    NEXT
    CLOSE #fh
    IF NOT err THEN
      IF ROUND(n(t),2) = 0 AND ROUND(e(t),2) = 0 THEN
        ec = -1
        closed = 1
      ELSE
        IF closed THEN
          PRINT "Error of Closure/Missing Course"
          b$(t) = brng$(SGN(n(t)), DEG(ATAN2(ABS(e(t)),ABS(n(t)))), SGN(e(t)))
          l(t) = SQR(n(t) ^ 2 + e(t) ^ 2)
          PRINT b$(t);" ";ROUND(l(t),5)
          PRINT "Dep (x) ";ROUND(e(t),5);", Lat (y) ";ROUND(n(t),5)
          PAUSE
        ENDIF
        ec = t
        t = t + 1
      ENDIF
      CLS
      min1 = n(0)
      max1 = n(0)
      min2 = e(0)
      max2 = e(0)
      FOR i = 1 TO t - 1
        n(i) = n(i) + n(i - 1)
        e(i) = e(i) + e(i - 1)
        min1 = MIN(min1, n(i))
        max1 = MAX(max1, n(i))
        min2 = MIN(min2, e(i))
        max2 = MAX(max2, e(i))
      NEXT
      rng = plotsize / MAX(max1 - min1, max2 - min2)
      nd = min1 + (max1 - min1) / 2
      ed = min2 + (max2 - min2) / 2
      NORTHPT 79,72
      IF pausing
        LOCATE 1,1
        PRINT "Course"
      ENDIF
      a = 0
      FOR i = 0 TO t - 2 + closed
        j = (i - 1 + t) MOD t
        IF pausing
          LOCATE 1,7
          PRINT CHR(27)+MID("[0m[4m",3 * (i = ec) + 1,3);i + 1;CHR(27)+"[0m";"  ";b$(i);"  ";ROUND(l(i),2);CHR(27)+"[K";
        ENDIF
        a = a + (e(i) * n(j) - e(j) * n(i))
        p = p + l(i)
        LINE 79 + (e(i) - ed) * rng, 79 - (n(i) - nd) * rng, 79 + (e(j) - ed) * rng, 79 - (n(j) - nd) * rng COLOR 7 * (i = ec)
        IF pausing
          PAUSE 1
        ENDIF
      NEXT
      AT 0,160 - TXTH("A")
      IF closed then
       PRINT "P = ";ROUND(p,2);"  A = "; ROUND(ABS(a / 2),2);
      ELSE
        PRINT "D = ";ROUND(p,2);
      ENDIF
      PAUSE
      CLS
    ENDIF
  ELSE
    PRINT "No such file"
  ENDIF
UNTIL 0
END

FUNC brng$(qn,dmsv,qe)
LOCAL dms
DIM dms(0 TO 4)
dms(0) = MID("SNN",qn + 2,1)
dms(2) = ROUND(dmsv * 3600)
dms(1) = dms(2) \\ 3600
dms(3) = dms(2) MOD 60
dms(2) = (dms(2) \\ 60) MOD 60
dms(4) = MID("WEE",qe + 2,1)
brng$ = dms(0) + " " + STR(dms(1)) + "°" + STR(dms(2)) + "''" + STR(dms(3)) + CHR(34) + " " + dms(4)
END

#inc:"LIB$North.bas"
'
