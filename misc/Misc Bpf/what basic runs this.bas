 'what basic runs this.bas is response to a post Richey made Sunday nite Aug 16, 2015 before Bpf went down Mon
 ' it was from BBC Basic Richey's version had If Then Else If End If for every c name and s name
 REPEAT
        INPUT "Christian Name ";christianName$
      UNTIL christianName$<>""

      surname$=""
      REPEAT
        INPUT "Surname ";surname$
      UNTIL surname$<>""
      ps$=""
      IF christianName$ = "Jim" AND surname$ = "Davison" THEN ps$="Hello, Jim"
      IF christianName$ = "David" AND surname$ = "Brent" THEN ps$="Good Morning, David"
      IF christianName$ = "Victor" AND surname$ = "Meldrew" THEN ps$="I don't believe it, Victor"
      IF christianName$ = "Edmund" AND surname$ = "Blackadder" THEN ps$="Can you get me General Melchett, Darling"
      IF ps$="" THEN ps$ ="An unknown unknown"
      PRINT ps$
      END

