
'#sec:Main
base0 = 10
show0 = 10
REPEAT
  PRINT "* ";
  LINEINPUT x
  IF LEN(x) = 0 THEN
    EXIT LOOP
  ENDIF
  x = UCASE(x)
  SPLIT x,"<>",y USE TRIM(x)
  b = INSTR(x,"<")
  s = INSTR(x,">")
  radish = y(0)
  IF EMPTY(radish) THEN
    IF s = 0 THEN
      base = VAL(y(1))
      show = "?"
    ELSEIF b = 0 THEN
      base = "?"
      show = VAL(y(1))
    ELSEIF b < s THEN  
      base = VAL(y(1))
      show = VAL(y(2))
    ELSE
      base = VAL(y(2))
      show = VAL(y(1))
    ENDIF
    IF base <> "?" THEN
      IF ABS(base) < 2 OR ABS(base) > 36 THEN
        PRINT "Erroneous input base"
      ELSE
        base0 = base
        PRINT "New input base = "; base0
      ENDIF
    ENDIF
    IF show <> "?" THEN
      IF ABS(show) < 2 OR ABS(show) > 36 THEN
        PRINT "Erroneous display base"
      ELSE
        show0 = show
        PRINT "New display base = "; show0
      ENDIF
    ENDIF
  ELSEIF radish = "?" THEN
    PRINT "Input base = "; base0
    PRINT "Display base = "; show0
  ELSE
    IF b = 0 AND s = 0 THEN
      base = base0
      show = show0
    ELSEIF s = 0 THEN
      base = VAL(y(1))
      show = show0
    ELSEIF b = 0 THEN
      base = base0
      show = VAL(y(1))
    ELSEIF b < s THEN  
      base = VAL(y(1))
      show = VAL(y(2))
    ELSE
      base = VAL(y(2))
      show = VAL(y(1))
    ENDIF
    IF ABS(base) < 2 OR ABS(base) > 36 OR ABS(show) < 2 OR ABS(show) > 36 THEN
      PRINT "Erroneous base"
    ELSE
      sign = 1
      IF base = 10 THEN
        tuber = VAL(radish)
      ELSE
        radix = base
        tuber = 0
        IF ASC(radish) = ASC("-") AND radix > 0 THEN
          sign = -1
          radish = REPLACE(radish,1,"",1)
        ENDIF
        WHILE LEN(radish) > 0
          digit = ASC(radish)
          IF digit >= ASC("0") AND digit <= ASC("9") THEN
            digit = digit - ASC("0")
          ELSEIF digit >= ASC("A") AND digit <= ASC("Z") THEN
            digit = digit - ASC("A") + 10
          ELSE
            digit = ABS(radix)
          ENDIF
          IF digit < ABS(radix) THEN
            tuber = tuber * radix + digit
            radish = REPLACE(radish,1,"",1)
          ELSE
            tuber = "?"
            radish = ""
          ENDIF
        WEND
      ENDIF
      IF tuber <> "?" THEN
        tuber = tuber * sign
        radix = show
        radish = ""
        REPEAT
          carry = CEIL(tuber / radix) * (tuber < 0)
          tuber = tuber - carry * radix
          remainder = tuber % radix
          tuber = tuber \\ radix + carry
          digit = ABS(remainder)
          IF digit > 9 THEN
            digit = digit - 10 + ASC("A")
          ELSE
            digit = digit + ASC("0")
          ENDIF
          radish = CHR(digit) + radish
        UNTIL tuber = 0
        IF remainder < 0 THEN
          radish = "-" + radish
        ENDIF
        IF base  <> 10 THEN
          base$ = CHR(27) + "[91m" + base + CHR(27) + "[80m"
        ELSE
          base$ = ""
        ENDIF
        IF show <> 10 THEN
          show$ = CHR(27) + "[91m" + show + CHR(27) + "[80m"
        ELSE
          show$ = ""
        ENDIF
        PRINT y(0); base$; "  =  "; radish; show$
      ELSE
        PRINT "Erroneous digit"
      ENDIF
    ENDIF
  ENDIF
UNTIL 0
END
'
