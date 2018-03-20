
'screen labels tests.bas for SmallBASIC 0.12.2 [B+=MGA] 2016-01-25
'originally inspired to help Johnno write a shuffleboard game
'hope to be very reusable, well not much use in Johnno's

'test code for reusable sub printlabel(text,lineNum,alignment)
'alignment =Left, Right, Middle,l,m,r, L, M, or R in quotes!?
? Int(ymax/txth("By"));" lines avaiable to your screen, probably start scrolling one or two before that"
input "Enter to continue...";dummy
cls
s="My test string"
'goto skip
printlabel(s,1,"lr")
printlabel(s,1,"r")
printlabel(s,1,"mr")
for i=1 to 10
  printlabel(s,(int(rnd*30))+2,"r")
  printlabel(s,(int(rnd*30))+2,"m")
  printlabel(s,(int(rnd*30))+2,"l")
next
label Skip
for i=1 to Int(ymax/txth("By")) 'this will scroll unless sub is fixed, fixed!
  printlabel s+" "+str(i),i,"m" 
next
'a couple of beepers
'printlabel(s,100,r) 'this better beep!
printlabel("beep",35,"r") 'fix one beeper
pause

sub printlabel(labelstring, linenum, alignment)
  'linenum assumes all labels have same height
  'alignment choice of L,M,R or left, middle, right we will be looking at case insensitive first letter
  'if nothing gets printed linenum is too big or alignment not spec'd correctly or showpage was not used in maine
  '2016-01-26 fix max lineNum - 2 lines!  to keep screen from scrolling after a print
  local LMR,th,margin,tw,y
  LMR=upper(left(alignment,1))
  th=int(txth(labelstring))
'   see how everything turns blue  code Library has trouble with the less than symbol insert that sign and code in comment
'   if you copied code from library ----V (less than) int(ymax-2*th) then
  if instr("LMR",LMR) and linenum*th< int(ymax-2*th) then
    margin=10
    tw=txtw(labelstring)
    y=margin+(lineNum-1)*th
    select case LMR
    case "L"
      AT margin,y 
    case "M"
      AT (xmax-tw)/2,y
    case "R"
      AT xmax-tw-margin,y
    end select
    print labelstring
  else
    beep
  end if
end

