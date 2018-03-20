
' Plot of the "Strange Attractor"
' Define 3 differential equations
func lxt (x, y) = 10 * (y - x)
func lyt (x, y, z) = 28 * x - y - x * z
func lzt (x, y, z) = x * y - 8 * z / 3
 ' Set initial conditions
INPUT "initial x (.5) "; x
INPUT "initial y (-.5) "; y
INPUT "initial z (.3) "; z
INPUT "final time (50) "; tf
INPUT "number of intervals (100000) "; n

' Begin numerical integration of the d.e.q.'s
h = tf / n
cls
FOR q = 1 TO n
 kxt1 = h * lxt(x, y)
 kyt1 = h * lyt(x, y, z)
 kzt1 = h * lzt(x, y, z)
 kxt2 = h * lxt(x + .5 * kxt1, y + .5 * kyt1)
 kyt2 = h * lyt(x + .5 * kxt1, y + .5 * kyt1, z + .5 * kzt1)
 kzt2 = h * lzt(x + .5 * kxt1, y + .5 * kyt1, z + .5 * kzt1)
 kxt3 = h * lxt(x + .5 * kxt2, y + .5 * kyt2)
 kyt3 = h * lyt(x + .5 * kxt2, y + .5 * kyt2, z + .5 * kzt2)
 kzt3 = h * lzt(x + .5 * kxt2, y + .5 * kyt2, z + .5 * kzt2)
 kxt4 = h * lxt(x + .5 * kxt3, y + .5 * kyt3)
 kyt4 = h * lyt(x + .5 * kxt3, y + .5 * kyt3, z + .5 * kzt3)
 kzt4 = h * lzt(x + .5 * kxt3, y + .5 * kyt3, z + .5 * kzt3)
 x = x + (kxt1 + 2 * kxt2 + 2 * kxt3 + kxt4) / 6
 y = y + (kyt1 + 2 * kyt2 + 2 * kyt3 + kyt4) / 6
 z = z + (kzt1 + 2 * kzt2 + 2 * kzt3 + kzt4) / 6
 xp=10*x+900:yp=15*y+400:zp=10*z+100
 PSET xp, yp, 9: PSET zp, yp, 5
NEXT q
END
