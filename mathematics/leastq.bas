
'''This program get:
''Power regression y= aX^b
''Exponential regression y=ae^(bx)
''Polynomial regression Ao +A1x + A2x^2...
''by least squares'' method
''Too, calculate interpolation. Given a x value get a y value
''Put data on subroutine ReadData
''Adapted of Numerical repices in C, chapter 15.4: http://www.library.cornell.edu/nr/bookcpdf.html
''by Adolfo Leon Sepulveda
''Sep-30-2004
''Version 1.0


option base 1 ''arrays init on 1
cls

menu
end

''****************
sub menu()
dim x(50),y(50), a(20,20),b(20)
local cx,cy
cx=0
cy=0

While true
   cls
   locate 1,5:print "Least Squares"
 
   locate 2,1 : print "1. Power regression y= aX^b"
   locate 3,1 : print "2. Exponential regression y=ae^(bx)"
   locate 4,1 : print "3. Polynomial regression Ao +A1x + A2x^2..."
   locate 5,1 : print "4. Quit"
   locate 6,1 : print "put tap on option"
   WaitTap cx, cy

	   
   If cy>10 and cy<20 and cx >1 and cx<150 then
  	Power
   elseif cy>21 and cy<30 and cx >1 and cx<150 Then
   	expon
   elseif cy>31 and cy<40 and cx >1 and cx<150 Then
   	poly
   elseif cy>41 and cy<50 and cx >1 and cx<150 Then
   	Exit loop
   else
    locate 9,1: print "put tap on option"
    pause 1
    locate 9,1: print spc(32)
   endif

wend
end

''****************
sub ReadData(byref x(), byref y(), byref NumData, opt)

   if opt = 1 then ''power regression data
	 restore ReadDataopt1
	 ExecRead x,y,NumData
	 label ReadDataopt1
     data 5                         ''num data
	 data 28,30,33,35,38            ''x data
	 data 2410,3033,3895,4491,5717  ''y data
     ''fit: y=0.238801069 x^2.771866158
   elseif opt = 2 then  ''exponential regression data
     restore ReadDataopt2
   	 ExecRead x,y,NumData
   	 label ReadDataopt2
     data 5
     data 6.9,12.9,19.8,26.7,35.1
	 data 21.4,15.7,12.1,8.5,5.2
    ''fit  y=30.497587426 exp(-0.049203708x)
   elseif opt = 3 then  '' polynomial regression data
     restore ReadDataopt3
 	 ExecRead x,y,NumData
 	 label ReadDataopt3
     data 6
     data 20,30,40,50,60,70
     data 54,90,138,206,292,396
    ''fit to poly order 2:   y= 41.771428571 - 1.095714286x + 0.087857143x^2
   endif
	

end

sub ExecRead(byref x(), byref y(), byref NumData)

   read NumData
   for i=1 to NumData
     read x(i)
   next i
	
   for i=1 to NumData
	 read y(i)
   next i
 end


''*****************
sub power()
local i,j,k
dim a(20,20),b(20),x(20),y(20)

	 ReadData x,y,NumData,1
	 
	 for i=1 to NumData
	  y(i) = log(y(i))
	  x(i) = log(x(i))
	 next i
	 BuildMat x,y,NumData,a,b,2
	 gaussj a,b,2
	 PrintPow b,NumData
	 EvaluatePow b
end

''*************
sub PrintPow(b(),NumData)
local c,s,i,z
  c = exp(b(1))
  print " "
  print "Power regression y= aX^b"
  print "y="; c; " x^";b(2)
  print " "
  '' return original points
  for i = 1 to NumData
	y(i) = exp(y(i))
	x(i) = exp(x(i))
  next i
  print " "
  s=0
  print "        x         y          Fit"
  for i = 1 to NumData
     z = c*x(i)^b(2)
     s = s + (y(i)-z)^2
     print format("###,###.000",x(i)); " "; format("###,###.000",y(i)); " "; format("###,###.000",z)
  next i
  print "Chi2: "; s
end


''************
sub EvaluatePow(b())
local x,y,s

while true
  s=""
  print
  print "Interpolation (enter x value or ''e'' to exit) ";
  input "x= ";s
  if s IN "Ee" then
   exit sub
  endif
  x=val(s)
  y = exp(b(1)) * x ^ b(2)
  print "y= ";y
wend
end



''*****************
sub expon()
local i,NumData
dim a(20,20),b(20),x(20),y(20)
	 ReadData x,y,NumData,2
	 for i=1 to NumData
	   y(i) = Log(y(i))
	 next i
	 BuildMat x,y,NumData,a, b, 2
	 gaussj a,b,2
	 PrintExpon b,NumData
	 EvaluateExpon b
end

''*******************
sub PrintExpon(b(),NumData)
local c,s,i,z
  c = exp(b(1))
  print " "
  print "Exponential regression y=ae^(bx):"
  print "y="; c; " exp(";b(2);"x)"
  print " "
  '' return to original y data
  for i = 1 to NumData
	y(i) = exp(y(i))
  next i
  print " "
  print "        x         y          Fit"
  s=0
  for i = 1 to NumData
     z = c*exp(b(2)*x(i))
     s = s + (y(i)-z)^2
     print format("###,###.000",x(i)); " "; format("###,###.000",y(i)); " "; format("###,###.000",z)
  next i
  print "Chi2: "; s
end


''**********
sub EvaluateExpon(b())
local x,y,s

while true
  s=""
  print
  print "Interpolation (enter x value or ''e'' to exit) ";
  input "x= ";s
  if s IN "Ee" then
   exit sub
  endif
  x=val(s)
  y = exp(b(1)) * exp(x * b(2))
  print "y= ";y
wend
end



''**************
sub poly
local chisq, i,j,NumData,Degree,StdErr,r2
dim b(20)
dim covar(20,20)
dim x(20),y(20),FitTerm(20),sig(20)

const spread=1

Input "Enter degree of poly to fit"; Degree
ReadData x,y,NumData,3

FOR i = 1 to NumData
   sig(i) = spread
next j
for i=1 to Degree+1
   FitTerm(i)=1
next i
lfit x,y,sig,NumData,b,FitTerm,Degree,covar,chisq,r2,StdErr
PrintPoly b,Degree,NumData
PrintData x,y,NumData, b, Degree
print "chi2="; chisq
print "coeff of determination (r^2)= ";r2
print "coeff of correlation= ";r2^.5
print "standard error estimate= ";StdErr
Print
print "Covariance Matrix"
PrintMat covar,Degree+1
EvaluatePoly b, Degree+1
end


''****************
sub Lfit(x(),y(), sig(),ndata, byref b(), FitTerm(), Degree, byref covar()(), byref chisq, byref r2, byref StdErr)
''Given a set of data points x(1..ndata), y(1..ndata) with individual standard deviations
''sig(1..ndata), use chi2 minimization to fit for some or all of the coefficients b(1..Degree+1) of
''a function that depends linearly on b, y = SUMi bi AFUNCi(X). The input array FitTerm(1..Degree+1)
''indicates by nonzero entries those components of a that should be fitted for, and by zero entries
''those components that should be held fixed at their input values. The program returns values
''for b(1..Degree+1), chi2 (chisq), coeff of determination (r2), Standard Error (StdErr)
'' and the covariance matrix covar(l..Degree+1, l..Degree+1).
''(Parameters held fixed will return zero covariances.)  The routine funcs (x, afunc,Degree+1)
''returns the Degree+1 basis of polynomial evaluated at x in the array afunc(1..Degree+1)
''http://www.library.cornell.edu/nr/bookcpdf/c15-1.pdf

local   k,kk,j,i,h,Sumy2,z,v,p,q
local   ym,wt,suma,sig2i, NumTerms
dim  bx(20), afunc(20),bxOrig(20), covarOrig(20,20)

   NumTerms = Degree + 1

   mfit=0
   for j=1 to NumTerms
		if FitTerm(j) then mfit = mfit + 1
   next j	
   if mfit = 0 then
     print "lfit: no parameters to be fitted"
     input xx
     exit sub
   endif
   FOR j = 1 TO NumTerms
      FOR k = 1 TO NumTerms
         covar(j,k) = 0.0
	  next k
      bx(j) = 0.0
   next j
   FOR i = 1 TO ndata

      funcs x(i),afunc,NumTerms
      ym = y(i)
      if mfit < NumTerms then
		for j=1 to NumTerms
			if !FitTerms[j] then ym = ym - b(j)*afunc(j)
		next j	
	  endif			
      sig2i = 1.0/sig(i)^2

      j=0
      FOR h = 1 TO NumTerms
	    if FitTerm(h) then
           wt = afunc(h)*sig2i
           j=j+1
           k=0
           FOR m = 1 TO h
		      k=k+1
              if FitTerm(m) then covar(j,k) = covar(j,k)+wt*afunc(m)
		   next m
           bx(j) = bx(j)+ym*wt
        endif
      next h
   next i

   FOR j = 2 TO mfit
       FOR k = 1 TO j-1
          covar(k,j) = covar(j,k)
       next k
   next j
   bxOrig = bx
   covarOrig = covar
   gaussj covar,bx,mfit
   j=0	
   FOR h = 1 TO NumTerms
     if FitTerm(h) then
	   j = j + 1
	   b(h) = bx(j)
	 endif
   next h
   chisq = 0.0
   Sumy2=0
   FOR i = 1 TO ndata
      funcs x(i),afunc,NumTerms
      suma = 0.0
      FOR j = 1 TO NumTerms
         suma = suma+b(j)*afunc(j)
      next j
      chisq = chisq + ((y(i)-suma)/sig(i))^2
      Sumy2 = Sumy2 + y(i)^2
   next i
   
   p=0
   for j=2 to Degree+1
     p= p + b(j) * (bxOrig(j) - covarOrig(j,1)*bxOrig(1) / nData)
   next j
   q = Sumy2 - bxOrig(1)^2/nData
   z=q-p
   v = nData - Degree - 1
   r2 = p/q
   if v > 0 then StdErr = (z/v)^.5 else StdErr = 0
   covsrt covar, NumTerms, FitTerm, mfit
END


''**************
sub funcs(x, byref afunc(), NumTerms)
''generate array afunc(1) = 1, afunc(2) = x, afunc(3) = x^2, afunc(4)= x^3,...
'' evalute on  x
local i
   afunc(1) = 1.0
   FOR i = 2 to NumTerms
      afunc(i) = x*afunc(i-1)
   next i
END

''****************
sub covsrt(covar()(), NumTerms, FitTerm(), mfit)
''Expand in storage the covariance matrix covar, so as to take into account parameters that
''are being held fixed. (For the latter, return zero covariances.)

	local i,j,k,h

	for i=mfit+1 to NumTerms
		for j=1 to i
		   covar(i,j) = 0.0
		   covar(j,i) = 0.0
		next j
	next i	
	k=mfit
	for h = 1 to NumTerms
	    j = NumTerms - h + 1
		if FitTerm(j) then
			for i=1 to NumTerms
			   SWAP covar(i,k),covar(i,j)
			next i
			for i=1 to NumTerms
			   SWAP covar(k,i),covar(j,i)
			next i
			k = k -1
		endif
	next h
end



''***********
sub gaussj(byref a()(), byref b(), m)

local big,dum,pivinv,i,icol,irow,j,k,h,f
dim indxc(50),indxr(50),ipiv(50)

   FOR j = 1 TO m
      ipiv(j) = 0
   next j
   FOR i = 1 TO m
      big = 0.0
      FOR j = 1 TO m
         IF ipiv(j) <> 1 THEN
            FOR k = 1 TO m
               IF ipiv(k) = 0 THEN
                  IF abs(a(j,k)) >= big THEN
                     big = abs(a(j,k))
                     irow = j
                     icol = k
                  ENDIF
               ELSEIF ipiv(k) > 1 THEN
                  print "pause 1 in GAUSSJ - singular matrix"
                  input xx
                  exit sub
               ENDIF
            next k
         ENDIF
      next j
      ipiv(icol) = ipiv(icol)+1
      IF irow <> icol THEN
         FOR h = 1 TO m
            dum = a(irow,h)
            a(irow,h) = a(icol,h)
            a(icol,h) = dum
         next h
         dum = b(irow)
         b(irow) = b(icol)
         b(icol) = dum
      ENDIF
      indxr(i) = irow
      indxc(i) = icol
      IF a(icol,icol) = 0.0 THEN
         print "pause 2 in GAUSSJ - singular matrix"
         input xx
         exit sub
      ENDIF
      pivinv = 1.0/a(icol,icol)
      a(icol,icol) = 1.0
      FOR h = 1 TO m
         a(icol,h) = a(icol,h)*pivinv
      next h
      b(icol) = b(icol)*pivinv
      FOR f = 1 TO m
         IF f <> icol THEN
            dum = a(f,icol)
            a(f,icol) = 0.0
            FOR h = 1 TO m
               a(f,h) = a(f,h)-a(icol,h)*dum
            next h
            b(f) = b(f)-b(icol)*dum
         ENDIF
      next f
   next i
   FOR i = 1 TO m
      h = m - i + 1
      IF indxr(h) <> indxc(h) THEN
         FOR k = 1 TO m
            dum = a(k,indxr(h))
            a(k,indxr(h)) = a(k,indxc(h))
            a(k,indxc(h)) = dum
         next k
      ENDIF
   next i
END


''****************
sub PrintPoly(b(),n,NumData)
local i
  print
  print "Polynomial regression Ao +A1x + A2x^2..."

  if b(2) >= 0 then
	print "y= "; b(1);" + ";b(2);"x";
  else
    print "y= "; b(1);" - ";abs(b(2));"x";
  endif
  if n+1 > 2  then
    for i = 3 to n+1
      if b(i) >= 0 then
        print " + ";b(i);"x^";i-1;
      else
        print " - ";abs(b(i));"x^";i-1;
      endif
    next i
  endif
  print
  print
end


''****************
sub PrintData(x(),y(),NumData, b(), Degree)
local s,i,z
  s=0
  print "Data: "
  print "          x         y        Estimate"
  for i= 1 to NumData
     z = b(1)
     for j= 2 to Degree+1
       z = z + b(j) * x(i)^(j-1)
     next j
     s = s + (y(i) - z)^2
     print format("###,###.000",x(i)); " "; format("###,###.000",y(i)); " "; format("###,###.000",z)
  next i
  print
end




''****************
sub EvaluatePoly(b(),NumTerms)
local x,y,s
dim a(20)

while true
  s=""
  print
  print "Interpolation (enter x value or ''e'' to exit) ";
  input "x= ";s
  if s IN "Ee" then
	cls
    exit sub
  end if
  x=val(s)
  funcs x, a, NumTerms
  y = 0
  FOR j = 1 TO NumTerms
     y = y + b(j) * a(j)
  next j
  print "y= ";y
wend
end



''***************
sub BuildMat(x(),y(),NumData, byref a()(), byref b(), n)
local i,j,k
	 for i=1 to n
	   for j=1 to n
	     if i+j > 2 then
	       for k = 1 to NumData
	         a(i,j) = a(i,j)+ x(k)^(i+j-2)
	       next k
	     else
	       a(i,j) = NumData
	     endif
	   next j
	   for k = 1 to NumData
	     if i > 1 then
	       b(i) = b(i) + y(k) * x(k)^(i-1)
	     else
	       b(i) = b(i) + y(k)
	     endif
       next k
	 next i  
end

''*****************
Sub PrintMat(a()(),n)
 for i=1 to n
   for j=1 to n
     print using "#,###,###.00000"; a(i,j);
   next j
   print
 Next i  

End	 

''************
sub WaitTap(byref cx, byref cy)
  pen on
  repeat
  until pen(0) <> 0
  cx=pen(4)
  cy=pen(5)
  pen off
end




'
