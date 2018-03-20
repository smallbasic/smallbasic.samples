
'#sec:Main
REPEAT
  PRINT ":";
  LINEINPUT cmd$
  cmd$ = SQUEEZE(cmd$)
  IF LEN(cmd$) = 0 THEN
    EXIT LOOP
  ENDIF
  SPLIT cmd$," ",cmd
if 0 then ?UBOUND(cmd),cmd
  IF UBOUND(cmd) = 0 THEN
    cmd = [cmd(0),""]
  ENDIF
if 0 then ?UBOUND(cmd),cmd
  c = cmd(0)

  IF c = "ls" THEN
    FOR ci = 1 TO UBOUND(cmd)
      PARSE cmd(ci)
      IF pflag THEN
        IF ci > 1  THEN
            INPUT "NEXT...",ans
            IF LCASE(LEFT(ans,1)) = "n" THEN
              EXIT FOR
            ENDIF
          ENDIF
        ENUM
        j = 0
        FOR i = 0 TO fcount - 1
          IF dir + flist(i) <> "MEMO:$$$DELETED$$$" THEN
            IF j MOD 12 = 0 THEN
              IF j > 0 THEN
                INPUT "MORE...",ans
                IF LCASE(LEFT(ans,1)) = "n" THEN
                  EXIT FOR
                ENDIF
              ENDIF
              PRINT "List of ";spec
            ENDIF
            f = LEFT(flist(i),24) + IF(LEN(flist(i)) > 24,CHR(133),"")
            h = FREEFILE
            OPEN dir + flist(i) FOR INPUT AS #h
            PRINT LOF(h),f
            CLOSE #h
            j = j + 1
          ENDIF
        NEXT
        IF j = 0 THEN
          PRINT "No files in ''";spec;"''"
        ENDIF
      ELSE
        PRINT "Invalid field: ''";cmd(ci);"''"
      ENDIF
    NEXT

  ELSEIF c = "cp" OR c = "mv" THEN
    IF UBOUND(cmd) < 2 THEN
      cmd = [cmd(0),cmd(1),""]
    ENDIF
    PARSE cmd(2)
    IF NOT pflag THEN
      PRINT "Invalid field: ''";cmd(2);"''"
    ELSE
      IF ("*" IN fn) OR ("?" IN fn) OR (spec = "MEMO:$$$DELETED$$$") THEN
        PRINT "Ambiguous destination"
      ELSE
        ddir = dir
        dfn = fn
        dspec = ddir + dfn
        PARSE cmd(1)
        IF NOT pflag THEN
          PRINT "Invalid field: ''";cmd(1);"''"
        ELSE
          ENUM
          j = 0
          FOR i = 0 TO fcount - 1
            sspec = dir + flist(i)
            IF sspec <> "MEMO:$$$DELETED$$$" THEN
              IF LEN(dfn) = 0 THEN
                dspec = ddir + flist(i)
              ENDIF
              IF sspec = dspec THEN
                PRINT "Cannot copy/move file to itself"
              ELSE
                IF EXIST(dspec) THEN
                  INPUT "Overwrite ''" + dspec + "'' with ''" + sspec + "'' ";ans
                  IF LCASE(LEFT(ans,1)) = "y" THEN
                    ''KILL dspec
                  ELSE
                    c = ""
                  ENDIF
                ENDIF
                IF c <> "" AND ddir = "MEMO:" AND dir <> "MEMO:" THEN
                  h = FREEFILE
                  OPEN sspec FOR INPUT AS #h
                  IF LOF(h) > 3935 THEN
                    PRINT "Too large for MEMO: ''";sspec;"''"
                    c = ""
                  ENDIF
                ENDIF
                IF c = "cp" THEN
                  COPY sspec,dspec
                  PRINT "Copied ''";sspec;"'' to ''";dspec;"''"
                  j = j + 1
                ELSEIF c = "mv" THEN
                  RENAME sspec,dspec
                  PRINT "Moved ''";sspec;"'' to ''";dspec;"''"
                  j = j + 1
                ENDIF
              ENDIF
            ENDIF
          NEXT
          IF j = 0 THEN
            PRINT "Nothing to copy"
          ENDIF
        ENDIF
      ENDIF
    ENDIF
  
  ELSEIF c = "del" THEN
    FOR ci = 1 to UBOUND(cmd)
      PARSE cmd(ci)
      IF pflag THEN
        ENUM
        j = 0
        FOR i = 0 TO fcount - 1
          f = dir + flist(i)
          IF f <> "MEMO:$$$DELETED$$$" THEN
            j = j + 1
            INPUT "Delete ''" + f + "'' ";ans
            IF LCASE(LEFT(ans,1)) = "y" THEN
              KILL f
              PRINT "Deleted"
            ENDIF
          ENDIF
        NEXT
        IF j = 0 THEN
          PRINT "No files in ''";spec;"''"
        ENDIF
      ELSE
        PRINT "Invalid field: ''";cmd(ci);"''"
      ENDIF
    NEXT

  ELSEIF c = "nf" THEN
    FOR ci = 1 to UBOUND(cmd)
      PARSE cmd(ci)
      IF pflag THEN
        IF ("*" IN fn) OR ("?" IN fn) OR (spec = "MEMO:$$$DELETED$$$") THEN
          PRINT "Ambiguous field: ''";cmd(ci);"''"
        ELSE
          IF EXIST(spec) THEN
            INPUT "Replace ''" + spec + "'' ";ans
            IF LCASE(LEFT(ans,1)) <> "y" THEN
              c = ""
            ENDIF
          ENDIF
          IF c <> "" THEN
             h = FREEFILE
             OPEN spec FOR OUTPUT AS #h
             REPEAT
               PRINT ">";
               LINEINPUT f
               IF LCASE(f) = "@eof" THEN
                 EXIT LOOP
               ENDIF
               PRINT #h,f
             UNTIL
             CLOSE #h
             PRINT "Created ''";spec;"''"
          ENDIF
        ENDIF
      ELSE
        PRINT "Invalid field: ''";cmd(ci);"''"
      ENDIF
    NEXT

  ELSEIF c = "t" THEN
    FOR ci = 1 to UBOUND(cmd)
      PARSE cmd(ci)
      IF pflag THEN
        IF ci > 1  THEN
            INPUT "NEXT...",ans
            IF LCASE(LEFT(ans,1)) = "n" THEN
              EXIT FOR
            ENDIF
          ENDIF
        ENUM
        l = 0
        FOR i = 0 TO fcount - 1
          sspec = dir + flist(i)
          IF sspec <> "MEMO:$$$DELETED$$$" THEN
            IF l > 0 THEN
              INPUT "NEXT...",ans
              IF LCASE(LEFT(ans,1)) = "n" THEN
                EXIT FOR
              ENDIF
            ENDIF
            l = l + 1
            h = FREEFILE
            OPEN sspec FOR INPUT AS #h
            k = 0
            j = 0
            hspec = LEFT(sspec,24) + IF(LEN(sspec) > 24,CHR(133),"")
            WHILE NOT EOF(h)
              LINEINPUT #h;f
              k = k + 1
              f0 = STR(k) + "." + CHR(9)
              ans = 0
              REPEAT
                IF j MOD 12 = 0 THEN
                  IF j > 0 THEN
                    INPUT "MORE...",ans
                    ans = LCASE(LEFT(ans,1))
                    IF ans = "n" THEN
                      EXIT LOOP
                    ENDIF
                  ENDIF
                  PRINT "Listing of ''";hspec;"''"
                ENDIF
                cont = LEN(f) > 25
                IF cont THEN
                  f1 = LEFT(f,25)
                  f = MID(f,26)
                ELSE
                  f1 = f
                ENDIF
                PRINT f0;f1
                f0 = CHR(9)
                j = j + 1
              UNTIL cont = 0
              IF ans = "n" THEN
                EXIT LOOP
              ENDIF
            WEND
            IF k = 0 THEN
              PRINT "No lines in ''";sspec;"''"
            ENDIF
            CLOSE #h
          ENDIF
        NEXT
        IF l = 0 THEN
          PRINT "No files in ''";spec;"''"
        ENDIF
      ELSE
        PRINT "Invalid field: ''";cmd(ci);"''"
      ENDIF
    NEXT

  ELSE
    PRINT "Unknown command: ''";c;"''"
  ENDIF
