
'tabs2spaces.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-07-04

' removes tabs from file and inserts spaces

tabFile = "ezinvaders.bas"  '<<<<<< type name of file here
newFile = "ezinvaders.bas" '<<< new file name here

if exist(tabFile) then
  if tabFile = newFile then newFile = "_" + newFile
  if exist(newFile) then
    ? newFile; 
    input " already exists, press y for yes! to overwrite it > ";yes
    if yes <> "y" then stop else ? "OK, overwriting file."
  else
    ? "creating new file..."
  fi
else
  ? tabFile;" file not found, press any..."
  pause
  stop
fi
open tabFile for input as #1
open newFile for output as #2
while eof(1) = 0
  lineinput #1, fline
  position = instr(fline, chr(9))
  while position
    fline = leftof(fline, chr(9)) + space(2) + rightof(fline,chr(9))
    position = instr(fline, chr(9))
  wend
  print #2, fline
wend
close #1
close #2
? newFile;" is ready, press any..."
pause
end
