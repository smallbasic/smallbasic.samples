
'by Jan Vibe, ppad.bas 
'from code library 2015-11-19 copy
'update to SmallBASIC 0.12.0 MGA/B+
'fix code messed up by text format 
'and attempt to fit any screen

rtns=ppad("test ppad function, click some keys then OK...")
?"ppad returned: ";rtns
Input "OK press enter ";OK
end
func ppad(prompt)
  local n,ch,w,h,x,y,f,r,x1,y1,x2,y2,tlimit
  tlimit=xmax\txtw(" ")
  'best to see if all this will fit on screen
  h=txth("By")+3
  'test screen size
  x=0:y=2*h+2:w=txtw("ii")+6
  for n=0 to 70
    if x+w>xmax-13:x=0:y=y+h+2:endif
    x=x+w+2
  next
  if y>ymax-h-3 then 'use small character set
    for n=42 to 57:append ch,chr(n)
    next
    for n=65 to 90:append ch,chr(n)
    next
  else 'use large character set
    for n=33 to 95:append ch,chr(n)
    next
  endif
  append ch, "space bar":append ch,"delete":append ch,"OK"
  cls:? prompt
  x=0:y=2*h+2
  'draw keypad for mouse, this is pretty cool 
  for n=0 to ubound(ch)
    w=txtw(ch(n))+6
    if x+w>xmax-13:x=0:y=y+h+2:endif
    rect x,y step w,h
    append x1,x:append y1,y
    append x2,x+w:append y2,y+h
    at x+4,y+2:? ch(n);
    x=x+w+2
  next
  'handle clicks
  r=""
  pen on
  repeat
    while pen(0)=0
    wend
    x=pen(4):y=pen(5)
    while pen(3)
    wend
    f=0  'f for find ch
    for n=0 to ubound(ch)
      if x> x1(n) and y> y1(n) and  x< x2(n) and y< y2(n) then  
        f=n:n=ubound(ch)                    
      endif
    next
    if ch(f)="delete" then
      if len(r)>= 1 then r=left(r,len(r)-1)
    elseif ch(f)="space bar"
      r=r+" "
    elseif ch(f)<> "OK"
      r=r+ch(f)
    endif
    if len(r)> tlimit then beep
    at 0,h+1:?string(tlimit," ");
    at 0,h+1:?r;
  until ch(f)="OK"
  pen off:cls
  ppad=r
end