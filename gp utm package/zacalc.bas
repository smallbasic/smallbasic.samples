
'#sec:Main
DIM emsg(4)
emsg(1) = "Unknown command"
emsg(2) = "Error in bearing"
emsg(3) = "Unknown combination"
emsg(4) = "No solution"
REPEAT
  err = 0
  PRINT "ZACalc -> ";
  LINEINPUT x$
  x$ = UCASE(SQUEEZE(x$))
	''? "input -> ";CHR(34);x$;CHR(34)
  SPLIT x$, " ;", x
  ux = UBOUND(x)
  IF ux < 1 THEN
    STOP
  ENDIF
  type = INSTR("DRCZNSA",x(0))
  IF type < 4 THEN
	''? "D/R/C type -> ";type
    SPLIT x(UBOUND(x)),",",y
	''? "parse -> ";y
    IF type < 3 THEN
      IF UBOUND(y) > 0 THEN
        r = ABS(y(1))
      ELSE
        r = 1
      ENDIF
      IF type = 1 THEN
        x(UBOUND(x)) = y(0)
        dad = ADMS(x,1,-1)
      ELSEIF type = 2 THEN
        dad = DEG(y(0))
      ENDIF
    ELSE
      dad = DEG(ATAN2(y(1), y(0)))
      r = SQR(y(0) ^ 2 + y(1) ^ 2)
    ENDIF
    dad = ZADJ(dad)
    dar = RAD(dad)
    z = ZSZ(dad)
  ELSEIF type = 4 THEN
	''? "Z type -> ";type
    SPLIT x(UBOUND(x)),",",y
	''? "parse -> ";y
    IF UBOUND(y) > 0 THEN
      r = ABS(y(1))
    ELSE
      r = 1
    ENDIF
    x(UBOUND(x)) = y(0)
    z = ZADJ(ADMS(x,1,-1))
    dad = ZSZ(z)
    dar = RAD(dad)
  ELSEIF type = 5 OR type = 6 THEN
	''? "bearing type -> ";type
    r = x(ux)
    IF  r <> "E" AND r <> "W" THEN
      ux = ux - 1
      r = VAL(r)
    ELSE
      r = 1
    ENDIF
    q = x(ux)
    IF (ux < 2 OR ux > 4) OR  (q <> "E" AND q <> "W") THEN
      err = 2
    ELSE
      q = x(0) + q
      b = ADMS(x,1,ux - 1)
      z = ZADJ((b + 180) * (q = "SW") + (180 - b) * (q = "SE") + (360 - b) * (q = "NW") + b * (q = "NE"))
      dad = ZSZ(z)
      dar = RAD(dad)
    ENDIF
  ELSEIF type = 7 THEN
    j = INSTR("SRSCSDSMS RCRMRDR CMCDC DMD",x(1))
  	''? "arc type -> ";type,j
    IF j > 0 THEN
      SPLIT x(2),",",y
	''? "parse -> ";y
      IF j MOD 2 THEN
        y0 = VAL(y(0))
        y1 = VAL(y(1))
      ELSE
        y0 = VAL(y(1))
        y1 = VAL(y(0))
      ENDIF
      IF j < 10 THEN
        s = y0
        IF j < 3 THEN
'' SR/RS
          r = y1
          dar = s / r
          lc = SIN(dar / 2) * 2 * r
          m = TAN(dar / 4) * lc / 2
        ELSEIF j < 5 THEN
'' SC/CS
          lc = y1
          fd0 = lc / (2 * s)
          d0 = 0
          d1 = 2 * PI
          r = 0
          WHILE ABS(d1 - d0) > 1E-10
            dar = d0 + (d1 - d0) / 2
            fd = SIN(dar / 2) / dar
            IF ABS(fd0 - fd) < 1E-10 THEN
              r = s / dar
              EXIT LOOP
            ELSEIF fd0 < fd THEN
              d0 = dar
            ELSE
              d1 = dar
            ENDIF
          WEND
          m = TAN(dar / 4) * lc / 2
        ELSEIF j < 7 THEN
'' SD/DS
          dar = RAD(y1)
          r = s / dar
          lc = SIN(dar / 2) * 2 * r
          m = TAN(dar / 4) * lc / 2
        ELSE
