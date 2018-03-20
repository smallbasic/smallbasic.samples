
'fully factor.bas SmallBASIC 0.12.6 [B+=MGA] 2016-06-11
n = 2
WHILE n >= 2
  INPUT "Enter a number to factor (if < 2, quit), number > ";n
  IF n < 2 THEN END
  REPEAT
    fd = 0 : test = 2
    WHILE test <= n ^.5
      IF n % test = 0 THEN fd = test : EXIT LOOP
      IF test = 2 THEN test = 3 ELSE test = test + 2 
    WEND
    IF fd THEN n /= fd : ? fd;" "; ELSE ? n
  UNTIL fd = 0
WEND
