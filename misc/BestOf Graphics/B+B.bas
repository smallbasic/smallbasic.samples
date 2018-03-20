'<== comment some SmallBasic for Bpf started 2015-03-20
'case and indents, insensitive, ? == PRINT

func etc(r, c, rc, counter)
  local i, rc3, r2, flap
  rc3 = rc - 9
  if rc3 < 0 then rc3 = rc3 + 15
  color rc, rc3  
  locate r, c
  if counter mod 2 then print "hello world" else print "HI, BPF!"
  for i = 10 to 1 step -1
     if i mod 2 then color 15,9 else color 0,14
     r2=rnd
     if r2<.33 then 
       flap=1 
     elseif r2<.67
       flap=0
     else 
       flap=-1
     fi    
     locate 11 - i + r, c + int((10-i)/2) + flap
     ? string(i, "*")
  next
end function

'====================================================== main
'Have you discovered the neat change case in the Edit menu ?
'3: modes, Modes, MODES highlight text to change and toggle
r = 10
rd = -.5
cycle=1
while 1
  counter+=1
  if counter mod 72=0 then cycle=cycle*-1 :counter=0
  if r = 10 then rd = -.25
  if r = 5 then rd = .25
  r = r + rd
  FOR i = -3.14 TO 3.14 step 6.28 / 12
     'screens be different VVV  (rounder circle for B+)   V
     d=etc(int(sin(i+dx)*r*1.3)+14, int(cos(i+dy*cycle)*r*5)+50, abs(i*100) mod 16, counter)
  NEXT
  if inkey = chr(27) then end
  delay 60
  dx+=.087264 :dy+=.087264
  color 0,15
  cls
wend