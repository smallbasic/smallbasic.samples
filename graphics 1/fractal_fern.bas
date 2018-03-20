
CLS
iii=0
RANDOMIZE TIMER
'x = 60
'y = 60
WHILE iii<100000
     r = RND
     IF (r <= .01) THEN
             a = 0: b = 0: c = 0: d = .16: e = 0: f = 0
     ELSEIF r > .01 AND r <= .86 THEN
             a = .85: b = .04: c = -.04: d = .85: e = 0: f = 1.6
     ELSEIF r > .86 AND r <= .93 THEN
             a = .2: b = -.26: c = .23: d = .22: e = 0: f = 1.6
     ELSE
             a = -.15: b = .28: c = .26: d = .24: e = 0: f = .44
     END IF
     newx = (a * x) + (b * y) + e
     newy = (c * x) + (d * y) + f
     x = newx
     y = newy
     PSET x*50+150, y*50, 2
     ' print x,y
     iii=iii+1
WEND
