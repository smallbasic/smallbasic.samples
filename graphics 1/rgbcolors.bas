
'
''**********************************************
'' choose  color nro
''by keijo Koskinen 20.08,2004
locate 1,1
?"********* COLOUR CHART BY VALUE  ***********"
label looppi
  n=0
   k=inkey
   ''note: all values have to be negative
   if k="e" then r=r+1:if r>0 then r=0     ''red  less
      if k="r" then r=r-1:if r<-255 then r=-255     ''red  more
   if k="f" then g=g+1:if g>0 then g=0     ''green less
       if k="g" then g=g-1 :if g<-255 then g=-255    ''green more
   if k="v" then b=b+1:if b>0 then b=0    ''blue   less
       if k="b" then b=b-1:if b<-255 then b=-255    ''blue  more
   
    rect 10,20,300,100 color b+(256*g)+(256*256*r) filled
   
locate 10,1:?"e/r=red"
locate 10,11:?"f/g=green"
locate 10,22:?"v/b=blue"
locate 10,33:?"color ="
locate 11,1
?"0-(-256)  0-(-256)   0-(-256)   0-(16777215)"
locate 12,1
?"                                                 "
locate 12,1:?r
locate 12,11:?g
locate 12,22:?b
locate 12,33:?r+(256*g)+(256*256*b)

if asc(k)<>27: goto looppi
endif
end'
