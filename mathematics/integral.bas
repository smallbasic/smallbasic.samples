
'#sec:Main
'' integral.bas
'' 06/09/2004
''Version 1.0
''By Adolfo Leon Sepulveda
''Get integral  by trapezoidal & simpson methods
''example §1/(x+1)dx  [0,1]"
''Result:
''integral =  0.69314
declare func f(x)
declare func trapezoidal(a,b)
declare func simpson(a,b)
declare func trapecio(a,b,n,byref glit, byref s)

a=0
b=1
print "integral trapezoidal & simpson method §1/(x+1)dx  [0,1]"
print "processing trapezoidal..."

integral = trapezoidal(a,b)
print "Trapezoidal method: ";integral
print "processing simpson''s method..."
integral = simpson(a,b)
print "Simpson''s method: ";integral
end


func f(x)
f = 1/(1+x)
end

func simpson(a,b)
const eps= 1e-6
const jmax =20
local j,st,ost,os,s,sx

glit=1
sx = 0
ost=-1e30
os = -1e-30
for j=1 to jmax
  st= trapecio( a, b, j ,glit,sx)
  s = (4*st - ost)/3
  if abs(s-os) < eps * abs(os) then
    simpson = s
     exit func
  endif
  os = s
  ost = st
next j
print "no converge"
end


func trapezoidal(a,b)
const eps=1e-6
const jmax=20
local j,olds,s,glit

sx=0
glit = 1
olds=-1e30
''print "iter   area"
for j=1 to jmax
  s= trapecio( a, b, j,glit,sx)
  '' print j,s
  if abs(s-olds) < eps * abs(olds) then
    trapezoidal = s
    exit func
  endif
  olds = s
next j
print "no converge"
end

func trapecio(a,b,n,byref glit, byref s)
''byref glit and byref s substitute the concept of static variable
''(retain the last value)
local x,tnm,suma,delta,j
if n=1 then
  s = (b-a)/2 * (f(a) + f(b))
  glit = 1
else
  tnm = glit
  delta = (b-a)/tnm
  x = a + delta/2
  suma = 0
  for j = 1 to glit
     suma = suma + f(x)
     x = x + delta
  next j
  s = 1/2 * (s + (b-a) * suma / tnm)
  glit = glit * 2
endif
trapecio = s
end


'
