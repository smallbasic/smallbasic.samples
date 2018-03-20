
'getfilename test
test=getfile("*.*")
? "test file = ";test
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
  if flnm> -1 and flnm< i then
     getfile=anyfile(flnm)
  else
     getfile=""
  end if
  cls
end
