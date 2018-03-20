
'spring and mass animation
'response of masses and springs to displacement by a sinusoidal driver

WINDOW -500, -1200,500, 100

'set up differential equations of motion for top and bottom masses
func osct (mt, kt, kb, tn, bn, xt, xb, fr, zt) = -kt * (xt - tn + fr) / mt + kb * (xb - xt - bn) / mt - .1 * zt
func oscb (mb, kb, nb, xt, xb, zb) = -kb * (xb - xt - bn) / mb - .1 * zb

'input initial positions and velocities
PRINT "damped driven masses program "
PRINT "vertical range is (top) 0 to (bottom) 120"
INPUT "top mass initial speed, m/s (0)"; zt
INPUT "top mass initial position, m (40)"; xt
INPUT "top spring natural length, m (40)"; tn
INPUT "top mass, kg (40)"; mt
INPUT "top spring constant, N/m (40)"; kt
INPUT "bottom mass initial speed, m/s (0)"; zb
INPUT "bottom mass initial position, m (80)"; xb
INPUT "bottom spring natural length, m (40)"; bn
INPUT "bottom mass, kg (30)"; mb
INPUT "bottom spring constant, N/m (30)"; kb
INPUT "final t, seconds (200)"; tf
INPUT "frequency sweep rate, Hz/sec (.01)"; hz
n = 20 * tf: h = tf / n: fact = hz * tf / n
CLS

'evaluate the differential equations
FOR q = 1 TO n
fr = 5 * SIN(fact * q * t)
kt1 = h * zt: lt1 = h * osct(mt, kt, kb, tn, bn, xt, xb, fr, zt)
kb1 = h * zb: lb1 = h * oscb(mb, kb, bn, xt, xb, zb)
kt2 = h * (zt + .5 * lt1)
kb2 = h * (zb + .5 * lb1)
lt2 = h * osct(mt, kt, kb, tn, bn, xt + .5 * kt1, xb + .5 * kb1, fr, zt)
lb2 = h * oscb(mb, kb, bn, xt + .5 * kt1, xb + .5 * kb1, zb)
kt3 = h * (zt + .5 * lt2)
kb3 = h * (zb + .5 * lb2)
lt3 = h * osct(mt, kt, kb, tn, bn, xt + .5 * kt2, xb + .5 * kb2, fr, zt)
lb3 = h * oscb(mb, kb, bn, xt + .5 * kt2, xb + .5 * kb2, zb)
kt4 = h * (zt + lt3)
kb4 = h * (zb + lb3)
xt = xt + (kt1 + 2 * kt2 + 2 * kt3 + kt4) / 6
xb = xb + (kb1 + 2 * kb2 + 2 * kb3 + kb4) / 6
zt = kt4 / h: zb = kb4 / h: t = t + h
xtp = -xt: xbp = -xb

'white out old graphic
for dd=0 to 16000:next dd
LINE -50, 10*frold,50,10* frold,15
CIRCLE 0, 10*xtpold, 10,1, COLOR 15 FILLED: LINE 0, 10*frold,0,10* xtpold, 15
LINE 0, 10*xtpold,0, 10*xbpold, 15: CIRCLE 0, 10*xbpold,10, 1, COLOR 15 FILLED

'draw new graphic
LINE -50, 10*fr,50,10* fr
CIRCLE 0, 10*xtp, 10, 1,COLOR 4 FILLED: LINE 0, 10*fr,0,10* xtp, 4
LINE 0, 10*xtp,0, 10*xbp, 3: CIRCLE 0, 10*xbp,10, 1, COLOR 3 FILLED
for dd=0 to 16000:next dd
frold=fr:xtpold=xtp:xbpold=xbp
NEXT q

