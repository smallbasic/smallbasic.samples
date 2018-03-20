
'#sec:Main
SUB G2UINIT
LOCAL i,j
CONST nhz = "NPQRSTUVWXX?"
CONST shz = "MLKJHGFEDCC?"
CONST dats = 4
ndats = dats
DIM datums(1 TO dats + 1,1 TO 5)
DATA 6378206.4,294.978698000,"Clarke 1866 (NAD27)"
DATA 6378137.0,298.257222101,"WGS84/GRS80 (NAD83)"
DATA 6378388.0,297.000000000,"International 1910"
DATA 6378135.0,298.260000000,"WGS72"
  FOR i = 1 TO dats
    READ datums(i,1)
    READ datums(i,2)
    datums(i,3) = 1 / datums(i,2)
    datums(i,4) = datums(i,3) * 2 - datums(i,3) ^ 2
    READ datums(i,5)
  NEXT
END


SUB NDATUM(er,rf,desc)
  ndats = dats + 1
  datums(ndats,1) = er
  datums(ndats,2) = rf
  datums(ndats,3) = 1 / rf
  datums(ndats,4) = datums(ndats,3) * 2 - datums(ndats,3) ^ 2
  datums(ndats,5) = desc
END


SUB GP2UTM(datnum,lat,ns,lon,ew,BYREF zone,BYREF east,BYREF north)
LOCAL phi,lam,iz,cm,fn,er,rf,f,esq,eps,pr,en,a,b,c,r,om,s,sinfi,cosfi,tn,ts,ets,l,ls,rn

  IF ew = 0 THEN
    ew = SGN(lon) + (lon = 0)
  ENDIF
  IF ew > 0 THEN
    lam = 360 - ABS(lon)
    iz = MAX(90 - lam \\ 6,31)
    cm = RAD(543 - 6 * iz)
  ELSE
    lam = ABS(lon)
    iz = MAX(30 - lam \\ 6,1)
    cm = RAD(183 - 6 * iz)
  ENDIF
  lam = RAD(lam)

  IF ns = 0 THEN
    ns = SGN(lat) + (lat = 0)
  ENDIF
  phi = RAD(ABS(lat))
  IF ns < 0 THEN
    fn = 10000000
  ELSE
    fn = 0
  ENDIF
  zone = UTMZONE(iz,lat,ns)

  er = datums(datnum,1)
  rf = datums(datnum,2)
  f = datums(datnum,3)
  esq = datums(datnum,4)

  eps = esq / (1 - esq)
  pr = (1 - f) * er
  en = (er - pr) / (er + pr)
  r =  er * (1 - en) * (1 - en ^ 2) * (1 + 2.25 * en ^ 2 + (225 / 64) * en ^ 4)
  a = -1.5 * en + (9 / 16) * en ^ 3
  b = 0.9375 * en ^ 2 - (15 / 32) * en ^ 4
  c = -(35 / 48) * en ^ 3

  om = phi + a * SIN(2 * phi) + b * SIN(4 * phi) + c * SIN(6 * phi)
  s = r * om * 0.9996
  sinfi = SIN(phi)
  cosfi = COS(phi)
  tn = sinfi / cosfi
  ts = tn ^ 2
  ets = eps * cosfi ^ 2
  l = (lam - cm) * cosfi
  ls = l * l
  rn = 0.9996 * er / SQR(1 - esq * sinfi ^ 2)
  a = rn * tn / 2
  b = (5 - ts + ets * (9 + 4 * ets)) / 12
  c = (61 + ts * (ts - 58) + ets * (270 - 330 * ts)) / 360
  north = ABS(s + a * ls * (1 + ls * (b + c * ls)) - fn)
  a = (1 - ts + ets) / 6
  b = (5 + ts * (ts - 18) + ets * (14 - 58 * ts)) / 120
  c = (61 - 479 * ts + 179 * ts ^ 2 - ts ^ 3) / 5040
  east = 500000 - rn * l * (1 + ls * (a + ls * (b + c * ls)))

