
'Two masses suspended by two springs in tandem are subject to a driving motion.
'The driving motion is sinusoidal, with an increasing frequency characterized by an increasing sweep rate.
'The system is described by mass and by spring length and stiffness.
'The output graph shows the driver motion on top, and the response of the two masses below.
'Notice the two resonance intervals where mass displacement is greatest. 
'From the left, the masses are initially in phase, and later resonate out of phase. 

WINDOW 0, -1200,1000, 100
'write function for the differential equations of motion.
func osct (mt, kt, kb, tn, bn, xt, xb, fr, zt) = -kt * (xt - tn + fr) / mt + kb * (xb - xt - bn) / mt - .1 * zt
func oscb (mb, kb, nb, xt, xb, zb) = -kb * (xb - xt - bn) / mb - .1 * zb
  
'input initial conditions
PRINT "driven coupled masses with dampening program "
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
INPUT "final time (300)"; tf: n = 60 * tf: h = tf / n
INPUT "frequency sweeprate, Hz/sec (.004)"; hz

'time step loops to find the system response
t = 0: fact = hz * tf / n: CLS
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
xtp = -xt: xbp = -xb: tme = 100 * q / n

'plot the graph
PSET 10*tme, 10*fr
PSET 10*tme, 10*xtp, 9
PSET 10*tme, 10*xbp, 3
NEXT q
end

