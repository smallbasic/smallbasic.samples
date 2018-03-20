'Mandala life.bas SmallBASIC (not MS) B+ for Bpf 2015-03-25
an=41: s=int(ymax/an): bigBlock=an*s: g=0 
dim a(1 to an,1 to an), ng(1 to an,1 to an),ls(1 to an, 1 to an)
color 0,15:cls
while inkey<>Chr(32)
  if g mod 2 =0 then
    for x=1 to an
      a(x,1)=1 :a(x,an)=1:a(1,x)=1:a(an,x)=1
    next
  fi   
  for x=2 to an-1
    for y=2 to an-1
      pc=a(x-1,y-1)+a(x-1,y)+a(x-1,y+1)+a(x,y-1)+a(x,y+1)+a(x+1,y-1)+a(x+1,y)+a(x+1,y+1)
      ls(x,y)=pc : r=str(pc)
      if a(x,y) then 
        if instr("2346",r) then ng(x,y)=1 else ng(x,y)=0
      else 'birth?
        if instr("34",r) then ng(x,y)=1 else ng(x,y)=0 
      fi
    next
  next 
  rect 1,1,bigBlock,bigBlock,15 filled 
  for y=1 to an
     for x=1 to an
       if a(x,y) then 
         rect (x-1)*s+1,(y-1)*s+1,step s,s,0 filled
       else
         lc=ls(x,y)
         select lc
         case 0 :cl=15 'br white
         case 1 :cl=11 'cyan 
         case 2 :cl=7  'low white, br gray
         case 3 :cl=10 'light green
         case 4 :cl=9  'blue 
         case 5 :cl=13 'violet 
         case 6 :cl=12 'br red
         case 7 :cl=4  'dark red
         case 8 :cl=1  'indigo
         end select
         rect (x-1)*s+1,(y-1)*s+1,step s,s,cl filled
       fi
     next
  next
  a=ng : g+=1
  if g>60 then delay 1000
wend
Locate 1,100: ? "Goodbye!"
