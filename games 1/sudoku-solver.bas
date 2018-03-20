
label reset
dim saved(81)
dim answer(81)
dim known(81)
dim test(81)
for z=1 to 81
known(z)="0"
A="0"
next

'' known cells assigned numbers	1,2,3,4,5,6,7,8,9
''                               10,11,12,13,14 ...
LABEL START
''                               19,20.....
 
''Columns A-I
''Rows 1-9
''this list assigns known cell value to its row/column reference

A1=known(1)
B1=known(2)
C1=known(3)
D1=known(4)
E1=known(5)
F1=known(6)
G1=known(7)
H1=known(8)
I1=known(9)
A2=known(10)
B2=known(11)
C2=known(12)
D2=known(13)
E2=known(14)
F2=known(15)
G2=known(16)
H2=known(17)
I2=known(18)
A3=known(19)
B3=known(20)
C3=known(21)
D3=known(22)
E3=known(23)
F3=known(24)
G3=known(25)
H3=known(26)
I3=known(27)
A4=known(28)
B4=known(29)
C4=known(30)
D4=known(31)
E4=known(32)
F4=known(33)
G4=known(34)
H4=known(35)
I4=known(36)
A5=known(37)
B5=known(38)
C5=known(39)
D7=known(40)
E5=known(41)
F5=known(42)
G5=known(43)
H5=known(44)
I5=known(45)
A6=known(46)
B6=known(47)
C6=known(48)
D6=known(49)
E6=known(50)
F6=known(51)
G6=known(52)
H6=known(53)
I6=known(54)
A7=known(55)
B7=known(56)
C7=known(57)
D7=known(58)
E7=known(59)
F7=known(60)
G7=known(61)
H7=known(62)
I7=known(63)
A8=known(64)
B8=known(65)
C8=known(66)
D8=known(67)
E8=known(68)
F8=known(69)
G8=known(70)
H8=known(71)
I8=known(72)
A9=known(73)
B9=known(74)
C9=known(75)
D9=known(76)
E9=known(77)
F9=known(78)
G9=known(79)
H9=known(80)
I9=known(81)

cls
color 4
at 740,0
print"Sudoku Solver"
at 740,15
Print" Sean  Nixon "
													''Draw Box
color 2
rect 0,0,80,50, 11 filled
at 8,16
print "Reset all"

color 2
rect 0,60,40,110, 11 filled
at 8,76
print "Save"
 
color 2
rect 0,120,40,170, 11 filled
at 8,136
print "Back"

COLOR 15
RECT 100,100,340,340, 1 FILLED
RECT 100,340,340,580, 2 FILLED
RECT 100,580,340,820, 3 FILLED
RECT 340,100,580,340, 4 FILLED
RECT 340,340,580,580, 5 FILLED
RECT 340,580,580,820, 6 FILLED
RECT 580,100,820,340, 7 FILLED
RECT 580,340,820,580, 8 FILLED
RECT 580,580,820,820, 9 FILLED
RECT 340,30,580,80, 5 FILLED
at 400,50
color 1
print"Left Click cell"
color 15
x=100
for y=100 to 880 step 80
	line x,y,x+720,y
next
y=100
for x=100 to 880 step 80
   line  x,y,x,y+720
next
													''columns A...I
''rows 1...9
													''boxes 147
''      258
''      369
													''cells numbered
''1...9
''10...18
''19...27 etc
''works out characters in rows columns and boxes

row1=str(a1)+str(b1)+str(c1)+str(d1)+str(e1)+str(f1)+str(g1)+str(h1)+str(I1)
row2=str(a2)+str(b2)+str(c2)+str(d2)+str(e2)+str(f2)+str(g2)+str(h2)+str(I2)
row3=str(a3)+str(b3)+str(c3)+str(d3)+str(e3)+str(f3)+str(g3)+str(h3)+str(I3)
row4=str(a4)+str(b4)+str(c4)+str(d4)+str(e4)+str(f4)+str(g4)+str(h4)+str(I4)
row5=str(a5)+str(b5)+str(c5)+str(d7)+str(e5)+str(f5)+str(g5)+str(h5)+str(I5)
row6=str(a6)+str(b6)+str(c6)+str(d6)+str(e6)+str(f6)+str(g6)+str(h6)+str(I6)
row7=str(a7)+str(b7)+str(c7)+str(d7)+str(e7)+str(f7)+str(g7)+str(h7)+str(I7)
row8=str(a8)+str(b8)+str(c8)+str(d8)+str(e8)+str(f8)+str(g8)+str(h8)+str(I8)
row9=str(a9)+str(b9)+str(c9)+str(d9)+str(e9)+str(f9)+str(g9)+str(h9)+str(I9)

