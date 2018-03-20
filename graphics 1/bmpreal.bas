
'#sec:Main
10 cls:color 9
20 print "RELACION DE DIBUJO A BMP"
30 color 0
40 input "Ancho bmp en dots?",b
45 if b=0 then goto 120
50 input "Ancho real mm?",a
55 if a=0 then goto 120
60 r=(b/10):r=a/r
70 ? "Relacion=";
80 color 12
90 ? r:color 0
110 goto 40
120 end
'
