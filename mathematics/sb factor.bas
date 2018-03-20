
REM SB Factor.bas for SmallBASIC 0.12.0  05/11/2015 MGA/B+ for On-line Samples
' a couple of tweaks in first couple of lines of the Factor.bas code
' in my FTLK download samples gets this handy math code up and running

s$="^"
n$=""
while 1
  INPUT "Enter a number to factor, <2 quits ";x
  IF x<2 THEN EXIT
  x0=x
  f$=""
  f=2
  p=0
  WHILE x>1
    tmp=x/f
    if tmp=int(tmp) THEN
      p=p+1
      x=tmp
    ELSE
      IF p>0 THEN
        f$=f$+str$(f)
        IF p>1 THEN f$=f$+s$+str$(p)+n$
        f$=f$+" x "
        p=0
      ENDIF
      'the next line is cool!
      f=f+1+(f>2)
      IF f>sqr(x) THEN f=x
    ENDIF
  WEND
  f$=f$+str$(f)
  IF p=1 THEN
    IF f=x0 THEN
      f$=f$+" is prime"
    ENDIF
  ELSE
    f$=f$+s$+str$(p)+n$
  ENDIF
  PRINT f$
wend