UNTIL
END

SUB PARSE(field)
LOCAL f,p
  SPLIT field,":",p
if 0 then ?"field=''";field;"''","p=";p
  IF LEN(p) THEN
    IF UBOUND(p) = 0 THEN
      IF ":" IN field THEN
        p = [p(0),""]
      ELSE
        p = ["",p(0)]
      ENDIF
    ENDIF
  ELSE
    p = ["",""]
  ENDIF
if 0 then ?"field=''";field;"''","p=";p
  dir = p(0)
  f = LCASE(LEFT(dir,1))
  IF f = "m" THEN
    dir = "MEMO:"
  ELSEIF f = "p" OR f = "d" THEN
    dir = "PDOC:"
  ELSEIF LEN(dir) > 0 THEN
    pflag = 0
    EXIT FUNC
  ENDIF
  fn = p(1)
  IF LEN(fn) > 0 THEN
    mask = fn
  ELSE
    mask = "*"
  ENDIF
  spec = dir + mask
if 0 then ?"dir=''";dir;"''";" fn=''";fn;"''";" mask=''";mask;"''";" spec=''";spec;"''"
  pflag = 1
END

SUB ENUM
  flist = FILES(spec)
  fcount = LEN(flist)
if 0 then ?"fcount=";fcount;" flist=";flist
END
'
