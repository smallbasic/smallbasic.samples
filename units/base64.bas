
REM Language:  SmallBASIC 0.12.6 (Linux 32-bit)
REM Purpose:   A Base64 Encoder/Decoder UNIT.
REM File name: base64.bas
REM Unit name: base64
REM Version:   1.0.1  21/05/2016
REM Author:    Christian d'Heureuse; shian (See License below)


' Notes:
' 1. Translated from VBasic to SmallBASIC (shian).
'
' 2. Useful for IMAGE keyword, and for any binary-to-text encoding/decoding.
'    Base64 is often used to embed binary data in source code.
'
' 3. Since this is a translated code, I did not add much comments about the
'    encoding/decoding method... So for more details about it see:
'    https://en.wikipedia.org/wiki/Base64
'
' 4. License:
'    - A Base64 Encoder/Decoder. This module is used to encode and decode data
'      in Base64 format as described in RFC 1521.
'    - Home page: www.source-code.biz.
'    - Code from: http://www.source-code.biz/snippets/vbasic/12.htm
'    - License: GNU/LGPL (www.gnu.org/licenses/lgpl.html).
'    - Copyright 2007: Christian d'Heureuse, Inventec Informatik AG, Switzerland.
'    - This module is provided "as is" without warranty of any kind.
'


' -- Start Demo code --- --- --- --- --- --- --- --- --- --- ---
'
' ' ( See also: http://smallbasic.sourceforge.net/?q=comment/1398#comment-1398 )
'
' Import base64                  ' (Import from another .bas file)
'
' Const FILE = "SB.png"          ' (Change it to any other file name)
'
' ' Example using a "file name":
' s = base64.Encode_Base64(FILE) ' Encode 1-D bytes-array to Base64-string
' a = base64.Decode_Base64(s)    ' Decode Base64-string to 1-D bytes-array
'
' i = Image(a)                   ' Convert 1-D bytes-array to image
' i.Show(10, 10)                 ' Show image at location (x, y)
' Showpage
'
' ' Example using a file # (opened for input):
' Open FILE For Input As #1
' s = base64.Encode_Base64(1)    ' Encode 1-D bytes-array to Base64-string
' Close #1
' a = base64.Decode_Base64(s)    ' Decode Base64-string to 1-D bytes-array
'
' i = Image(a)                   ' Convert 1-D bytes-array to image
' i.Show(30, 30)                 ' Show image at location (x, y)
' Showpage
'
' ' Example using 1-D bytes-array (a):
' s = base64.Encode_Base64(a)    ' Encode 1-D bytes-array to Base64-string
' a = base64.Decode_Base64(s)    ' Decode Base64-string to 1-D bytes-array
'
' i = Image(a)                   ' Convert 1-D bytes-array to image
' i.Show(50, 50)                 ' Show image at location (x, y)
' Showpage
'
' Pause
'
' -- End Demo code --- --- --- --- --- --- --- --- --- --- --- ---



Unit base64

Export Encode_Base64, Decode_Base64


' Initialize the helper maps (this code executes only once at load time).
Dim Map1(0 To 63)
Dim Map2(0 To 127)
i = 0

' Set Map1
For c = 65	To  90: Map1(i) = c: i++: Next  ' Asc("A") To Asc("Z")
For c = 97	To 122: Map1(i) = c: i++: Next  ' Asc("a") To Asc("z")
For c = 48	To  57: Map1(i) = c: i++: Next  ' Asc("0") To Asc("9")
Map1(i) = 43 : i++  ' Asc("+")
Map1(i) = 47 : i++  ' Asc("/")

' Set Map2
For i = 0 To 127 Do Map2(i) = 255
For i = 0 To  63 Do Map2(Map1(i)) = i



' Encodes a 1-D bytes array (integers) into Base64 format string.
' No blanks or line breaks are inserted.
' Parameters:
'   InData    1-D bytes array containing the data bytes to be encoded;
'             or, "File_Name" string to load into 1-D bytes array;
'             or, File-Number (opened-for-input) to load into 1-D bytes array.
' Returns:    a string with the Base64 encoded data (that you can embed in
'             your source code).
Func Encode_Base64(InData)
  Local Out                   ' (As Byte)
  Local ODataLen, OLen, ILen  ' (As Long)
  Local ip0, ip, op           ' (As Long)
  Local i0, i1, i2            ' (As Byte)
  Local o0, o1, o2, o3        ' (As Byte)
  Local s, i, fn, f           ' as SmallBASIC...


  If Isarray(InData) Then     ' 1-D bytes array (integers) supplied
    ILen = Len(InData)

  ' Make life easier by loading 1-D bytes array from file:
  Else
    f = Isnumber(InData)      ' Set flag to close file
    If f Then                 ' An opened file # (For Input) supplied
      fn = InData
    Else                      ' A "filename" supplied
      fn = Freefile
      Open InData For Input As #fn
    Fi

    ILen = Lof(fn)
    Dim InData(1 To ILen)     ' (It's much faster to allocate space first!)
    For i = 1 To ILen Do InData(i) = Bgetc(fn)
    If Not f Then Close #fn   ' (Don't close file if File # supplied)
  Fi


  If ILen = 0 Then Encode_Base64 = "": Exit Func

  ODataLen = (ILen * 4 + 2) \ 3   ' Output length without padding
  OLen = ((ILen + 2) \ 3) * 4     ' Output length including padding
  Dim Out(0 To OLen - 1)

  ip0 = LBound(InData)

  ' Encode base64 bytes array (See Wikipedia for this...):
  While ip < ILen
    i0 = InData(ip0 + ip): ip++
    If ip < ILen Then i1 = InData(ip0 + ip): ip++ Else i1 = 0
    If ip < ILen Then i2 = InData(ip0 + ip): ip++ Else i2 = 0

    o0 = i0 \ 4
    o1 = ((i0 Band 3) * 0x10) Bor (i1 \ 0x10)
    o2 = ((i1 Band 0xF) * 4)  Bor (i2 \ 0x40)
    o3 = i2 Band 0x3F

    Out(op) = Map1(o0): op++
    Out(op) = Map1(o1): op++
    Out(op) = Iff(op < ODataLen, Map1(o2), 61): op++  ' 61 is Asc("=")
    Out(op) = Iff(op < ODataLen, Map1(o3), 61): op++  ' 61 is Asc("=")
  Wend

  s = "": For i In Out Do s += Chr(i)  ' Bytes-to-String

  Encode_Base64 = s
