'Lightning.bas copied from Bpf aurel
'and modified for SmallBASIC 2015-04-27 B+
func Lightning(x1,y1,x2,y2,d)
  if d<5 then 
     line x1,y1,x2,y2,rgb(200,200,255)
  else 
    mx = (x2+x1)/2
    my = (y2+y1)/2
    mx += (rnd-.5)*d
    my += (rnd-.5)*d
    d1=Lightning(x1,y1,mx,my,d/2)
    d2=Lightning(x2,y2,mx,my,d/2)
  fi
  lightning=0
end

while asc(inkey)<>27
    rect 0,0,800,600,0 filled
    circle 400,300,300,1,11 filled
    delay 5
    rect 0,0,800,600,0 filled
    circle 75,300,25,1,12 filled
    circle 725,300,25,1,9 filled
    d3=Lightning(100,300,700,300,400)
    delay 25
wend