colA=str(a1)+str(a2)+str(a3)+str(a4)+str(a5)+str(a6)+str(a7)+str(a8)+str(a9)
colb=str(b1)+str(b2)+str(b3)+str(b4)+str(b5)+str(b6)+str(b7)+str(b8)+str(b9)
colc=str(c1)+str(c2)+str(c3)+str(c4)+str(c5)+str(c6)+str(c7)+str(c8)+str(c9)
cold=str(d1)+str(d2)+str(d3)+str(d4)+str(d7)+str(d6)+str(d7)+str(d8)+str(d9)
cole=str(e1)+str(e2)+str(e3)+str(e4)+str(e5)+str(e6)+str(e7)+str(e8)+str(e9)
colf=str(f1)+str(f2)+str(f3)+str(f4)+str(f5)+str(f6)+str(f7)+str(f8)+str(f9)
colg=str(g1)+str(g2)+str(g3)+str(g4)+str(g5)+str(g6)+str(g7)+str(g8)+str(g9)
colh=str(h1)+str(h2)+str(h3)+str(h4)+str(h5)+str(h6)+str(h7)+str(h8)+str(h9)
coli=str(i1)+str(i2)+str(i3)+str(i4)+str(i5)+str(i6)+str(i7)+str(i8)+str(i9)

box1=str(a1)+str(a2)+str(a3)+str(b1)+str(b2)+str(b3)+str(c1)+str(c2)+str(c3)
box2=str(a4)+str(a5)+str(a6)+str(b4)+str(b5)+str(b6)+str(c4)+str(c5)+str(c6)
box3=str(a7)+str(a8)+str(a9)+str(b7)+str(b8)+str(b9)+str(c7)+str(c8)+str(c9)
box4=str(d1)+str(d2)+str(d3)+str(e1)+str(e2)+str(e3)+str(f1)+str(f2)+str(f3)
box5=str(d4)+str(d7)+str(d6)+str(e4)+str(e5)+str(e6)+str(f4)+str(f5)+str(f6)
box6=str(d7)+str(d8)+str(d9)+str(e7)+str(e8)+str(e9)+str(f7)+str(f8)+str(f9)
box7=str(g1)+str(g2)+str(g3)+str(h1)+str(h2)+str(h3)+str(i1)+str(i2)+str(i3)
box8=str(g4)+str(g5)+str(g6)+str(h4)+str(h5)+str(h6)+str(i4)+str(i5)+str(i6)
box9=str(g7)+str(g8)+str(g9)+str(h7)+str(h8)+str(h9)+str(i7)+str(i8)+str(i9)

''isolate 1-89 are characters that the cell cannot be
dim isolate(89)
isolate(1)=str(row1)+str(cola)+str(box1)
isolate(2)=str(row1)+str(colb)+str(box1)
isolate(3)=str(row1)+str(colc)+str(box1)
isolate(4)=str(row1)+str(cold)+str(box4)
isolate(5)=str(row1)+str(cole)+str(box4)
isolate(6)=str(row1)+str(colf)+str(box4)
isolate(7)=str(row1)+str(colg)+str(box7)
isolate(8)=str(row1)+str(colh)+str(box7)
isolate(9)=str(row1)+str(coli)+str(box7)

isolate(10)=str(row2)+str(cola)+str(box1)
isolate(11)=str(row2)+str(colb)+str(box1)
isolate(12)=str(row2)+str(colc)+str(box1)
isolate(13)=str(row2)+str(cold)+str(box4)
isolate(14)=str(row2)+str(cole)+str(box4)
isolate(15)=str(row2)+str(colf)+str(box4)
isolate(16)=str(row2)+str(colg)+str(box7)
isolate(17)=str(row2)+str(colh)+str(box7)
isolate(18)=str(row2)+str(coli)+str(box7)

