
' a star and planetary system governed by newton's laws.
' when the escape velocity of a planet is exceded, it's trajectory turns red
' the range of x values on the screen is -130 to +130
' the range of y values on the screen is -100 to +100

WINDOW -640, -512,640, 512

func gryb (yb, yp, ys, yt) = mp * (yp - yb) / rbp + ms * (ys - yb) / rbs + mt * (yt - yb) / rbt
func grxb (xb, xp, xs, xt) = mp * (xp - xb) / rbp + ms * (xs - xb) / rbs + mt * (xt - xb) / rbt
func gryp (yb, yp, ys, yt) = ms * (ys - yp) / rps + mb * (yb - yp) / rbp + mt * (yt - yp) / rpt
func grxp (xb, xp, xs, xt) = ms * (xs - xp) / rps + mb * (xb - xp) / rbp + mt * (xt - xp) / rpt
func grxs (xb, xp, xs, xt) = mp * (xp - xs) / rps + mb * (xb - xs) / rbs + mt * (xt - xs) / rst
func grys (yb, yp, ys, yt) = mp * (yp - ys) / rps + mb * (yb - ys) / rbs + mt * (yt - ys) / rst
func grxt (xb, xp, xs, xt) = mb * (xb - xt) / rbt + mp * (xp - xt) / rpt + ms * (xs - xt) / rst
func gryt (yb, yp, ys, yt) = mb * (yb - yt) / rbt + mp * (yp - yt) / rpt + ms * (ys - yt) / rst
PRINT "automatic momentum zero"
INPUT "central mass (50000)"; mb
xb = 0: yb = 0
INPUT "primary mass (2000)"; mp
INPUT "initial primary x (400)"; xp
INPUT "initial primary y (0)"; yp
zxp = -yp * (mb / (xp ^ 2 + yp ^ 2) ^ 1.5) ^ .5
zyp = xp * (mb / (xp ^ 2 + yp ^ 2) ^ 1.5) ^ .5
INPUT "circular orbit ? y/n"; acc$: IF acc$ = "y" THEN GOTO 10
PRINT "primary x-circular velo.="; zxp
INPUT "initial dx/dt"; zxp
PRINT "primary y-circular velo.="; zyp
INPUT "initial dy/dt"; zyp
10 INPUT "secondary mass (1000)"; ms
INPUT "initial secondary x (0)"; xs
INPUT "initial secondary y (300)"; ys
zxs = -ys * (mb / (xs ^ 2 + ys ^ 2) ^ 1.5) ^ .5
zys = xs * (mb / (xs ^ 2 + ys ^ 2) ^ 1.5) ^ .5
INPUT "circular orbit ? y/n"; acc$: IF acc$ = "y" THEN GOTO 20
PRINT "secondary x-circular velo.="; zxs
INPUT "initial secondary dx/dt"; zxs
PRINT "secondary y-circular velo.="; zys
INPUT "initial secondary dy/dt"; zys
20 INPUT "tertiary mass (500)"; mt
INPUT "initial tertiary x (-300)"; xt
INPUT "initial tertiary y (-400)"; yt
zxt = -yt * (mb / (xt ^ 2 + yt ^ 2) ^ 1.5) ^ .5
zyt = xt * (mb / (xt ^ 2 + yt ^ 2) ^ 1.5) ^ .5
INPUT "circular orbit ? y/n"; acc$: IF acc$ = "y" THEN GOTO 30
PRINT "tertiary x-circular velo.="; zxt
INPUT "initial tertiary dx/dt"; zxt
PRINT "tertiary y-circular velo.="; zyt
INPUT "initial tertiary dy/dt"; zyt
30 INPUT "final t (1600)"; tf
INPUT "number of intervals (800000)"; n
zxb = -(mp * zxp + ms * zxs + mt * zxt) / mb
zyb = -(mp * zyp + ms * zys + mt * zyt) / mb
h = tf / n
CLS
FOR q = 1 TO n
rbp = ((xb - xp) ^ 2 + (yb - yp) ^ 2) ^ 1.5
rbs = ((xb - xs) ^ 2 + (yb - ys) ^ 2) ^ 1.5
rps = ((xp - xs) ^ 2 + (yp - ys) ^ 2) ^ 1.5
rbt = ((xb - xt) ^ 2 + (yb - yt) ^ 2) ^ 1.5
rpt = ((xp - xt) ^ 2 + (yp - yt) ^ 2) ^ 1.5
rst = ((xs - xt) ^ 2 + (ys - yt) ^ 2) ^ 1.5
kxb1 = h * zxb: lxb = h * grxb(xb, xp, xs, xt)
kyb1 = h * zyb: lyb = h * gryb(yb, yp, ys, yt)
kxp1 = h * zxp: lxp = h * grxp(xb, xp, xs, xt)
kyp1 = h * zyp: lyp = h * gryp(yb, yp, ys, yt)
kxs1 = h * zxs: lxs = h * grxs(xb, xp, xs, xt)
kys1 = h * zys: lys = h * grys(yb, yp, ys, yt)
kxt1 = h * zxt: lxt = h * grxt(xb, xp, xs, xt)
kyt1 = h * zyt: lyt = h * gryt(yb, yp, ys, yt)
kxb2 = h * (zxb + .5 * lxb)
kyb2 = h * (zyb + .5 * lyb)
kxp2 = h * (zxp + .5 * lxp)
kyp2 = h * (zyp + .5 * lyp)
kxs2 = h * (zxs + .5 * lxs)
kys2 = h * (zys + .5 * lys)
kxt2 = h * (zxt + .5 * lxt)
kyt2 = h * (zyt + .5 * lyt)
nxb = xb + .5 * kxb1: nyb = yb + .5 * kyb1
nxp = xp + .5 * kxp1: nyp = yp + .5 * kyp1
nxs = xs + .5 * kxs1: nys = ys + .5 * kys1
nxt = xt + .5 * kxt1: nyt = yt + .5 * kyt1
rbp = ((nxb - nxp) ^ 2 + (nyb - nyp) ^ 2) ^ 1.5
rbs = ((nxb - nxs) ^ 2 + (nyb - nys) ^ 2) ^ 1.5
rps = ((nxp - nxs) ^ 2 + (nyp - nys) ^ 2) ^ 1.5
rbt = ((nxb - nxt) ^ 2 + (nyb - nyt) ^ 2) ^ 1.5
rpt = ((nxp - nxt) ^ 2 + (nyp - nyt) ^ 2) ^ 1.5
rst = ((nxs - nxt) ^ 2 + (nys - nyt) ^ 2) ^ 1.5
lxb = h * grxb(nxb, nxp, nxs, nxt)
lyb = h * gryb(nyb, nyp, nys, nyt)
lxp = h * grxp(nxb, nxp, nxs, nxt)
lyp = h * gryp(nyb, nyp, nys, nyt)
lxs = h * grxs(nxb, nxp, nxs, nxt)
lys = h * grys(nyb, nyp, nys, nyt)
lxt = h * grxt(nxb, nxp, nxs, nxt)
lyt = h * gryt(nyb, nyp, nys, nyt)
kxb3 = h * (zxb + .5 * lxb)
kyb3 = h * (zyb + .5 * lyb)
kxp3 = h * (zxp + .5 * lxp)
kyp3 = h * (zyp + .5 * lyp)
kxs3 = h * (zxs + .5 * lxs)
kys3 = h * (zys + .5 * lys)
kxt3 = h * (zxt + .5 * lxt)
kyt3 = h * (zyt + .5 * lyt)
nxb = xb + .5 * kxb2: nyb = yb + .5 * kyb2
nxp = xp + .5 * kxp2: nyp = yp + .5 * kyp2
nxs = xs + .5 * kxs2: nys = ys + .5 * kys2
nxt = xt + .5 * kxt2: nyt = yt + .5 * kyt2
rbp = ((nxb - nxp) ^ 2 + (nyb - nyp) ^ 2) ^ 1.5
rbs = ((nxb - nxs) ^ 2 + (nyb - nys) ^ 2) ^ 1.5
rps = ((nxp - nxs) ^ 2 + (nyp - nys) ^ 2) ^ 1.5
rbt = ((nxb - nxt) ^ 2 + (nyb - nyt) ^ 2) ^ 1.5
rpt = ((nxp - nxt) ^ 2 + (nyp - nyt) ^ 2) ^ 1.5
rst = ((nxs - nxt) ^ 2 + (nys - nyt) ^ 2) ^ 1.5
lxb = h * grxb(nxb, nxp, nxs, nxt)
lyb = h * gryb(nyb, nyp, nys, nyt)
lxp = h * grxp(nxb, nxp, nxs, nxt)
lyp = h * gryp(nyb, nyp, nys, nyt)
lxs = h * grxs(nxb, nxp, nxs, nxt)
lys = h * grys(nyb, nyp, nys, nyt)
lxt = h * grxt(nxb, nxp, nxs, nxt)
lyt = h * gryt(nyb, nyp, nys, nyt)
kxb4 = h * (zxb + lxb): kyb4 = h * (zyb + lyb)
kxp4 = h * (zxp + lxp): kyp4 = h * (zyp + lyp)
kxs4 = h * (zxs + lxs): kys4 = h * (zys + lys)
kxt4 = h * (zxt + lxt): kyt4 = h * (zyt + lyt)
xb = xb + (kxb1 + 2 * kxb2 + 2 * kxb3 + kxb4) / 6
yb = yb + (kyb1 + 2 * kyb2 + 2 * kyb3 + kyb4) / 6
xp = xp + (kxp1 + 2 * kxp2 + 2 * kxp3 + kxp4) / 6
yp = yp + (kyp1 + 2 * kyp2 + 2 * kyp3 + kyp4) / 6
xs = xs + (kxs1 + 2 * kxs2 + 2 * kxs3 + kxs4) / 6
ys = ys + (kys1 + 2 * kys2 + 2 * kys3 + kys4) / 6
xt = xt + (kxt1 + 2 * kxt2 + 2 * kxt3 + kxt4) / 6
yt = yt + (kyt1 + 2 * kyt2 + 2 * kyt3 + kyt4) / 6
zxb = kxb4 / h: zyb = kyb4 / h
zxp = kxp4 / h: zyp = kyp4 / h
zxs = kxs4 / h: zys = kys4 / h
zxt = kxt4 / h: zyt = kyt4 / h
IF q = n THEN GOTO 200
IF (INT(q / 400000) - q / 400000) <> 0 THEN GOTO 200
CLS
200 IF zxp * zxp + zyp * zyp > 2 * mb / (rbp ^ (1 / 3)) THEN cp = 4 ELSE cp = 9
IF zxs * zxs + zys * zys > 2 * mb / (rbs ^ (1 / 3)) THEN cs = 4 ELSE cs = 3
IF zxt * zxt + zyt * zyt > 2 * mb / (rbt ^ (1 / 3)) THEN ct = 4 ELSE ct = 6
PSET xb, yb, 5: PSET xp, yp, cp: PSET xs, ys, cs: PSET xt, yt, ct
NEXT q
END
