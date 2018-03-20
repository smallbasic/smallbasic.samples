
'#sec:Main
SUB TODMS(a,BYREF d,BYREF m,BYREF s,sp)
  s = ABS(a) * 3600
  d = s \\ 3600
  s = s - d * 3600
  m = s \\ 60
  s = ROUND(s - m * 60,sp)
  IF s = 60 THEN
    s = 0
    m = m + 1
  ENDIF
  IF m >= 60 THEN
    m = m - 60
    d = d + 1
  ENDIF
END

FUNC ADMS(BYREF dmsary(),si,su)
LOCAL d,m,s
  IF su < 0 THEN
    su = UBOUND(dmsary)
  ENDIF
  IF su > si + 1 THEN
    s = ABS(dmsary(si + 2))
  ELSE
    s = 0
  ENDIF
  IF su > si THEN
    m = ABS(dmsary(si + 1))
  ELSE
    m = 0
  ENDIF
  IF su >= si THEN
    d = VAL(dmsary(si))
  ELSE
    d = 0
  ENDIF
  ADMS = DMS(d,m,s)
END

FUNC DMS(d,m,s)
  IF d < 0 THEN
    m = -ABS(m)
    s = -ABS(s)
  ENDIF
  DMS = d + (m + s / 60) / 60
END

'
