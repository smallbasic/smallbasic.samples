
'new bas.bas 2015-11-29 SmallBASIC 0.12.0 [MGA/B+]
' now customize the first line of your new .bas file
' the rest of the code is copy of New procedure in Main SB.exe

color 11,0
? "Start new program with label option:"
? "To exit, just press enter when prompted for New file name."
?
while (!valid_file)
  input "Enter New file name: ",file
  if !len(file) then exit loop
  dot=instr(file,"."):if dot=0 then file+=".bas"
  try
  if (exist(file)) then
    ? "File, ";file;", already esists.":?
  else
    ?:? "For no file label, just press enter,"
    ? "For label build string:
    ? "f for filename,"
    ? "d for (dd/mm/yyyyy) date,"
    ? "i for (yyyy-mm-dd) ISOdate,"
    ? "s for SmallBASIC 0.12.0,"
    ? "[ your signature/initials/note ]"
    ? "a for all above with or wo signature."
    input "Enter string for label or just enter: ",lab
    lab=upper(lab)
    build="REM":sig=""
    if len(lab) then
      if instr(lab,"[") then sig=" ["+rightof(lab,"["):lab=leftof(lab,"[")
      if instr(lab,"F") then build+=" "+file
      if instr(lab,"D") then build+=" "+date
      if instr(lab,"I") then build+=" "+ISOdate("")
      if instr(lab,"S") then build+=" SmallBASIC 0.12.0"
      if instr(lab,"A") then build+=" "+file+" "+ISOdate("")+" SmallBASIC 0.12.2"    '< current version of SB
      if len(sig) then build+=sig
    end if
    open file for output as #1
    print #1, build
    close #1
    ? file;" has been started with label: "+build
    valid_file=true
  end if
  catch e
  ? "Error printing file:" e
  end try
wend
? "OK, good-bye"
pause
func ISOdate(DslashMslashY)
   local fdate,d,my,m,y
   if DslashMslashY="" then fdate=date else fdate=DslashMslashY
   d=leftof(fdate,"/"):if len(d)=1 then d="0"+d
   my=rightof(fdate,"/")
   m=leftof(my,"/"):if len(m)=1 then m="0"+m
   y=rightof(my,"/"):if len(y)=2 then y="20"+y
   ISOdate=y+"-"+m+"-"+d
end   

