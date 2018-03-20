't1 Life.bas SmallBASIC (not M$) started 2015-03-20, B+
?:? "    Conway's Life for Bpf":?
? "    Seeding pattern:"
? "Use any character for cell (alive) and spacebar for space (no Life),"
? "lines can be up to 35+ characters/spaces wide and press (enter)."
? "Can use up to 20 lines, type: d(enter) when done, d+(enter) = done."
? "example:
?
? "?  XX     XX"
? "? XXXX   XXXX"
? "?      X"    
? "?     XXX" 
? "?  X       X"
? "?   xxXXXxx  
? "? d(enter)"
?
xmx = 40 : ymx = 50
dim a(1 to xmx, 1 to ymx) , b$(1 to xmx), ng(1 to xmx,1 to ymx)
c=1:notdone=1
while notdone
  input b$(c)
  if lcase(b$(c)) = "d" then b$(c) = "" : notdone=0
  c = c + 1
  if c>=xmx then c=c+1:notdone=0
wend
C = C - 1 : L = 0
'make L longest string length
for x = 1 to c - 1
   if len(b$(x)) > l then l =  len( b$(x))
next x
xm = 20 - c/2
ym = 25 - l/2
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
wend
color 0,11
cls
?:? "   The End, Goodbye!"
end '=============================================== end

func nc(x,y)
  nc=a(x-1,y-1)+a(x-1,y)+a(x-1,y+1)+a(x,y-1)+a(x,y+1)+a(x+1,y-1)+a(x+1,y)+a(x+1,y+1)
end

sub theNextGeneration()
  p=0:g+=1
  for x=2 to xmx-1
    for y=2 to ymx-1
      
      ' my favorite "Crystal life" Rule: comment next line for Conway's Life
      if nc(x,y)=2 then
        
      'regular Conway's Life Rule: uncomment next line for regualar Life
      'if nc(x,y)=2 and a(x,y)=1 then
       
        ng(x,y)=1 :p+=1
      elseif nc(x,y)=3 
        ng(x,y)=1 :p+=1
      else
        ng(x,y)=0  
      fi
     next
  next
  a=ng 
  showA
  pause 1
  if inkey=chr(27) then p=0
end

sub ShowA()
  local x,y
  color 0,15:cls 
  for x=1 to Xmx
     for y=1 to Ymx
        if A(x,y)=1 then 
           locate x, 2*y:color 15,12:? " ";
           color 0,10 :? " ";
           color 0,15
        else
           locate x, 2*y:color 0,10:? "  ";
           color 0,15    
        fi 
     next
     color 0,15:?
  next
  color 0,15 
  locate 41,1
  ? "          Press and hold down (esc) to quit        GENERATION: ";g;"          Population: ";p
end