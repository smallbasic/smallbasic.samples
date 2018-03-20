
''' Hopalong-like fractal
'' maths derived from 1980''s Acorn User one-line program
'' converted to SmallBASIC by Martin Latter, 7 Nov 2006
'' press <space> to stop fractal regeneration, any other key or mouse movement to regenerate in SB 0.9.7


REPEAT

	CLS

	j = RND * 100
	k = RND * 100
	x = 0
	y = 0
	xx = 0
	xp = 0
	yp = 0
	r = 0
	i = 0
	xoffs = XMAX / 3
	yoffs = YMAX / 3

	COLOR RND * 16

	FOR i = 1 TO 100000

		r = RND * 4000
		IF r > 3997 THEN COLOR RND * 16

		xx = y - SGN(x) * SQR(ABS(k * x - 1))
		y = j - x
		x = xx
		xp = x * 3 + xoffs
		yp = y * 3 + yoffs
		PSET xp, yp

	NEXT i

	IF INKEY = " " THEN '' replace this line with ''IF INKEY<>"" THEN'' for older versions of SB
		BEEP
		EXIT
	END IF

	''PAUSE 1 '' uncomment this line for older versions of SB

UNTIL

END
'
