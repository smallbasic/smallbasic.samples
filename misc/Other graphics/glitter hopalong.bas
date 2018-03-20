'Glitter hopalong.bas SmallBASIC 2015-05-04 modified for Bpf, B+
' color changes for the night shift
REPEAT
   rect 0,0,xmax,ymax,0 filled
   j = RND * 100
   k = RND * 100
   x = 0:y = 0:r = 0:n = 0
   xoffs = XMAX / 3
   yoffs = YMAX / 3
   COLOR (8+RND*8)
   FOR i = 1 TO 10000000
      r = RND * 4000
      IF r > 3997 THEN COLOR (8+RND*8)
      xx = y - SGN(x) * SQR(ABS(k * x - 1))
      y = j - x
      x = xx
      xp = x * 3 + xoffs
      yp = y * 3 + yoffs
      PSET xp, yp
   NEXT i
   delay 1000
UNTIL inkey=" "
