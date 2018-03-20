
'Predator_Prey.bas
'program to plot the interaction between predator population (fox) and prey population (rabbit)

'set up the differential equations. fp=df/dt and rp=dr/dt
'fox populations grow with rabbits present but shrink with no rabbits
'rabbit populations decline when more foxes are around to eat them!
'the shape of the plot is very sensative to the exponent "w"

func fp(f,r)= .1*(f^w)*r-f
func rp(f,r)= 2*r-.05*f*r

'input initial conditions

input "exponent on fox population (.5 to 1) ";w
INPUT "initial number of foxes (10) "; f
INPUT "initial number of rabbits (100) "; r
input "duration of study (20) ";tf
n=400*tf
h = .0025
WINDOW -5, -20,n, 3*r

CLS

'draw graph axes

line 0,-20,0,3*r
line 0,0,n,0

'integrate the equtions

FOR q = 1 TO n
kfp1 = h * fp(f,r)
krp1 = h * rp(f,r)

kfp2 = h * fp(f + .5 * kfp1, r + .5 * krp1)
krp2 = h * rp(f + .5 * kfp1, r + .5 * krp1)

kfp3 = h * fp(f + .5 * kfp2, r + .5 * krp2)
krp3 = h * rp(f + .5 * kfp2, r + .5 * krp2)

kfp4 = h * fp(f + .5 * kfp3, r + .5 * krp3)
krp4 = h * rp(f + .5 * kfp3, r + .5 * krp3)

f = f + (kfp1 + 2 * kfp2 + 2 * kfp3 + kfp4) / 6
r = r + (krp1 + 2 * krp2 + 2 * krp3 + krp4) / 6

'plot the results

PSET q,f, 9: PSET q,r, 12
NEXT q
? "fox = blue"
? "rabbits = red"
Input "press enter to end ";bye
END
