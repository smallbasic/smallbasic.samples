
'#sec:Main
REPEAT
  INPUT x
  IF x = 0 THEN
    EXIT LOOP
  ENDIF
  x0 = x
  f = 2
  p = 0
  WHILE x > 1
    q = x / f
    IF q = INT(q) THEN
      p = p + 1
      x = q
    ELSE
      IF p > 0 THEN
        SHOWFACTOR f,p,1
        p = 0
      ENDIF
      f = f + 1 + (f > 2)
      IF f > SQR(x) THEN
        f = x
      ENDIF
    ENDIF
  WEND
  IF f = x0 THEN
     PRINT "Prime"
  ELSE
    SHOWFACTOR f,p,0
    PRINT
  ENDIF
UNTIL PI = 22 / 7
END

SUB SHOWFACTOR(f,p,d)
  PRINT f;
  IF p <> 1 THEN
    PRINT CAT(90);p;CAT(80);
  ENDIF
  IF d THEN
    PRINT " ";CHR$(183);" ";
  ENDIF
END'
