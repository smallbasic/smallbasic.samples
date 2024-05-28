
' drwbtn test.bas  SmallBASIC 0.12.2 [B+=MGA] 2016-03-23

'setup and test sub drwbtn 50 pixels high, 200 wide with text centered in button hopefully
'200x50 easy numbers to layout on screen and catch with pen(3)
color 0,7:cls
for i=0 to 7
  drwbtn 100,60*i+10,"Button #"+str(i+1)
next

pen on

while 1
  btn=0:mx=0:my=0
  
  repeat
    if pen(3) then
      mx=pen(4):my=pen(5)
      'delay 30 ' to avoid a double key press from slow mouse < dont need delay here?
      if mx>100 and mx<300 then
        for i=0 to 7
          if my>60*i+10 and my<60*i+10+50 then
            btn=i+1 : exit
          end if
        next
      end if
    end if
    showpage
    delay(20)
  until btn<>0  
  at 500,100:?spc(50)
  at 500,100:? "You pressed button "+btn
wend

pen off

sub drwbtn(x,y,s)
  local th,tw,gray,xoff,yoff
  th=txth(s):tw=txtw(s):gray=rgb(190,190,190)
  rect x,y step 200,50,0 filled
  rect x,y step 197,47,15
  rect x+1,y+1,step 197,47,gray filled
  xoff=100-tw\2:yoff=25-th\2
  color 0,gray:at x+xoff,y+yoff:? s
end 
