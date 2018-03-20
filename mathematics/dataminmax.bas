
'rem Data Peak Finder
rem Adapted for SMALLBASIC by CARSTEN
rem Original from 
rem www3.sympatico.ca/ltoms/html/peak_finder.html

label loop
cls
print
print "Data Peak Finder Using Least Squares"
print "     equally spaced points"
print

REM enter data

dim y(100)
dim z(100)

rem data entry
input "Number of points to input? ";n
label dleap
input "Use keyboard (k) or read from data (d)? ";c$
if c$="k" then
 for i=1 to n
  print "y(";i;")= ";
  input " ";y1
  y(i)=y1
 next i
end if
if c$="d" then
 for i=1 to n
  read y1
  y(i)=y1
 next i
end if
if c$<>"d" and c$<>"k" then goto dleap

rem mode of operation
print "Chose mode:"
print "  1.  Absolute max and min.  "
print "  2.  Calculated max and min."
print "  3.  Quit."
print
label again
input "(1,2,3) ";q
if q=1 then gosub absolute
if q=2 then gosub relative
if q=3 then end
gosub again
print

rem absolute min and max
label absolute
a=y(3)
b=y(3)
j=3
k=3
for r=3 to n-2
 if a> y(r) then
  goto aleap
 else
  a=y(r)
  j=r
 end if
 goto bleap
 label aleap
 if y(r)> b then
  goto bleap
 else
  b=y(r)
  k=r
 end if
 label bleap
next r
gosub fit
gosub prin
return

rem find deriative
label relative
for k=3 to n-2
 z(k)=y(k+1)-y(k-1)+2*(y(k+2)-y(k-2))
 z(k)=z(k)/10
next k
z(1)=z(3)
z(2)=z(3)
z(n)=z(n-2)
z(n-1)=z(n)
rem find zeros
for k=4 to n-2
 t=z(k)*z(k-1)
 if t>= 0 then goto rleap
 j=k
 gosub fit
 u=x
 j=k-1
 gosub fit
 if abs(x)< abs(u) then goto sleap
 j=k
 gosub fit
 label sleap
 gosub prin
 label rleap
next k
return

rem calculate coefficients of parabolic fit
label fit
c=17*y(j)+12*(y(j-1)+y(j+1))-3*(y(j-2)+y(j+2))
c=c/35
d=y(j+1)-y(j-1)+2*(y(j+2)-y(j-2))
d=d/10
e=2*(y(j-2)-y(j)+y(j+2))-y(j-1)-y(j+1)
e=e/7
if e=0 then goto mleap
x=-1*d/e
p=c+(d+e*x/2)*x
b$="Max= "
if e< 0 then goto nleap
b$="Min= "
goto nleap
label mleap
b$="Indeterminate "
x=0
p=0
label nleap
return

label prin
print
print b$;p;" at x= ";j+x
print
return

data 84,85,83,105,108,123,107,96,102,92
data 111,93,102,76,78,64,64,61,54,51

end'
