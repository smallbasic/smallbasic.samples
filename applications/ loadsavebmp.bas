
rem Title: LoadSaveBMP
rem Description: Subroutines for loading and saving 24bit BMP image files
rem Category: Applications
rem Copyright: Keijo Koskinen
rem Email: keijoko@csolve.net
rem Created: 22.07.2005
rem Version: 0.9
rem Sbver: SB 0.9.5
''';  Subroutines for loading and saving
'';   for   24bit .BMP   images
 ''; for SmallBasic by Keijo Koskinen  20.07.2005
 ''; If you have image other than 24bit .BMP
 ''; use Paint, MSPaint or Irfanview (free/good one)
 ''; to change  (=to save ) image to 24bit BMP
 
sub bmpload(name,bx,by)

fh=freefile
open  name + ".bmp" For Input As #fh

 Dim bmhead(55)
 For iii=1 To 53
 bmhead(iii)= bgetc(fh)   ''; read header info
Next

bmxmax= bmhead(20)*256+bmhead(19)    ''; image width
bmymax=bmhead(24)*256+bmhead(23)     ''; image height

 ''; calculate 32 (4-byte) boundary
bmkk= bmxmax*3   ''; real line length
bmk=fix(bmkk/4)  ''; but it has to be 4-bit
bmk=bmk*4        ''; total length (expanded by 0 :s )
ero=bmk-bmkk     '';  how many 0:s on the end of each line

bmx=bx
bmy=by+bmymax

For bmyy=bmymax To 1 Step -1     ''; loop for pixel info
For bmxx=1 To bmxmax
bmx=bx+bmxx-1
bmy=by+bmyy-1

b= bgetc(fh)                     ''; blue
g= bgetc(fh)                     ''; green
r= bgetc(fh)                     ''; red
bmcol=-(b+(g*256)+(r*256*256))   ''; calculate rgb color value
pset bmx,bmy,bmcol               '';  draw a pixel to screen

Next                             ''; next pixels

If ero>0 Then                  '';  if 32bit (4-byte) boundary
For eri=1 To ero               ''; does not mach
erf=bgetc(fh)                  '';  added zeros have to count off
Next
End If
Next

close #fh
 End
 
 
sub bmpsave(bx1,by1,bx2,by2,name)

fh=freefile
open  name + ".bmp" For output As #fh

 bmpbin=66:bputc #fh,bmpbin                 '';   B      1
 bmpbin=77:bputc #fh,bmpbin                 '';   M      2
 bmpbin=54:bputc #fh,bmpbin                 '';   6      3
 bmpbin=3:bputc #fh,bmpbin                           ''; 4
 bmpbin=0:bputc #fh,bmpbin                           ''; 5
 bmpbin=0:bputc #fh,bmpbin                           ''; 6
 bmpbin=0:bputc #fh,bmpbin                           ''; 7
 bmpbin=0:bputc #fh,bmpbin                           ''; 8
 bmpbin=0:bputc #fh,bmpbin                           ''; 9
 bmpbin=0:bputc #fh,bmpbin                          ''; 10
 bmpbin=54:bputc #fh,bmpbin ''; pixelinfo starts  fr    11
 bmpbin=0:bputc #fh,bmpbin                          ''; 12
 bmpbin=0:bputc #fh,bmpbin                          ''; 13
 bmpbin=0:bputc #fh,bmpbin                          ''; 14
 bmpbin=40:bputc #fh,bmpbin                         ''; 15
 bmpbin=0 :bputc #fh,bmpbin                         ''; 16
 bmpbin=0:bputc #fh,bmpbin                          ''; 17
 bmpbin=0:bputc #fh,bmpbin                          ''; 18
 bmdatxh=Int((bx2-bx1+1)/256)
 bmdatxl=(bx2-bx1+1)-bmdatxh*256
 bmpbin=bmdatxl:bputc #fh,bmpbin  ''; image width lb    19
 bmpbin=bmdatxh :bputc #fh,bmpbin ''; image width hb    20
 bmpbin=0 :bputc #fh,bmpbin                         '' ;21
 bmpbin=0 :bputc #fh,bmpbin                         ''; 22
 bmdatyh=Int((by2-by1+1)/256)
 bmdatyl=(by2-by1+1)-bmdatyh*256
 bmpbin=bmdatyl:bputc #fh,bmpbin  ''; image height lb   23
 bmpbin=bmdatyh :bputc #fh,bmpbin ''; image height hb   24
 bmpbin=0:bputc #fh,bmpbin                          ''; 25
 bmpbin=0:bputc #fh,bmpbin                          ''; 26
 bmpbin=1:bputc #fh,bmpbin        ''; number of planes  27
 bmpbin=0:bputc #fh,bmpbin                          ''; 28
 bmpbin=24 :bputc #fh,bmpbin    ''; 24bit image         29
 bmpbin=0:bputc #fh,bmpbin                          ''; 30
 bmpbin=0:bputc #fh,bmpbin      ''; 0= nocompression    31
 bmpbin=0:bputc #fh,bmpbin                          ''; 32
 bmpbin=0:bputc #fh,bmpbin                          ''; 33
 bmpbin=0:bputc #fh,bmpbin                          ''; 34

 bmkk= ((bx2-bx1)+1)*3   ''; real line length
bmk=fix(bmkk/4)  ''; but it has to be 4-bit
bmk=bmk*4        ''; total length (expanded by 0 :s )
ero=bmk-bmkk     '';  how many 0:s on the end of each line
bmtot=(bmk*(by2-by1+1))  ''; +54

bml=Int(bmtot/256)
bmll=bmtot-(bml*256)
If bml>256 Then
bmh=Int(bml/256)
bml= bml-(bmh*256)
If bmh>256 Then
bmhh=Int(bmh/256)
bmh=bmh-(bmh*256)
End If
End If
bmpbin=bmll:bputc #fh,bmpbin ''; these 4 bytes are     35
bmpbin=bml:bputc #fh,bmpbin  ''; for length of the     36
bmpbin=bmh:bputc #fh,bmpbin  ''; image file            37
bmpbin=bmhh:bputc #fh,bmpbin '';                       38
bmpbin=19:bputc #fh,bmpbin                         ''; 39
bmpbin=11:bputc #fh,bmpbin                         ''; 40
bmpbin=0:bputc #fh,bmpbin                          ''; 41
bmpbin=0:bputc #fh,bmpbin                          ''; 42
bmpbin=19:bputc #fh,bmpbin                         ''; 43
bmpbin=11:bputc #fh,bmpbin                         ''; 44
bmpbin=0:bputc #fh,bmpbin                          ''; 45
bmpbin=0:bputc #fh,bmpbin                          ''; 46
bmpbin=0:bputc #fh,bmpbin                          ''; 47
bmpbin=0:bputc #fh,bmpbin                          ''; 48
bmpbin=0:bputc #fh,bmpbin                          ''; 49
bmpbin=0:bputc #fh,bmpbin                          ''; 50
bmpbin=0:bputc #fh,bmpbin                          ''; 51
bmpbin=0:bputc #fh,bmpbin                          ''; 52
bmpbin=0:bputc #fh,bmpbin ''; header ending            53
'';bmpbin=0:bputc #fh,bmpbin                          ''; 54
For bmpy=by2 To by1 Step -1
For bmpx=bx1 To bx2
 bmpcolor=point(bmpx,bmpy)
 r=Int(bmpcolor/(256*256))
 g=Int((bmpcolor-(r*256*256))/256)
 b=bmpcolor-(r*256*256)-(g*256)
 bmpbin=b:bputc #fh,bmpbin    ''; first pixel blue     55
 bmpbin=g:bputc #fh,bmpbin    ''; first pixel green    56
 bmpbin=r:bputc #fh,bmpbin    ''; first pixel red      57
Next                          ''; and next three colors

 If ero>0 Then                 ''; if 32bit (4-byte) boundary
 For eri= 1 To ero             ''; does not match
 bmpbin=0:bputc #fh,bmpbin     ''; rows have to be filled  with zeros
 Next                          ''; to macth boundary
 End If
 Next                          ''; next row  (y-value)

close #fh
End


''; sample  commands

 '';  Input name
 '';  bmpload name,x1,y1

 '';  Input name
 '';  bmpsave x1,y1,x2,y2,name
 
'