END


SUB UTM2GP(datnum,BYREF lat,BYREF ns,BYREF lon,BYREF ew,BYREF zone,east,north)
LOCAL iz,cm,fn,er,rf,f,esq,eps,pr,en,c2,c4,c6,c8,v0,v2,v4,v6,r,om,cosom,foot,sinf,cosf,tn,ts,ets,rn,q,qs,l

  iz = VAL(LEFT$(zone,LEN(zone) - 1))
  IF iz < 30 THEN
    cm = RAD(183 - 6 * iz)
    ew = -1
  ELSE
    cm = RAD(543 - 6 * iz)
    ew = 1
  ENDIF

  IF INSTR(shz,UCASE$(RIGHT$(zone,1))) THEN
    north = 20000000 - north
  ENDIF
  IF north > 10000000 THEN
    fn = 10000000
    ns = -1
  ELSE
    fn = 0
    ns = 1
  ENDIF

  er = datums(datnum,1)
  rf = datums(datnum,2)
  f = datums(datnum,3)
  esq = datums(datnum,4)

  eps = esq / (1 - esq)
  pr = (1 - f) * er
  en = (er - pr) / (er + pr)
  r = er * (1 - en) * (1 - en ^ 2) * (1 + 2.25 * en ^ 2 + (225 / 64) * en ^ 4)
  c2 = 3 * en / 2 - 27 * en ^ 3 / 32
  c4 = 21 * en ^ 2 / 16 - 55 * en ^ 4 / 32
  c6 = 151 * en ^ 3 / 96
  c8 = 1097 * en ^ 4 / 512
  v0 = 2 * (c2 - 2 * c4 + 3 * c6 - 4 * c8)
  v2 = 8 * (c4 - 4 * c6 + 10 * c8)
  v4 = 32 * (c6 - 6 * c8)
  v6 = 128 * c8

  om = (north - fn) / (r * 0.9996)
  cosom = COS(om)
  foot = om + SIN(om) * cosom * (v0 + v2 * cosom ^ 2 + v4 * cosom ^ 4 + v6 * cosom ^ 6)
  sinf = SIN(foot)
  cosf = COS(foot)
  tn = sinf / cosf
  ts = tn * tn
  ets = eps * cosf ^ 2
  rn = er * 0.9996 / SQR(1 - esq * sinf ^ 2)
  q = (east - 500000) / rn
  qs = q * q
  c2 = -tn * (1 + ets) / 2
  c4 = -(5 + 3 * ts + ets * (1 - 9 * ts) - 4 * ets ^ 2) / 12
  c6 = (61 + 45 * ts * (2 + ts) + ets * (46 - 252 * ts - 60 * ts ^ 2)) / 360
  lat = DEG(foot + c2 * qs * (1 + qs * (c4 + c6 * qs)))
  zone = UTMZONE(iz,lat,ns)

  c2 = -(1 + ts + ts + ets) / 6
  c4 = (5 + ts * (28 + 24 * ts) + ets * (6 + 8 * ts)) / 120
  c6 = -(61 + 662 * ts + 1320 * ts ^ 2 + 720 * ts ^ 3) / 5040
  l = q * (1 + qs * (c2 + qs * (c4 + c6 * qs)))
  lon = DEG(-l / cosf + cm)
  IF lon > 180 THEN
    lon = 360 - lon
  ENDIF

END

FUNC UTMZONE(iz,lat,ns)
  IF ns < 0 THEN
    UTMZONE = STR$(iz) + MID$(shz,MIN(ABS(lat) \\ 8 + 1,LEN(shz)),1)
  ELSE
    UTMZONE = STR$(iz) + MID$(nhz,MIN(ABS(lat) \\ 8 + 1,LEN(nhz)),1)
  ENDIF
END
'
