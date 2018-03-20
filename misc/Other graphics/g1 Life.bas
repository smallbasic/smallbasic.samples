'g1 Life.bas SmallBASIC (not M$) make graphics version, 
'can display down to pixel level post 2015-03-21
?:? "    Conway's Life for Bpf":?
? "    Seeding pattern:"
? "Use any character for cell (alive) and spacebar for space (no Life),"
? "lines can be up to 35+ characters/spaces wide and press (enter)."
? "Can use up to 20 lines, type: d(enter) when done, d+(enter) = done."
? "example:
?
? "? XXXX   XXXX"
? "?  XX     XX"
? "?      X"    
? "?      X" 
? "?  X       X"
? "?   xxXXXxx  
? "? d(enter)"
?
'keep things square: arrays [anXan] board [an*sXan*s] or cells [s-1Xs-1] most screens ymax < xmax
an=650: s=int(ymax/an): 
if s<3 then cs=s else cs=s-1
dim a(1 to an,1 to an) , b$(1 to an), ng(1 to an,1 to an)
c=1:notdone=1
while notdone
  input b$(c)
  if lcase(b$(c)) = "d" then b$(c) = "" : notdone=0
  c = c + 1
  if c>=an then c=c+1:notdone=0
wend
C = C - 1 : L = 0
'make L longest string length
for x = 1 to c - 1
   if len(b$(x)) > L then L =  len( b$(x))
next x
xm = int(an/2) - c/2
ym = int(an/2) - L/2
for x = 1 to c
  for y = 1 to len( b$(x))
     if mid$(b$(x) , y , 1) = " " then 
       a(xm + x , ym + y) = 0 
     else
       a(xm + x , ym + y) = 1 
       p = p + 1
     fi
  next y
next x
ShowA 
pause 1
g=1
while p>0
  theNextGeneration()
  delay 10
wend
? "Goodbye!"
end '=============================================== end

func nc(x,y)
  nc=a(x-1,y-1)+a(x-1,y)+a(x-1,y+1)+a(x,y-1)+a(x,y+1)+a(x+1,y-1)+a(x+1,y)+a(x+1,y+1)
end

sub theNextGeneration()
  local x,y,r
  p=0:g+=1
  for x=2 to an-1
    for y=2 to an-1
      r=nc(x,y)
      ' my favorite "Crystal life" Rule: comment next line for Conway's Life
      if r=2 then
        
      'regular Conway's Life Rule: uncomment next line for regualar Life
      'if r=2 and a(x,y)=1 then
       
        ng(x,y)=1 :p+=1
      elseif r=3 
        ng(x,y)=1 :p+=1
      else
        ng(x,y)=0  
      fi
     next
  next
  a=ng 
  showA
end

sub ShowA()
  local x,y
  color 0,15:cls
  rect 1,1,an*s,an*s,11 filled 
  for y=1 to an
     for x=1 to an
        if A(x,y)=1 then 
           rect (x-1)*s+1,(y-1)*s+1,step cs,cs,12 filled
        fi 
     next
  next
  color 0,15 
  locate 1,100 :? "GEN: ";g;
  locate 3,100 :? "POP: ";p;
  locate 5,100 :? "Press (esc)&";
  locate 6,100 :? "hold to end";
  locate 41,100
  if inkey=chr(27) then p=0
end