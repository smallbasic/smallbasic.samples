
'quick key number.bas  

rem inkey can return a one or a two character string
rem when 2 characters in length you can catch special keys or key combos like Alt + C

k = "Go"
? "Testing ASC numbers for key presses, q to quit"
while k <> "q"
  k = inkey
  if len(k)
     if len(k) = 2 then
       ? "H/W #"+ asc(right(k,1)) + "  asc(left(k,1)) is:";asc(k)
     else
       ? k; " "; asc(k)
     fi
   fi
wend
? "OK done"
