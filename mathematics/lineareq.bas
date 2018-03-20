
'''Solution of equations'' systems
''with cramer''s method
''by Adolfo Leon Sepulveda
''Sep/30/2004
''version 1.0
main

end


sub main()

   dim m_mat(50,50), a_mat(50,50)

   dim  v_vec(50), x(50)
   local i, j, k, n
   local den

   print "Solution to Equations'' Systems with cramer''s method"
   print "Num equations ";
   input n
   print "Input coef: "
   readmat n, n, m_mat
   print "Input constants: "
   readvec n, v_vec
   
   print
   print "Equation System:"
   PrintEqSystem m_mat,v_vec,n
   print
   
   den = det(n, m_mat)
   
   print "Determinant: "; den
   print
   print "Solution: "
   for  i = 0  to n-1
     a_mat = m_mat   '' copia m_mat en a_mat
     cambio_columna n, n, i, a_mat, v_vec
     print "x(";i;")="; det(n, a_mat) / den
   next i
  inversa n, m_mat, a_mat
  print
  print "Inverse matrix of coeficients:"
  matprint a_mat, n, n

end


sub readmat(filas,columnas, byref m_mat)

local  i, j

  for  i = 0 to filas - 1
    for j = 0 to columnas - 1
	  print "a(";i+1;", ";j+1;") : ";
      input m_mat(i,j)
     next j
  next i
end ''readmat



sub readvec(n, byref v_vec)
dim v_vec(50)
local i

  for i = 0 to n -1
    print "b(";i+1;") : ";
    input v_vec(i)
  next i
end ''readvec


''get determinant
func det(n,a_mat)

  local i, j, k, t, f, nxt
  local piv, cn, big, temp, term


  f = 1
  for i = 0 to n - 2
    big = 0
    for k = i to n - 1
  	  term = abs(a_mat(k,i))
  	  if  term > big  then
              big = term
              t = k
	  endif
	next k
	if ( i - t != 0 ) then   f = -f
	for j = 0 to  n - 1
        temp = a_mat(i,j)
	    a_mat(i,j) = a_mat(t,j)
	    a_mat(t,j) = temp
    next j
    piv = a_mat(i,i)
    nxt = i + 1
	for j = nxt to n - 1
	    if ( piv != 0 ) then  cn = a_mat(j,i) / piv
	    for k = i to n + 1
	      a_mat(j,k) = a_mat(j,k) - cn * a_mat(i,k)
	    next k
	next j
  next i	
  temp = 1.0
  for i = 0  to  n - 1
    temp = temp * a_mat(i,i)
  next i
  det = temp * f
end



sub cambio_columna(filas, columnas, destino, byref m_mat, nueva_columna)

 local i

 for i = 0 to filas -1
    m_mat(i,destino) = nueva_columna(i)
 next i
end



sub matprint(m_mat, f, c)

local i, j

 for i = 0 to f - 1
   for j = 0 to c-1
     print using "###,###.00";m_mat(i,j);
   next j
   print
 next i
end


sub intercambio(n,k,byref a_mat, byref c_vec)
    local e,j
    for j = 0 to n-1
      e = c_vec(j)
 	  c_vec(j) = a_mat(j,k)
	  a_mat(j,k) = e
	next j
end ''intercambio


sub solucion(n, a_mat, coef, byref x)
  local  k,d

  d = det(n, a_mat)
  for k =0 to n-1
      intercambio n, k, a_mat, coef
      x(k) = det(n, a_mat) / d
      intercambio n, k, a_mat, coef
  next k

end

''get invert matrix
sub inversa(n, m_mat, byref a_mat)

  dim i_vec(50), tmp_vec(50)
  local j, k

  for j = 0 to  n-1
    i_vec(j) = 0.0
  next j
  if det(n,m_mat) = 0.0 then
      print "Singular Matrix"
      exit sub
  endif
  for j = 0  to  n-1
	  i_vec(j) = 1.0
	  solucion n, m_mat, i_vec, tmp_vec
	  cambio_columna n, n, j, a_mat, tmp_vec
	  i_vec(j) = 0.0
  next j

end ''inversa


sub PrintEqSystem(a,b,n)
local i,j
for i = 0 to n-1
  for j= 0 to n-1
	if j = n-1  then
  	  print using "###,###.00"; a(i,j);
	  print using "###,###.00"; b(i)
  	else
   	  print using "###,###.00"; a(i,j);
  	endif
  next j
next i
end'
