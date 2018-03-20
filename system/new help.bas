

REM SmallBASIC 0.12.2
REM created: 02/03/2016 shian
'
' Using Offline Help in SmallBASIC editor (the easy way):
' -------------------------------------------------------
'
' 1) download offline help file "sbref_v1.txt" from SmallBASIC site.
'
' 2) run this program to convert "sbref_v1.txt" into "sbref_v1.bas";
'    (before you run you must modify the USER DEFINED CODE below).
'
' 3) open "sbref_v1.bas" with SmallBASIC editor, then Press Ctrl+L to
'    list all keywords for help (scroll the list and press Enter).
'
' 4) press Alt+0 for recent files list, or Alt+1..9 to select
'    file to edit; then you can return to "sbref_v1.bas" for help
'    in this way.
'
' 5) you can also press Ctrl+F to search for text in "sbref_v1.bas",
'    and Ctrl+C to copy selected text for use in another file.
'
'
' -------------------- START OF USER DEFINED CODE --------------------
'
' carefully change the following pathnames to reflect your system;
' (note that on some systems pathname is case sensitive!):
'
' original help file name is "sbref_v1.txt":
Const SBREF_V1 = "/home/shian/SmallBASIC/sbref_v1.txt"
'
' new help file name must end with ".bas" extension:
Const SBREF_V1_NEW = "/home/shian/SmallBASIC/sbref_v1.bas"
'
' -------------------- END OF USER DEFINED CODE ----------------------
'
'
' modify the keyword's fist line for listing with Ctrl+L.
Func modify_keyword_text(text)
  Local i, long, short, pos
 
  ' convert long module name to short (for Ctrl+L):
  Restore modules
  For i = 1 To 5
    Read long, short
    pos = Instr(text, long)
    If pos Then
      text = Replace(text, pos, short, Len(long))
      Exit For
    Endif
  Next
 
  ' add "Label " before serial-number (for Ctrl+L):
  modify_keyword_text = "Label " + text
End

' Long, short module names:
Label modules
Data "(Console)" , "(Con)"
Data "(Graphics)", "(Grx)"
Data "(Language)", "(Lng)"
Data "(String)"  , "(Str)"
Data "(System)"  , "(Sys)"

' create new help file (with extension ".bas"):
Sub create_new_help_file
  Local count, sn, text
 
  Open SBREF_V1 For Input As #1
  Open SBREF_V1_NEW For Output As #2

  count = 1
  sn = count + ". "
  Repeat
    Lineinput #1, text
     
    If Left(text, Len(sn)) = sn Then ' keyword line?
      text = modify_keyword_text(text)
      count++
      sn = count + ". "
    Endif

    Print #2, text
  Until EOF(1)

  Close #1
  Close #2
 
  Print SBREF_V1_NEW + " successfully created."
  Pause
End sub

create_new_help_file ' run the program

End
