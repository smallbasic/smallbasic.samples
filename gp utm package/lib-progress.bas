
'#sec:Main
SUB PROGRESS(BYREF count,interval,type,size,x,y,BYREF z)
  count = (count + 1) MOD interval
  IF count = 0 THEN
    CLEAR type,size,x,y
    IF type = 1 THEN
      z = (z + 1) MOD (size * 2)
      CIRCLE x - size \\ 2, y + size \\ 2, ABS(z - size) COLOR 0
    ELSE
      z = (z + 1) MOD 4
      ON z + 1 GOTO 101, 102, 103, 104
101  
      LINE x - size \\ 2 - 0.7071 * size, y + size \\ 2 - 0.7071 * size, x - size \\ 2 + 0.7071 * size, y + size \\ 2 + 0.7071 * size COLOR 0
      GOTO 110
102
      LINE x - size \\ 2, y + size \\ 2 + size, x - size \\ 2, y + size \\ 2 - size COLOR 0
      GOTO 110
103
      LINE x - size \\ 2 + 0.7071 * size, y + size \\ 2 - 0.7071 * size, x - size \\ 2 - 0.7071 * size, y + size \\ 2 + 0.7071 * size COLOR 0
      GOTO 110
104
      LINE x - size \\ 2 + size, y + size \\ 2, x - size \\ 2 - size, y + size \\ 2 COLOR 0
110
    ENDIF
  ENDIF
END

SUB CLEAR(type,size,x,y)
  IF type = 1 THEN
    CIRCLE x - size \\ 2, y + size \\ 2, size COLOR 15 FILLED
  ELSE
    RECT x - size \\ 2 - size, y + size \\ 2 - size, x - size \\ 2 + size, y + size \\ 2 + size COLOR 15 FILLED
  ENDIF
END'