End Func



' Decodes a string from Base64 format.
' Parameters
'   s         a Base64 String to be decoded.
' Returns:    a 1-D array containing the decoded data bytes (integers).
Func Decode_Base64(s)
  Local IBuf, Out       ' (As Byte array)
  Local i0, i1, i2, i3  ' (As Byte)
  Local b0, b1, b2, b3  ' (As Byte)
  Local o0, o1, o2      ' (As Byte)
  Local OLen, ip, op    ' (As Long)
  Local ILen = Len(s)   ' (As Long)
  Local i               ' as SmallBASIC...

  If (ILen Mod 4) Or (ILen = 0) Then  ' Data error
    Throw "Length of Base64 encoded input string is not a multiple of 4."
  Fi

  Dim IBuf(0 To ILen - 1)
  For i = 1 To ILen Do IBuf(i - 1) = Asc(Mid(s, i, 1))  ' String-to-Bytes

  While ILen > 0
    If IBuf(ILen - 1) <> 61 Then Exit Loop  ' 61 is Asc("=")
    ILen--
  Wend

  OLen = (ILen * 3) \ 4
  Dim Out(0 To OLen - 1)  ' 1-D bytes array

  ' Decode base64 bytes array (See Wikipedia for this...):
  While ip < ILen
    i0 = IBuf(ip): ip++
    i1 = IBuf(ip): ip++
    If ip < ILen Then i2 = IBuf(ip): ip++ Else i2 = 65  ' 65 is Asc("A")
    If ip < ILen Then i3 = IBuf(ip): ip++ Else i3 = 65  ' 65 is Asc("A")

    If i0 > 127 Or i1 > 127 Or i2 > 127 Or i3 > 127 Then
      Throw "Illegal character in Base64 encoded data."  ' Data error
    Fi

    b0 = Map2(i0)
    b1 = Map2(i1)
    b2 = Map2(i2)
    b3 = Map2(i3)

    If b0 > 63 Or b1 > 63 Or b2 > 63 Or b3 > 63 Then
      Throw "Illegal character in Base64 encoded data."  ' Data error
    Fi

    o0 = (b0 * 4) Bor (b1 \ 0x10)
    o1 = ((b1 Band 0xF) * 0x10) Bor (b2 \ 4)
    o2 = ((b2 Band 3) * 0x40) Bor b3

    Out(op) = o0: op++
    If op < OLen Then Out(op) = o1: op++
    If op < OLen Then Out(op) = o2: op++
  Wend

  Decode_Base64 = Out
End Func
