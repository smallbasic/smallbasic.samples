

'program to solve a matrix equation of the form [a]*[b]=[c]
'[a] is a known square matrix
'[b] is an unknown matrix with the same number of rows as [a] has columns
'[c] is a known matrix

'edit matrix size and element values below - data line = row

'known square matrix
ranka = 6:rowsc=ranka:rowsb=ranka
DATA 3,6,10,-6,14,-17
DATA 1,1,4,7,-11,3
DATA 2,1,1,-2,-4,2
DATA -3,4,-5,9,8,13
data 7,-7,3,5,-6,12
data -2,-14,16,18,5,6

'edit [c] size and element values below - data line = row
colsc=4:colsb=colsc
data -1,5,-1,4
data 9,-5,-6,9
data 2,5,3,1
DATA 1,-5,7,-3
data 1,9,7,-6,
data 7,6,5,-4

DIM coefs(ranka, ranka + 1): DIM deter(ranka, ranka)
DIM numbs(ranka + 1): DIM answers(ranka, ranka)
DIM matb(ranka,colsb): DIM matc(ranka,colsb): DIM temp(ranka)
DIM mata(ranka,ranka):DIM matd(ranka, colsb)

'calculate the inverse of [a] called [answers]

'load values into array
FOR tt = 1 TO ranka
FOR qq = 1 TO ranka
READ coefs(tt, qq)
mata(tt,qq)=coefs(tt,qq)
coefs(tt, ranka + 1) = 0
NEXT qq
NEXT tt
CLS
IF ranka = 2 THEN GOTO 300

'create working determinate
FOR rr = 1 TO ranka
FOR cc = 1 TO ranka
deter(rr, cc) = coefs(rr, cc)
NEXT cc
NEXT rr

'evaluate determinate denominator without substitution
GOSUB 1000
numbs(ranka + 1) = DIAG

'create unit column
FOR qq = 1 TO ranka
coefs(qq, ranka + 1) = 1

'begin unit column substitution

'ff sets columns
FOR ff = 1 TO ranka

'uu sets row qq, column ranka+1 to 0 or 1
FOR uu = 1 TO ranka
deter(uu, ff) = coefs(uu, ranka + 1)
NEXT uu

'sub to evaluate deter with substitution
GOSUB 1000

'numbs stores matrix value when column ff is 1
numbs(ff) = DIAG
NEXT ff

FOR zz = 1 TO ranka
answers(zz, qq) = numbs(zz) / numbs(ranka + 1)
NEXT zz
PRINT
coefs(qq, ranka + 1) = 0
NEXT qq

'load [c]
FOR jj = 1 TO ranka
for gg= 1 to colsc
READ matc(jj,gg)
next gg
NEXT jj

'echo matrix [c]
print "MATRIX c"
FOR x = 1 TO ranka
for y=1 to colsb
PRINT using "##.####   "; matc(x,y) ,
next y
print
NEXT x
print

'[a] inv * [c] = [b] the unknown
'outer loop selects matrix element
FOR rr = 1 TO ranka
for cc= 1 to colsb
'inner loop
FOR n = 1 TO ranka
matb(rr,cc) = matb(rr,cc)+answers(rr, n) * matc(n,cc)
NEXT n
next cc
NEXT rr

print "MATRIX b"
FOR x = 1 TO ranka
for y=1 to colsb
PRINT using "##.####   "; matb(x,y) ,
next y
print
NEXT x
'***********************************************************
'outer loop selects product matrix element
print
print " check: recalculate matrix c by [a]*[b]"
FOR rr = 1 TO ranka
FOR cc = 1 TO colsc
'inner loop uses factor matrices to compute product
FOR n = 1 TO ranka
matd(rr, cc) = matd(rr, cc) + mata(rr, n) * matb(n, cc)
NEXT n
NEXT cc
NEXT rr

FOR x = 1 TO ranka
FOR y = 1 TO colsc
print using "##.####  "; matd(x, y),
NEXT y
print
NEXT x
'************************************************************
GOTO 2000

'special case of 2x2
300 denom = coefs(1, 1) * coefs(2, 2) - coefs(1, 2) * coefs(2, 1)
FOR qq = 1 TO 2

'set 3rd column equal to one
coefs(qq, ranka + 1) = 1
answers(1, qq) = (coefs(1, 3) * coefs(2, 2) - coefs(1, 2) * coefs(2, 3)) / denom
answers(2, qq) = (coefs(1, 1) * coefs(2, 3) - coefs(1, 3) * coefs(2, 1)) / denom
PRINT
PRINT "Results for column "; qq
FOR zz = 1 TO ranka
PRINT
PRINT answers(zz, qq)
NEXT zz
coefs(qq, ranka + 1) = 0
NEXT qq

GOTO 2000

'evaluate deter
1000
s = 1
FOR row = 1 TO ranka - 1

'check for zeros on the diagonal

IF deter(row, row) <> 0 THEN GOTO 50
FOR r = 1 TO ranka
temp(r) = deter(r, row)
deter(r, row) = deter(r, row + 1)
deter(r, row + 1) = temp(r)
NEXT r
s = s * (-1)

'make constants zero in first col, second,...
50 FOR r = row TO ranka - 1
fact = deter(r + 1, row) / deter(row, row)
FOR col = 1 TO ranka
deter(r + 1, col) = deter(r + 1, col) - fact * deter(row, col)
NEXT col
NEXT r
NEXT row

'calculate the diagonal product

DIAG = s
FOR d = 1 TO ranka
DIAG = DIAG * deter(d, d)
NEXT d

'restore working deter
FOR rr = 1 TO ranka
FOR cc = 1 TO ranka
deter(rr, cc) = coefs(rr, cc)
NEXT cc
NEXT rr

RETURN
2000 END
