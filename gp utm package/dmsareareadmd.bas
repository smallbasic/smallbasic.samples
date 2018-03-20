
'#sec:Main
'' table fields
'' table(1,n) -> course bearing (z rad)
'' table(2,n) -> course length
'' table(3,n) -> departure (signed)
'' table(4,n) -> latitude (signed)
'' table(5,n) -> DMD
'' table(6,n) -> dep sum
'' table(7,n) -> lat sum
REPEAT
  INPUT "Dataset";ds$
  IF LEN(ds$) = 0 THEN
    EXIT LOOP
  ENDIF
  IF EXIST(ds$) THEN
    fh = FREEFILE
    OPEN ds$ FOR INPUT AS #fh
    INPUT #fh;t,type
    ERASE table,b$
    DIM table(7,t),b$(t)
    FOR i = 1 TO t
      INPUT #fh;cn,b1$,dg,mn,sc,b2$,h
      IF cn <1 OR cn > t THEN
        PRINT "Erroneous course nbr - ";cn
        err = 1
        EXIT FOR
      ENDIF
      b1$ = UCASE(b1$)
      b2$ = UCASE(b2$)
      th = RAD(dg + mn / 60 + sc / 3600)
      IF b1$ = "N" AND b2$ = "W" THEN
        z = 2 * pi - th
      ELSEIF b1$ = "S" AND b2$ = "E" THEN
        z = pi - th
      ELSEIF b1$ = "S" AND b2$ = "W" THEN
        z = pi + th
      ELSE
        z = th
      ENDIF
      table(4,cn) = COS(z) * h
      table(3,cn) = SIN(z) * h
      table(2,cn) = h
      table(1,cn) = z
      b$(cn) = b1$ + " " + STR(dg) + CHR(176) + " " + STR(mn) + CHR(39) + " " + STR(sc) + CHR(34) + " " + b2$  
    NEXT
    CLOSE #fh
    IF NOT err THEN
      lats = table(4, 1)
      deps = table(3, 1)
      table(6, 1) = deps
      table(7, 1) = lats
      table(5, 1) = deps
      a = deps * lats
      FOR i = 2 TO t
        table(5, i) = table(5, i - 1) + table(3, i - 1) + table(3, i)
        a = a + table(5,i) * table(4,i)
        deps = deps + table(3, i)
        lats = lats + table(4, i)
        table(7, i) = lats
        table(6, i) = deps
      NEXT
      FOR i = 1 TO t
        PRINT b$(i);" ";ROUND(table(2, i), 2);"'' DMD ";ROUND(table(5,i),3)
        PRINT PRT$(table(3, i), 15, 8);PRT$(table(4, i), 16, 8)
        PRINT  PRT$(table(6, i), 15, 8);PRT$(table(7, i), 16, 8)
      PAUSE
      NEXT
      PRINT
      PRINT "Area = ";ROUND(ABS(a / 2), 2);" sq. ft."
    ENDIF
  ELSE
    PRINT "No such file"
  ENDIF
UNTIL 0
END

FUNC PRT$(x,s,d)
  LOCAL x$,y
  x$ = STR(ROUND(x,d))
  y = INSTR(x$,".")
  IF y = 0 AND d > 0 THEN
    x$ = x$ + "."
  ENDIF
  y = LEN (RIGHTOF(x$,"."))
  IF y < d THEN
    x$ = x$ + STRING(d - y,"0")
  ENDIF
  y = LEN(x$)
  IF y > s AND s <> 0 THEN
    x$ = STRING(s,"*")
  ELSEIF y < s THEN
    x$ = SPACE(s - y) + x$
  ENDIF
  PRT$ = CHR(27)+"[92m"+x$+CHR(27)+"[80m"
END
'
