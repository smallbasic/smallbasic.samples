'hopalong.bas SmallBASIC 2015-05-04 modified for Bpf, B+
' Hopalong-like fractal maths derived from a 1980''s Acorn User one-line program
' converted to SmallBASIC by Martin Latter, 7 Nov 2006
REPEAT
   rect 0,0,xmax,ymax,15 filled
   'CLS
   j = RND * 100
   k = RND * 100
   x = 0:y = 0:r = 0:n = 0
   xoffs = XMAX / 3
   yoffs = YMAX / 3
   COLOR RND * 15
   FOR i = 1 TO 10000000
      r = RND * 4000
      IF r > 3997 THEN COLOR RND * 15
      xx = y - SGN(x) * SQR(ABS(k * x - 1))
      y = j - x
      x = xx
      xp = x * 3 + xoffs
      yp = y * 3 + yoffs
      PSET xp, yp
   NEXT i
   pause 10
   k=inkey
UNTIL asc(k)=27