'BAS_NOWv2.bas, 2015-02-22, B+ using SmallBASIC (?=PRINT)
? "    AX + BY = C   DX + EY = F" 
? "   SOLUTION: WHEN (AE-BD) <> 0" 
? " X= (CE-BF)/(AE-BD)    Y= (AF-CD)/(AE-BD)" :?:quit=""
WHILE quit=""
  INPUT " A,B,C,D,E,F +ENTER ",a,b,c,d,e,f
  g=a*e-b*d
  IF g THEN ?"X=";(c*e-b*f)/g;"   Y=";(a*f-c*d)/g ELSE ?"NO UNIQUE SOLUTION"
  INPUT "ANY KEY +ENTER TO QUIT, JUST ENTER TO GO AGAIN ",quit :?
WEND



