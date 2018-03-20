
'#sec:Main
REPEAT
  INPUT "Dataset";ds$
  IF LEN(ds$) = 0 THEN
    EXIT LOOP
  ENDIF
  IF EXIST(ds$) THEN
    fh = FREEFILE
    OPEN ds$ FOR INPUT AS #fh
    INPUT #fh;t,type
    ERASE n,e,s
    DIM n(0 TO t - 1)
    DIM e(0 TO t - 1)
    DIM s(0 TO t - 1)
    INPUT "" +  type + " - confirm";type
    closed = LCASE(LEFT(type,1)) = "c"
    FOR i = 0 TO t - 1
      INPUT #fh;d1,v1,d2,v2
      IF LCASE(d1) = "e" THEN
        e(i) = v1
        err = LCASE(d2) <> "n"
        n(i) = v2
      ELSEIF LCASE(d1) = "n" THEN
        n(i) = v1
        err = LCASE(d2) <> "e"
        e(i) = v2
      ELSE
        err = 1
      ENDIF
      IF err THEN
        PRINT "Data format err - rec ";i + 1
        EXIT FOR
      ENDIF
    NEXT
    IF NOT err THEN
      CLOSE #fh
      CLS
      a = 0
      min1 = n(0)
      max1 = n(0)
      min2 = e(0)
      max2 = e(0)
      FOR i = 0 TO t - 1
        j = (i + 1) MOD t
        a = a + (e(i) * n(j) - e(j) * n(i))
        s(i) = SQR((e(i) - e(j)) ^ 2 + (n(i) - n(j)) ^ 2)
        min1 = MIN(min1, n(i))
        max1 = MAX(max1, n(i))
        min2 = MIN(min2, e(i))
       max2 = MAX(max2, e(i))
      NEXT
      rng = 135 / MAX(max1 - min1, max2 - min2)
      cn = min1 + (max1 - min1) / 2
      ce = min2 + (max2 - min2) / 2
      p = 0
      NORTHPT 79,72
      FOR i = 0 TO t - 2 + closed
        j = (i + 1) MOD t
        AT 0,0
        PRINT "p";i + 1;" -> p";j + 1; "  d = "; ROUND(s(i), 8);CHR(27)+"[K";
        p = p + s(i)
        LINE 79 + (e(i) - ce) * rng, 79 - (n(i) - cn) * rng, 79 + (e(j) - ce) * rng, 79 - (n(j) - cn) * rng
        PAUSE 1
      NEXT
      AT 0,160 - TXTH("A")
      IF closed THEN
        PRINT "P = ";ROUND(p,2);"  A = "; ROUND(ABS(a / 2));'' " ("; ROUND(ABS(a / 2) / 43560,2);" A)";
      ELSE
        PRINT "D = ";ROUND(p,8);
      ENDIF
      PAUSE
      CLS
    ENDIF
  ELSE
    PRINT "No such file"
  ENDIF
UNTIL 0
END

#inc:"LIB$North.bas"
'