'' SM/MS
          m = y1
          fd0 = m / (2 * s)
          d0 = 0
          d1 = 2 * PI
          r = 0
          WHILE ABS(d1 - d0) > 1E-10
            dar = d0 + (d1 - d0) / 2
            fd = SIN(dar / 4) ^ 2 / dar
            IF ABS(fd0 - fd) < 1E-10 THEN
              r = s / dar
              EXIT LOOP
            ELSEIF fd0 > fd THEN
              d0 = dar
            ELSE
              d1 = dar
            ENDIF
          WEND
          lc = SIN(dar / 2) * 2 * r
        ENDIF
      ELSEIF j < 18 THEN
        r = y0
        IF j < 13 THEN
'' RC/CR
          lc = ABS(y1)
          dar = ASIN(lc / (2 * r)) * 2
          IF y1 < 0 THEN
            dar = 2 * PI - dar
          ENDIF
          s = dar * r
          m = TAN(dar / 4) * lc / 2
        ELSEIF j < 15 THEN
'' RM/MR
          m = y1
          dar = 2 * ACOS(1 - m / r)
          s = dar * r
          lc = SIN(dar / 2) * 2 * r
        ELSE
'' RD/DR
          dar = RAD(y1)
          s = dar * r
          lc = SIN(dar / 2) * 2 * r
          m = TAN(dar / 4) * lc / 2
        ENDIF
      ELSEIF j < 24 THEN
        lc = y0
        IF j < 21 THEN
'' CM/MC
          m = y1
          dar = 4 * ATAN2(2 * m,lc)
          r = lc / (2 * SIN(dar / 2))
          s = dar * r
        ELSE
'' CD/DC
          dar = RAD(y1)
          r = lc / (2 * SIN(dar / 2))
          s = dar * r
          m = TAN(dar / 4) * lc /2
        ENDIF
      ELSE
'' DM/MD
        dar = RAD(y0)
        m = y1
        lc = 2 * m / TAN(dar / 4)
        r = lc / (2 * SIN(dar / 2))
        s = dar * r
      ENDIF
      sector = r * r * dar / 2
      triangle = r * r * SIN(dar) / 2
      segment = sector - triangle
      err = 4 * (r= 0)
    ELSE
      err = 3
    ENDIF
  ELSE
    err = 1
  ENDIF
  IF NOT err THEN
    IF type < 7 THEN
      b = z
      IF b > 270 THEN
        b = 360 - b
        q = "NW"
      ELSEIF b > 180 THEN
        b = b - 180
        q = "SW"
      ELSEIF b > 90 THEN
        b = 180 - b
        q = "SE"
      ELSE
        q = "NE"
      ENDIF
      TODMS dad,dd,mm,ss,3
      PRINT "Π ";dad;"° (";dar;" rad)"
      PRINT dd;"°";mm;"''";ss;CHR(34);" ";dd;"°";mm + ss / 60;"''"
      TODMS z,zd,zm,zs,3
      TODMS b,bd,bm,bs,3
      PRINT "Z ";zd;"°";zm;"''";zs;CHR(34);" (";MID(q,1,1);" ";bd;"°";bm;"''";bs;CHR(34);" ";MID(q,2,1);")"
      PRINT "Dep (x) ";ROUND(COS(dar) * r,5);", Lat (y) ";ROUND(SIN(dar) * r,5);", Len (r) ";ROUND(r,5)
    ELSE
      PRINT "Π ";DEG(dar);"° (";dar;" rad)"
      PRINT "S ";ROUND(s,15);", R ";ROUND(r,15)
      PRINT "M ";ROUND(m,15);", LC ";ROUND(lc,15)
      PRINT "§ ";ROUND(sector,2);", π ";ROUND(triangle,2);", Seg ";ROUND(segment,2)
    ENDIF
  ELSE
    PRINT emsg(err)
  ENDIF
  PRINT
UNTIL 0
END

FUNC ZSZ(z)
  ZSZ = ZADJ(450 - z)
END

FUNC ZADJ(z)
  IF z < 0 THEN
    ZADJ = z + 360 * ((z - 359) \\ -360)
  ELSE
    ZADJ = z - 360 * (z \\ 360)
  ENDIF
END

#inc:"LIB$DMSCon.bas"
'
