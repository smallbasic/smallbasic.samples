
'#sec:Main
5 color 9
10 print "RELACION DE DIBUJO A BMP"
20 color 0
40 input "Ancho freehand en cms?",b
45 if b=0 then goto 120
50 input "Ancho bmp en dots? ",a
55 if a=0 then goto 120
60 r=b/2.54:r=a/r
70 print"Dot x inch= ";
75 color 12
76 print r:color 0
110 goto 40
120 print:goto 10
'
