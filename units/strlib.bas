
' File: strlib.bas
' ------------
' In this demo we are using UNIT to add more useful String commands to
' SmallBASIC, by carefully creating our own String-Library: strlib.bas
'
' This demo includes only two useful functions, Lset() and Rset(); You
' can add more useful functions, subs, constants - but make sure that
' they are all String commands (not Array, File, Data, etc).
'
' Write your code carefully and efficiently, because you will use these
' commands frequently in other projects. And don't forget to debug the
' code and to add clear documentation, for you and for others.
'
' See also Home-->Article-->Welcome to SmallBASIC-->Units.
' ------------
'
 
' Here we declare that this file is a UNIT file.
' Note: Keep file-name and unit-name the same. That helps the SB to
'       automatically recompile the required units when it is needed (i.e.
'       to create strlib.sbu file).
'       The actual file name must be in lower case for Linux OS.

Unit strlib ' (without .bas extension)

' Here we allow other SmallBASIC files to use some of our library keywords:

Export Lset, Rset

' Left justify string s in buffer of length b.
' example: x = Lset(" SmallBASIC ", 15) ' --> x is " SmallBASIC    "
Func Lset(s, b)
  Local l = Len(s)
 
  If l >= b Then
    Lset = Left(s, b)
  Else
    Lset = s + Space(b - l)
  Fi
End

' Right justify string s in buffer of length b.
' example: x = Rset(" SmallBASIC ", 15) ' --> x is "    SmallBASIC "
Func Rset(s, b)
  Local l = Len(s)
 
  If l >= b Then
    Rset = Right(s, b)
  Else
    Rset = Space(b - l) + s
  Fi
End
