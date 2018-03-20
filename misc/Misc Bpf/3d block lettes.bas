'3d Block Letters.bas for SmallBASIC 2015-08-30 MGA/B+ combine 2 recent code creations 
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
color 15,0:cls
for z=1 to 128
for row = yd to 1 step-1
   for col=1 to xd
     if dat(col,row)="O" then cube 10*col+z,10*row+z,z
   next col
next row
next z
sub cube(x,y,c)
   for i=0 to 2
      line x+i,y+i,x+6+i,y+i,rgb(c*1.9,c*1.9,c+127)
      line x+i,y+i+1,x+i,y+7+i,rgb(0,0,1.9*c)
   next
   rect x+3,y+3,x+10,y+10,rgb(1.9*c,0,0) filled
end 