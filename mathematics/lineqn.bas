
'''Howto using the SmallBasic Subroutine LinEqn
''for Solution Systems'' Equations
''with dim declared arrays
''by Adolfo Leon Sepulveda
''Sep/30/2004
dim a(2,2) ''array of 3x3
Dim b(2,0) ''array of 3x1
a(0,0)=5
a(0,1)=-2
a(0,2)=3

a(1,0)=-2
a(1,1)=7
a(1,2)=5

a(2,0)=3
a(2,1)=5
a(2,2)= 6

b(0,0)=-2
b(1,0)=7
b(2,0)=9

print "System Eq:"
for i = 0 to 2
  for j = 0 to 2
    print using " +###.00";a(i,j);
    print " x";j+1;
  next j
  print " = ";
  print using "###.00";b(i,0)
next i
Print
''**************
c=LinEqn(a,b)
''**************
for i = 0 to 2
  print "x";i+1;" =";
  print using "###.00";c(i,0)
next i
Print
end

'
