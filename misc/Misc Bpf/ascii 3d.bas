'ascii 3d.bas for SmallBASIC 2015-08-28 MGA/B+
option base 1
name="SmallBASIC"   'here is a different way to get letter data (not the greatest but fast)
? name
ln=len(name)
xd=ln*9
yd=16  
dim dat(xd,yd)
for y=1 to yd
   for x=1 to xd
      if point(x,y)<>point(0,0) then dat(x,y)="O" else dat(x,y)=" "
   next
next
cls

for row = 1 to yd
   l$=""
   for ch=1 to xd
      l$=l$+dat(ch,row)
   next ch
   n$ = ""
   for i = 1 to len(l$)
      c$ = mid$(l$, i, 1)
      if c$ = "O" then
         n$ = n$ + "@\\"
      else
         n$ = n$ + c$ + c$
      end if
   next i
   print n$
next row