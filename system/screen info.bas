
'screen info.bas
'written directly into Code Library by B+=MGA 2015-12-10 after another failed screen fit for NOOK Android device
th=txth("By")
tw=txtw("B")
for y=0 to 2000 step 10
for x=0 to 2000 step 10
if x=0 or y=0 then 
  if (x mod 100=0 and y=0) or (x=0 and y mod 100=0) then cc=9 else cc=14
  rect x,y,x+10,y+10,cc
end if
next:next
at 20+tw,20+th:? "Current Screen Width, xmax = ";xmax
at 20+tw,20+th*3:? "Current Screen Height, ymax = ";ymax
at 20+tw,20+th*5:? "Text height of By is ";th
at 20+tw,20+th*7:? "Text width  of B is ";tw
at 20+tw,20+th*9:? "The blocks are drawn as 10x10 scale markers, blue/100."
at 20+tw,20+th*10:? "So check counts with reported xmax and ymax."
'at 20+tw,20+th*12:? "TICSPERSEC: ";tickspersec
at 20+tw,20+th*15:? "Plan you apps accordingly, happy programming!"
pause