isolate(19)=str(row3)+str(cola)+str(box1)
isolate(20)=str(row3)+str(colb)+str(box1)
isolate(21)=str(row3)+str(colc)+str(box1)
isolate(22)=str(row3)+str(cold)+str(box4)
isolate(23)=str(row3)+str(cole)+str(box4)
isolate(24)=str(row3)+str(colf)+str(box4)
isolate(25)=str(row3)+str(colg)+str(box7)
isolate(26)=str(row3)+str(colh)+str(box7)
isolate(27)=str(row3)+str(coli)+str(box7)

isolate(28)=str(row4)+str(cola)+str(box2)
isolate(29)=str(row4)+str(colb)+str(box2)
isolate(30)=str(row4)+str(colc)+str(box2)
isolate(31)=str(row4)+str(cold)+str(box5)
isolate(32)=str(row4)+str(cole)+str(box5)
isolate(33)=str(row4)+str(colf)+str(box5)
isolate(34)=str(row4)+str(colg)+str(box8)
isolate(35)=str(row4)+str(colh)+str(box8)
isolate(36)=str(row4)+str(coli)+str(box8)

isolate(37)=str(row5)+str(cola)+str(box2)
isolate(38)=str(row5)+str(colb)+str(box2)
isolate(39)=str(row5)+str(colc)+str(box2)
isolate(40)=str(row5)+str(cold)+str(box5)
isolate(41)=str(row5)+str(cole)+str(box5)
isolate(42)=str(row5)+str(colf)+str(box5)
isolate(43)=str(row5)+str(colg)+str(box8)
isolate(44)=str(row5)+str(colh)+str(box8)
isolate(45)=str(row5)+str(coli)+str(box8)

isolate(46)=str(row6)+str(cola)+str(box2)
isolate(47)=str(row6)+str(colb)+str(box2)
isolate(48)=str(row6)+str(colc)+str(box2)
isolate(49)=str(row6)+str(cold)+str(box5)
isolate(50)=str(row6)+str(cole)+str(box5)
isolate(51)=str(row6)+str(colf)+str(box5)
isolate(52)=str(row6)+str(colg)+str(box8)
isolate(53)=str(row6)+str(colh)+str(box8)
isolate(54)=str(row6)+str(coli)+str(box8)

isolate(55)=str(row7)+str(cola)+str(box3)
isolate(56)=str(row7)+str(colb)+str(box3)
isolate(57)=str(row7)+str(colc)+str(box3)
isolate(58)=str(row7)+str(cold)+str(box6)
isolate(59)=str(row7)+str(cole)+str(box6)
isolate(60)=str(row7)+str(colf)+str(box6)
isolate(61)=str(row7)+str(colg)+str(box9)
isolate(62)=str(row7)+str(colh)+str(box9)
isolate(63)=str(row7)+str(coli)+str(box9)

isolate(64)=str(row8)+str(cola)+str(box3)
isolate(65)=str(row8)+str(colb)+str(box3)
isolate(66)=str(row8)+str(colc)+str(box3)
isolate(67)=str(row8)+str(cold)+str(box6)
isolate(68)=str(row8)+str(cole)+str(box6)
isolate(69)=str(row8)+str(colf)+str(box6)
isolate(70)=str(row8)+str(colg)+str(box9)
isolate(71)=str(row8)+str(colh)+str(box9)
isolate(72)=str(row8)+str(coli)+str(box9)

isolate(73)=str(row9)+str(cola)+str(box3)
isolate(74)=str(row9)+str(colb)+str(box3)
isolate(75)=str(row9)+str(colc)+str(box3)
isolate(76)=str(row9)+str(cold)+str(box6)
isolate(77)=str(row9)+str(cole)+str(box6)
isolate(78)=str(row9)+str(colf)+str(box6)
isolate(79)=str(row9)+str(colg)+str(box9)
isolate(80)=str(row9)+str(colh)+str(box9)
isolate(81)=str(row9)+str(coli)+str(box9)

