
' CHARMAP
' 25/05/2000
cls
ln=1
for i=0 to 255
  if (i<>12) and (i <>27) and (i<>10) 
    ? i;" ";chr$(i)+chr$(9);
  else
    ? chr$(9);
  fi
  if ((i+1) mod 5) = 0 then
    ?
    ln=ln+1
    if ( ln mod 14) = 0
      ? "Pause...";
      while(inkey$=""):wend
      ?
      ln=1
    fi
  endif
next
