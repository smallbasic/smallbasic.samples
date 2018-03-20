
' change these to suit your preferred flight
origin = "brisbane"
destination = "adelaide"

' change this if you don't have firefox installed
browser = "c:/progra~1/Mozilla\ Firefox/firefox.exe"

open "http://www.virginblue.com.au/" as #1
tload #1, buffer

' reload to convert line endings
htmlFile = env("TEMP") + "/virgin.html"
tsave htmlFile, buffer
tload htmlFile, buffer

' scrape the page
inHHBlock = 0
for t in buffer
 if len(t) > 0
  idx = instr(t, "hh-table-outer")
  if (idx != 0) then
    inHHBlock = !inHHBlock
  elif (inHHBlock == 1) then
    if (instr(t, origin) != 0 and instr(t, destination)) then
      ' matching flight - open page in browser
      run browser + " http://www.virginblue.com.au/"
    fi
  fi
 fi
next t
