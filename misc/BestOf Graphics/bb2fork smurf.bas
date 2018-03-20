 '<== comment some SmallBasic for Bpf started 2015-03-20
'case and indents, insensitive
func etc(r, c, rc)
'just to be safe using LOCAL i 
  local i

  rc3 = rc - 9
  if rc3 < 0 then rc3 = rc3 + 15
  color rc, rc3  
  locate r, c
  print ucase("hello world")
  for i = 10 to 1 step -1
     if i mod 2 then color 15,9 else color 0,14
     '<=== this is a comment, this=> ? is equavlent to print
     locate 11 - i + r, c
     ? string(i, "*")
  next

  'OK this does work commented out ???? 
  'sorry, something wasn't from my cut and paste
  'etc=1

end function
'====================================================== main
'Have you discovered the neat change case in the Edit menu ?
'3: modes, Modes, MODES
r = 10
rd = -.5
while 1
  FOR i = -3.14 TO 3.14 step 6.28 / 12
  #if r > 9 then rd = -.125
  #if r < 7 then rd = .125
  #r = r + rd

     'screens may be different VVV  (rounder circle for B+)   V
     d = etc(int(sin(i+dx) * atan(i*2.5+5)*5.3)  + 14, int(cos(i+dy) * atan(i*2.5+7) *25) + 50, abs(i * 100) mod 16)
  NEXT
  if inkey = chr(27) then end
  delay 50
  dx+=.087264 :dy+=.087264
  color 0,15
  cls
wend