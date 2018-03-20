
REM Save As bas file.bas 2016-02-11 SmallBASIC 0.12.0 [B+=MGA]
'some bugs removed from previous, still doesn't test if new name already exits

? "Select file for Save As:"
test=getfile("*.bas")
? "test file = ";test
exten=right(test,4)
if lcase(exten)=".bas" or lcase(exten)=".txt" then
  input "Enter new name (extension not needed unless desire change) ";asname
  if asname<>"" then
    if !instr(1,asname,".") then asname=asname+exten
    ? "Save: ";test;" As ";asname;" ?"
    input "enter y for yes, any other quits ";y
    if y="y" then
      tload test,flines
      tsave asname,flines
      ? "OK, ";test;" Saved AS ";asname
    else
      ?"Save As not confirmed"
    end if  
  else
    ? "Nothing? OK"
  end if
else
  ? "Sorry, ";test;" with extension (";exten;") not intended for Save As."
end if
? "good-bye"
pause

func getfile(pat)
   local anyfile,a,i,flnm
  anyfile = files(pat)
  sort anyfile
  i=0
  for a in anyfile
    ? i;" "+a
    i++
  next
  ?:input "Enter file number (or nothing) ";flnm
  if flnm>-1 and isnumber(flnm) then
     getfile=anyfile(flnm)
  else
     getfile=""
  end if
  cls
end