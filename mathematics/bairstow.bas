
'''This program will display the real and imaginary roots for a polynomial of the form f(x)=A0 + A1*x + A2*x^2 +...
''spagetti code in http://www3.sympatico.ca/ltoms/html/bairstow_s_method.html modified by:
''Adolfo Leon Sepulveda
''Aug-01-2004
''Version 1.0

''Test case:

''real and imaginary roots of polynomials
''using bairstow''s method
''form is y = A0 + A1*x + A2*x^2 + A3*x^3 +....

''degree of polynomial: 4

''coefficent of A(0)=  12
''coefficent of A(1)=  -19
''coefficent of A(2)=  12
''coefficent of A(3)=  -6
''coefficent of A(4)=  1

''Roots:

''0.5 + 1.6583124 i
''0.5 - 1.6583124 i

''4.0
''1.0

 
rem roots of polynomials - bairstow''s method
cls
print
print "real and imaginary roots of polynomials"
print "using bairstow''s method"
print "form is y = A0 + A1*x + A2*x^2 + A3*x^3 +...."
print

dim a(22)
Const err=.0001
Const cero=1e-19
Const iter=100

InputData a,n
print
print "Roots:"
Bairstow a,n,err,iter
End


sub InputData( ByRef a(), ByRef n)
local i,xa
input "degree of polynomial: ";n
print
for i=0 to n
 print "coefficent of A(";i;")= ";
 input " ";xa
 rem stored in array a in reverse order
 a(n-i+1)=xa
next i
end


Sub Bairstow(a,n,err,iter)
dim b(22)
dim e(22)
local p, q, p1, q1, r0, r1, v0, v1, s0, s1, d0, d1, d2, s, t
local m1, n1, k, i, h, j
local const cero = 1e-19

rem branch for special treatment of 1st and 2nd degree equations
if n<=2 then 
	OrderLessThan2 a, n
	Exit Sub
endif	
a(n+2)=0
n1=2*int((n+1)/2)
m1 = 1
While true
 If  m1 >= n1 / 2 Then 	Exit loop
 p=1
 q=1
 For k=1 to iter
  while true
   rem store coefficients in array b
    for i=1 to n1+1
     b(i)=a(i)
    next i
    for j=n1-2 to n1-4 step -2
     for i=1 to j+1
      b(i+1) = b(i+1) - p*b(i)
      b(i+2) = b(i+2) - q*b(i)
     next i
    next j
    r0 = b(n1+1)
    r1 = b(n1)
    s0 = b(n1-1)
    s1 = b(n1-2)
    v0 = -q*s1
    v1 = s0 - s1*p
    d0 = v1*s0 - v0*s1
    if abs(d0) >= cero then Exit loop
    p=p+5
    q=q+5
  wend
  
  d1 = s0*r1 - s1*r0
  d2 = r0*v1 - v0*r1
  p1=d1/d0
  q1=d2/d0
  p=p+p1
  q=q+q1
  if !(Abs(r0)>=err or abs(r1)>=err) then
    e(m1)=1
    Exit For
  endif  
  
  
  if !(abs(p1)>=err or abs(q1)>=err) then
    e(m1)=2
    Exit For
  endif  
  
  if p=0 then 
    if !(q=0) Then
     if !(abs(q1/q)>=err) Then
      e(m1)=3
      Exit For   
     endif  
    endif
  Else
    if !(abs(p1/p)>=err) Then 
  	  if !(q=0) Then
        if !(abs(q1/q)>=err) Then
         e(m1)=3
         Exit For 
        endif  
      endif
    endif	
  endif  
 Next k
 If k > iter Then
   e(m1) = 4  ''Is Order 2
 endif  
 
 While true
   s = -p/2
   t = s^2 - q
   if !(t<0) then 
     t=Sqr(t)
     PrintReal s,t
   Else
     t=Sqr(-1*t)
     PrintImag s,t
   endif
 
   If e(m1) = 4 then Exit Sub
   for j=1 to n1-1
    a(j+1) = a(j+1) - p*a(j)
    a(j+2) = a(j+2) - q*a(j)
   next j
   n1 = n1 - 2
   if !(n1>1) Then Exit Sub
 
   if n1>3 then Exit loop
   
   m1 = m1 + 1
   e(m1)=1
   p=a(2)/a(1)
   q=a(3)/a(1)
 Wend
Wend ''m1

end


Sub OrderLessThan2(a(),n)
  If n = 2 Then
   Order2 a
  Else	
   print -a(2)/a(1)
  Endif 
End

sub order2(a())
local s,t
 a(3) = a(2)*a(2) - 4*a(1)*a(3)
 s = -a(2) / (2*a(1))
 t=Sqr(abs(a(3))) / (2*a(1))

 if sgn(a(3))<0 then 
   PrintImag s,t
 Else
   PrintReal s,t
 endif	
End


Sub PrintImag(s,t)
 Print
 If Abs(s) > cero
   print s;" + ";t;" i"
   print s;" - ";t;" i"
 Else
   Print 0;" + ";t;" i"
   print 0;" - ";t;" i"
endif  
End 


Sub PrintReal(s,t)
 print
 If Abs(s+t) > cero
    print s+t
 endif   
 If Abs(s-t) > cero
    print s-t
 endif   
End 
'
