
'''NewtonRaphson.bas
''19/11/2002
''Version 1.0
''By Adolfo Leon Sepulveda
''Get a function''s root by Newton-Raphson Method
''example:
'' Function: f(x)= x^2 - 4
'' Input:
''  x0 : 4
'' Result:
'' Raiz = 2

Declare func f(x)
Declare func fdx(x,dx)
Declare func NewtonRaphson(x0,h,iter, byref status)

const dx=1.0e-6
const iter=100
status = 0

input "x0: ",x0
raiz  = NewtonRaphson(x0,dx,iter, status)
if status then
  print
  print "Raiz = ";raiz
else
  print "function No converge"
endif

end


func NewtonRaphson(x0,dx,iter, byref status)
local i,x
print "     x       f(x)        f''(x)"
i=1
repeat

  x = x0 - f(x0) / fdx(x0,dx)
  error = abs((x-x0)/x0)

  print using "###0.0000  ###0.0000  ###0.0000" ;x0,f(x0),fdx(x0,dx)
  if error < dx then  exit loop

  x0 = x
  i=i+1

until i > iter

if i > iter then
  status = 0
  NewtonRaphson = 0
else
  status = 1
  NewtonRaphson = x
endif
end


func f(x)

f= x^2-4.0
end

func fdx(x,dx)
local a,b,c,d
''Richardson''s  extrapolation for first derived
''-1 / (6*h) * (f(x+h) - 8*f(x + h/2) - f(x-h) + 8*f(x-h/2))
   a = f(x+dx)
   b = f(x + dx/2.0)
   c = f(x-dx)
   d = f(x-dx/2.0)

   fdx = -1.0 / (6.0*dx) * (a - 8.0*b - c + 8.0*d)
 end
'
