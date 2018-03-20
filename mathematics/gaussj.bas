
'''gaussj.bas
''version 1.0
''by adolfo leon sepulveda
'' 20/08/2004
''solve a nxn equation system with gauss jordan method
''It''s equivatent to LinEqn function of SmallBASIC
''example:
'' 0x+1y=1
'' 1x+1y=2
''
''Input:
'' Nro Equat: 2
''  a(1,1) : ? 0
''  a(1,2) : ? 1
''  b(1) : ? 1
''  a(2,1) : ? 1
''  a(2,1) : ? 1
''  b(2) : ? 2

'' result:
'' x=1
'' y=1
'' invert matrix:
'' -1 1
''  1 0

n=0
dim a(50,50)
dim x(50)

main

End ''program



sub main()
 readata a,x,n
 gaussj a,x,n
 Printinversa a,n
 Printsolution x,n
end

sub  readata( byref a, byref x, byref n)
print "gauss jordan"
print "nro equat:  ";
input n
print "coef y term indep "

for i=0 to n-1
  for j=0 to n
    if j<>n then
      print "a(";i+1;", ";j+1;") : ";
    else
        print "b(";i+1;") : ";
    endif
    input a(i,j)
   next
   x(i)=a(i,n)
next

end

sub gaussj(byref a, byref b,n)
local mayor,tmp,pivinv
dim indco(50),indfi(50),piv(50)

local i,j,k,t,h,col,fil
for j = 0 to n-1
  piv(j)=0
next j
for i = 0 to n-1
  mayor = 0.0
  for j = 0 to n-1
     if piv(j) <> 1 then
       for k = 0 to n-1
          if piv(k) = 0 then
           if abs(a(j,k)) >= mayor then
             mayor = abs(a(j,k))
             fil = j
             col = k
           endif
          elseif piv(k) > 1 then
             print "error: singular matrix"
             Exit Sub
           endif
       next 
      endif
   next 
   piv(col) = piv(col)+1
   if fil <> col then
     for t = 0 to n-1
       tmp = a(fil,t)
        a(fil,t)  = a(col,t)
        a(col,t) = tmp
     next
     tmp = b(fil)
     b(fil) = b(col)
     b(col) = tmp
  endif
  indfi(i) = fil
  indco(i) = col
  if a(col,col) = 0 then
    print "error: singular matrix"
    Exit Sub
  endif
  pivinv= 1.0/a(col,col)
  a(col,col) = 1.0
  for t=0 to n-1
    a(col,t) = a(col,t)*pivinv
  next
  b(col) = b(col)*pivinv
  for h = 0 to n-1
   if h <> col then
     tmp = a(h,col)
      a(h,col) = 0.0
      for t = 0 to n-1
         a(h,t) = a(h,t) - a(col,t)*tmp
      next 
      b(h) = b(h) - b(col)*tmp
   endif
  next 
next 
for t = n-1 to 0
  if indfi(t) <> indco(t) then
    for k = 0 to n - 1
      tmp = a(k,indfi(t)) = a(k,indco(t))
       a(k,indco(t)) = tmp
    next 
  endif
next 
end

sub Printsolution(x,n)
 print "solucion"
for j=0 to n-1
  print "x";j+1;"=";x(j)
next
end

sub Printinversa(a,n)
print "matriz inversa"
for i=0 to n-1
  for j=0 to n-1
    print using "##0.00"; a(i,j);
   next
   print
next
end

'