''Turns all possible numbers on (1)
''then process removes numbers (0) for numbers already used in row, column or box
''Z counter counts thru all possible cells
''Y counter steps thru combined string of row, column, box values

For Z=1 to 81
 one=1
 two=1
 three=1
 four=1
 five=1
 six=1
 seven=1
 eight=1
 nine=1
 for Y=1 to 27
   if mid$(isolate(z),y,1)="1"
     one=0
   endif
   if mid$(isolate(z),y,1)="2"
     two=0
    endif
   if mid$(isolate(z),y,1)="3"
     three=0
    endif
   if mid$(isolate(z),y,1)="4"
     four=0
   endif
   if mid$(isolate(z),y,1)="5"
     five=0
   endif
   if mid$(isolate(z),y,1)="6"
     six=0
   endif
   if mid$(isolate(z),y,1)="7"
     seven=0
   endif
   if mid$(isolate(z),y,1)="8"
     eight=0
   endif
   if mid$(isolate(z),y,1)="9"
     nine=0
   endif
  next

  ''if true makes list of possible numbers for cell
   answer(z)=""
     if one=1
       answer(z)="1"
     endif
     if two=1
       answer(z)=answer(Z)+"2"
     endif
     if three=1
       answer(z)=answer(Z)+"3"
     endif
     if four=1
       answer(z)=answer(Z)+"4"
     endif
     if five=1
       answer(z)=answer(Z)+"5"
     endif
     if six=1
        answer(z)=answer(Z)+"6"
     endif
     if seven=1
       answer(z)=answer(Z)+"7"
     endif
     if eight=1
       answer(z)=answer(Z)+"8"
     endif
     if nine=1
       answer(z)=answer(Z)+"9"
     endif
   next

''for all positions 1-89 checks whether it has answer
''and prints answer or possible choices
for z=1 to 81
 xplt=(((((((Z-1)/9)-int((Z-1)/9))*9)+0)*80)+110)
 yplt=80*int((z-.5)/9)+130
 at xplt,yplt,
 if test(z)="0"
 	COLOR 9,12
 	print ANSWER(Z)
 else
 	COLOR 9,14
 	print known(z)
 endif
 next z
													''waits for mouseclick, gets x and y positions
''error checks if offscale and calculates Z cell reference
'' label getnext
Pen On
z=0:x=0:y=0
while pen(3)=0
wend
x=pen(10)
y=pen(11)

pen off
if x<80:if y<50
	goto reset
endif:endif

if x<40:if y>60:if y<110
	goto savecurrent
endif:endif:endif

if x<40:if y>120:if y<170
	goto loadcurrent
endif:endif:endif

xplt=int(1+((x-100)/80))
yplt=int(1+((y-100)/80))
if xplt<1
	xplt=1
endif
if xplt>9
	xplt=9
endif
if yplt<1
	yplt=1
endif
if yplt>9
	yplt=9
endif
z=(yplt*9)+xplt-9

''inputs known cell data
''trims of extra chars eg if keybounce produces 555
''if out of range, treats as zero and resets cell to unknown
												
RECT 340,30,580,80, 5 FILLED
at 400,50
PRINT"Cell Value";

label keyin
a=inkey
if str(A) in  "1,2,3,4,5,6,7,8,9, ,0"

''ok
else
  goto keyin
endif

known(z)=right(str(a))

if str(known(z)) in  answer(z)
  known(z)=str(known(z))
  known(z)=left(known(z))
    PLAY "o5 L25 CEGB"
else
	known(z)="0"
	Play "O3 L15 b o2 ge l2 c"
endif

for x=1 to 81
	if known(x)<>"0"
		test(x)=1
	else
		test(x)=0
	endif
next x
 
goto start

end

label savecurrent
for x= 1 to 81
saved(x)=known(x)
next
goto start
end

'' Loads the saved file, resets the test to 0 for the deleted points
label loadcurrent
for x=1 to 81
known(x)=saved(x)
if saved(x)="0"
TEST(X)=0
ENDIF
next
goto start
end
