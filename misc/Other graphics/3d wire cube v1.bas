' 3D wire cube v1.bas, SmallBASIC B+
' From Simple_3D.bas copied 2015-04-23
' Modified improved for Windows 7-64 and Bpf
maxy=600: maxx=600 : dd=rad(10)
d=100*(maxy/160):t=0:p=0
locate 0,90:? "press 0 to zero out rotations
locate 1,90:? "press 1 or 2 = ccw, cw rotation on z axis
locate 2,90:? "press 3 or 4 = rotate on horizontal axis
locate 3,90:? "press 5 or 6 = grow or shrink
locate 4,90:? "press 7 or 8 = auto rotate
locate 5,90:? "press 9 to maximize cube
locate 6,90:? "press q=quit"
redraw
repeat
   k=inkey$
   if k="1" then
      t=t+dd
      if t>pi then t=pi
      redraw
   elif k="2"
      t=t-dd
      if t<-pi then t=-pi
      redraw
   elif k="3"
      p=p+dd
      if p>pi then p=pi
      redraw
   elif k="4"
      p=p-dd
      if p<-pi then p=-pi
      redraw
   elif k="5"
      d=d+10
      if d>maxy then d=d-10
      redraw
   elif k="6"
      d=d-10
      if d<10 then d=10
      redraw
   elif k="7"
      repeat:t=t+dd:redraw:delay 150:until t>=pi
      repeat:t=t-dd:redraw:delay 150:until t<=-pi
      repeat:t=t+dd:redraw:delay 150:until t>=0 
   elif k="8"
      repeat:p=p+dd:redraw:delay 150:until p>=pi
      repeat:p=p-dd:redraw:delay 150:until p<=-pi
      repeat:p=p+dd:redraw:delay 150:until p>=0
   elif k="9"
      d=maxy:redraw
   elif k="0"
      t=0 : p=0 : redraw
   endif
until k="q"
locate 25,100:? "*******************"
locate 26,100:? " ***  Goodbye  ***"
locate 27,100:? "*******************"
end

' main screen display
sub redraw
   rect 0,0, maxx,maxy, color 15 filled
   locate 11,100:? "                  "
   locate 12,100:? "                  "
   locate 13,100:? "                  "
   locate 11,100:? "v axis "+int(deg(t))
   locate 12,100:? "h axis "+int(deg(p))
   locate 13,100:? "side "+d
   st=sin(t):ct=cos(t)
   sp=sin(p):cp=cos(p)
   restore cubeData
   calcPt
   pset sx,sy
   for i=1 to 15
      calcPt
      line sx,sy
   next
end

'sx,sy (3d->2d)
sub calcPt
   read x,y,z
   xe=-x*st+y*ct
   ye=-x*ct*cp-y*st*cp+z*sp
   ze=-x*sp*ct-y*st*sp-z*cp+4
   sx=d*xe/ze+maxx/2
   sy=d*ye/ze+maxy/2
end

label cubeData
1 data 1,1,1
2 data 1,-1,1
3 data -1,-1,1
4 data -1,1,1
5 data 1,1,1
6 data 1,1,-1
7 data 1,-1,-1
8 data -1,-1,-1
9 data -1,1,-1
10 data 1,1,-1
11 data 1,-1,1
12 data 1,-1,-1
13 data -1,-1,1
14 data -1,-1,-1
15 data -1,1,1
16 data -1,1,-1


