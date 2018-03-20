' spiro2.bas SmallBASIC copied from samples 2015-04-23
' fixed up for proper display in Windows 7-64, B+
sq=600 
rect 0,0,sq,sq, 0 filled
dim x(12)
dim y(12)
h1=sq/2
for i=0 to 11
  t=cos(i*2*pi/12)
  x(i)=h1+t*(sq/2-10)
  t=sin(i*2*pi/12)
  y(i)=h1+t*(sq/2-10)
next
randomize
for i=0 to 6
 for a=11 to 0 step -1
  c=int(rnd*8)+8
  for b=11 to 0 step -1
    circle x(b),y(b),2 color c filled
    line x(a),y(a),x(b),y(b) color c
    delay 50
next : next
next
locate 0,100 :? "sigh, rest 3 secs..."
pause 3
locate 0,100 :? "                    "
'black out
for a=11 to 0 step -1
  for b=11 to 0 step -1
    circle x(b),y(b),2 color 0 filled
    line x(a),y(a),x(b),y(b),0
    delay 50
next : next: 

locate 5,100:? " ******************"
locate 6,100:? "***  Good Night  ***"
locate 7,100:? " ******************"