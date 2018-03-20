
'#sec:Main
G2UINIT

PRINT "Select Datum:"
FOR i = 1 TO dats
  PRINT i;" - ";datums(i,5)
NEXT
INPUT ""+STR(dats + 1)+" - Other ellipsoid";datnum
datnum = INT(ABS(datnum))
IF datnum > dats THEN
  WHILE 1
    INPUT "Semimajor axis";er
    IF er <= 6376400 OR er > 6378500 THEN
      PRINT "Out of range"
    ELSE
      EXIT LOOP
    ENDIF
  WEND
  WHILE 1
    INPUT "Recip. of flattening";rf
    IF rf <= 290 OR rf > 302 THEN
      PRINT "Out of range"
    ELSE
      EXIT
    ENDIF
  WEND
  INPUT "Description";desc
  NDATUM er,rf,desc
ENDIF

REPEAT
  INPUT "(G)P or (U)TM"; ans
  IF LCASE(LEFT(ans,1)) = "g" THEN
    WHILE 1
      INPUT "Lat ";ans
      SPLIT ans," ,°''"+CHR(34),dmsa
      ans = LCASE(dmsa(0))
      IF ans = "n" THEN
        dmsa(1) = ABS(dmsa(1))
        ans = 1
        nors = 1
      ELSEIF ans = "s" THEN
        dmsa(1) = -ABS(dmsa(1))
        ans = 1
        nors = -1
      ELSE
        ans = 0
        nors = SGN(VAL(dmsa(0)))
      ENDIF
      latitude = ADMS(dmsa,ans,-1)
      IF latitude < -80 OR latitude > 84 THEN
        PRINT "Range is S80° to N84°"
      ELSE
        EXIT LOOP
      ENDIF
    WEND
    WHILE 1
      INPUT "Lon ";ans
      SPLIT ans," ,°''"+CHR(34),dmsa
      ans = LCASE(dmsa(0))
      IF ans = "e" THEN
        dmsa(1) = ABS(dmsa(1))
        ans = 1
        eorw = 1
      ELSEIF ans = "w" THEN
        dmsa(1) = -ABS(dmsa(1))
        ans = 1
        eorw = -1
      ELSE
        ans = 0
        eorw = SGN(VAL(dmsa(0)))
      ENDIF
      longitude = ADMS(dmsa,ans,-1)
      IF ABS(longitude) > 180 THEN
        PRINT "Range is 0° TO ";CHR(177);"180°"
      ELSE
        EXIT LOOP
      ENDIF
    WEND
    GP2UTM datnum,latitude,nors,longitude,eorw,zone,easting,northing
    ans = zone
  ELSEIF LCASE(LEFT(ans,1)) = "u" THEN
    WHILE 1
      INPUT "Z,E,N ";zone,easting,northing
      eorw = VAL(LEFT(zone,LEN(zone) - 1))
      nors = UCASE(RIGHT(zone,1))
      IF eorw < 1 OR eorw > 60 OR (NOT (nors IN LEFTOF(nhz,"?")) AND NOT (nors IN LEFTOF(shz,"?"))) THEN
        PRINT "Zone range is 1:60C:X"
      ELSE
        EXIT LOOP
      ENDIF
    WEND
    ans = zone
    UTM2GP datnum,latitude,nors,longitude,eorw,zone,easting,northing
  ELSE
    EXIT LOOP
  ENDIF
  PRINT datums(datnum,5)
  TODMS latitude,d,m,s,3
  PRINT "Lat	";MID("SNN",nors + 2,1);" ";d;CHR(176);m;CHR(39);s;CHR(34);" (";MID("-++",nors + 2,1);ROUND(ABS(latitude),5);"°)"
  TODMS longitude,d,m,s,3
  PRINT "Lon	";MID("WEE",eorw + 2,1);" ";d;CHR(176);m;CHR(39);s;CHR(34);" (";MID("-++",eorw + 2,1);ROUND(ABS(longitude),5);"°)"
  PRINT "Zone	";zone;
  IF zone <> UCASE(ans) THEN
    PRINT " (";ans;")"
  ELSE
    PRINT
  ENDIF
  PRINT "E (X)	";ROUND(easting,3);" m."
  PRINT "N (Y)	";ROUND(northing,3);" m."
UNTIL 0
END

#inc:"LIB$GPUTMCon.bas"

#inc:"LIB$DMSCon.bas"
'
