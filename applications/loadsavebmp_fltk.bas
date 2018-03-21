
rem Title: LoadSaveBMP_Fltk
rem Description:  Subroutines for loading and saving 24bit .BMP image files in 
rem Small Basic Fltk versions
rem Category: Applications
rem Copyright: Keijo Koskinen
rem Email: keijoko@csolve.net
rem Created: 04.March.2006
rem Version: Fltk
rem Sbver: SB_FLTK Versions
''';  Subroutines for loading and saving
'';  for   24bit .BMP   images for  SB Fltk 0.9.6.4-7
 ''; for SmallBasic by Keijo Koskinen  20.01.2006
 ''; If you have image other than 24bit .BMP
 ''; use Paint, MSPaint or Irfanview (free/good one)
 ''; to change  (=to save ) image to 24bit BMP
 
sub bmpload(name,bx,by)
 ''; this makes sure that file is at write/read mode. Please change "c:\\sb\\" to your path 
CHMOD "c:\\sb\\" + name + ".bmp",0o666 
''; next free file handle
fh=freefile
''; This will open file for loading (reading). Please change "c:\\sb\\" to your path 
open "c:\\sb\\" + name + ".bmp" For Input As #fh
''; This will read the .BMP file header
 Dim bmhead(55)
 For iii=0 To 53
   
 bmhead(iii)= bgetc(fh)   ''; read header info
Next

bmxmax= bmhead(19)*256+bmhead(18)    ''; image width
bmymax=bmhead(23)*256+bmhead(22)     ''; image height

 ''; calculate 32 (4-byte) boundary
bmkk= bmxmax*3   ''; real line length
bmk=fix(bmkk/4)  ''; but it has to be 4-bit
bmk=bmk*4        ''; total length (expanded by 0 :s )
ero=bmk-bmkk     '';  how many 0:s on the end of each line

bmx=bx
bmy=by+bmymax

''; This will read pixel info (in binary mode) from file
For bmyy=bmymax To 1 Step -1     ''; loop for pixel info
For bmxx=1 To bmxmax
bmx=bx+bmxx-1
bmy=by+bmyy-1

b= bgetc(fh)                     ''; blue
g= bgetc(fh)                     ''; green
r= bgetc(fh)                     ''; red
bmcol=-(r+(g*256)+(b*256*256))   ''; calculate rgb color value

pset bmx,bmy,bmcol               '';  draw a pixel to screen

Next                             ''; next pixels

If ero>0 Then                  '';  if 32bit (4-byte) boundary
For eri=1 To ero               ''; does not mach
erf=bgetc(fh)                  '';  added zeros have to count off
Next
End If
Next
''; close file
close #fh
 End
 
 
sub bmpsave(bx1,by1,bx2,by2,name)
''; This makes sure that if file exists, it is at write/read mode. Please change "c:\\sb\\" to your path 
if exist ("c:\\sb\\c.bmp") then CHMOD "c:\\sb\\" + name + ".bmp",0o666
''; next free file handle
fh=freefile
''; This will open file for saving (writing). Please change "c:\\sb\\" to your path 
open "c:\\sb\\" + name + ".bmp" For output As #fh
 ''; writes .BMP file header to file
 bmpbin=66:bputc #fh,bmpbin              '';   B   byte  0
 bmpbin=77:bputc #fh,bmpbin              '';   M         1
 bmpbin=54:bputc #fh,bmpbin              '';   6         2
 bmpbin=3:bputc #fh,bmpbin                           ''; 3
 bmpbin=0:bputc #fh,bmpbin                           ''; 4
 bmpbin=0:bputc #fh,bmpbin                           ''; 5
 bmpbin=0:bputc #fh,bmpbin                           ''; 6
 bmpbin=0:bputc #fh,bmpbin                           ''; 7
 bmpbin=0:bputc #fh,bmpbin                           ''; 8
 bmpbin=0:bputc #fh,bmpbin                          ''; 9
 bmpbin=54:bputc #fh,bmpbin ''; pixelinfo starts  fr    10
 bmpbin=0:bputc #fh,bmpbin                          ''; 11
 bmpbin=0:bputc #fh,bmpbin                          ''; 12
 bmpbin=0:bputc #fh,bmpbin                          ''; 13
 bmpbin=40:bputc #fh,bmpbin                         ''; 14
 bmpbin=0 :bputc #fh,bmpbin                         ''; 15
 bmpbin=0:bputc #fh,bmpbin                          ''; 16
 bmpbin=0:bputc #fh,bmpbin                          ''; 17
 bmdatxh=Int((bx2-bx1+1)/256)
 bmdatxl=(bx2-bx1+1)-bmdatxh*256
 bmpbin=bmdatxl:bputc #fh,bmpbin  ''; image width lb    18
 bmpbin=bmdatxh :bputc #fh,bmpbin ''; image width hb    19
 bmpbin=0 :bputc #fh,bmpbin                         '' ;20
 bmpbin=0 :bputc #fh,bmpbin                         ''; 21
 bmdatyh=Int((by2-by1+1)/256)
 bmdatyl=(by2-by1+1)-bmdatyh*256
 bmpbin=bmdatyl:bputc #fh,bmpbin  ''; image height lb   22
 bmpbin=bmdatyh :bputc #fh,bmpbin ''; image height hb   23
 bmpbin=0:bputc #fh,bmpbin                          ''; 24
 bmpbin=0:bputc #fh,bmpbin                          ''; 25
 bmpbin=1:bputc #fh,bmpbin        ''; number of planes  26
 bmpbin=0:bputc #fh,bmpbin                          ''; 27
 bmpbin=24 :bputc #fh,bmpbin    ''; 24bit image         28
 bmpbin=0:bputc #fh,bmpbin                          ''; 29
 bmpbin=0:bputc #fh,bmpbin      ''; 0= nocompression    30
 bmpbin=0:bputc #fh,bmpbin                          ''; 31
 bmpbin=0:bputc #fh,bmpbin                          ''; 32
 bmpbin=0:bputc #fh,bmpbin                          ''; 33

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
bmpbin=bmll:bputc #fh,bmpbin ''; these 4 bytes are     34
bmpbin=bml:bputc #fh,bmpbin  ''; for length of the     35
bmpbin=bmh:bputc #fh,bmpbin  ''; image file            36
bmpbin=bmhh:bputc #fh,bmpbin '';                       37
bmpbin=19:bputc #fh,bmpbin                         ''; 38
bmpbin=11:bputc #fh,bmpbin                         ''; 39
bmpbin=0:bputc #fh,bmpbin                          ''; 40
bmpbin=0:bputc #fh,bmpbin                          ''; 41
bmpbin=19:bputc #fh,bmpbin                         ''; 42
bmpbin=11:bputc #fh,bmpbin                         ''; 43
bmpbin=0:bputc #fh,bmpbin                          ''; 44
bmpbin=0:bputc #fh,bmpbin                          ''; 45
bmpbin=0:bputc #fh,bmpbin                          ''; 46
bmpbin=0:bputc #fh,bmpbin                          ''; 47
bmpbin=0:bputc #fh,bmpbin                          ''; 48
bmpbin=0:bputc #fh,bmpbin                          ''; 49
bmpbin=0:bputc #fh,bmpbin                          ''; 50
bmpbin=0:bputc #fh,bmpbin                          ''; 51
bmpbin=0:bputc #fh,bmpbin ''; header ending            52
bmpbin=0:bputc #fh,bmpbin                          ''; 53

''; Writes the pixel info of image (in binary mode) to file
For bmpy=by2 To by1 Step -1
For bmpx=bx1 To bx2
    
 bmpcolor=-point(bmpx,bmpy)
 b=Int(bmpcolor/(0x10000))           ''; b
 g=Int((bmpcolor-(r*0x10000))/256)   ''; g
 r=bmpcolor-(r*0x10000)-(g*256)      ''; r
 
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
''; Close file
close #fh
End


   '';******* lets try  the code samples **********
   
''; ***  This is for loading (24bit) .bmp image  
  ''; Input name
  ''; bmpload name,100,100   ''; load image to location x,y
 
''; This for saving as 24bit .bmp image
   '';Input name
   '';bmpsave 100,100,161,189,name    ''; save image area from x1,y1,x2,y2
  
''; **************************************************

''; *** This following has nothing to do with saving or loading 
''; *** Just a small extra routine if you want to copy image on screen from one place to an other place"
  
''; At first we reserves space for info  ( note size  (x,y))

 ''; dim image1(100,100)
   '';x=300
   '';y=100
   '';xx=100
   '';xxi=x+xx
   '';yy=100
   '';yyi=y+yy
''; *** This routine read pixel info to image1(a,b) array
  '';for yi=y to yyi
    '';for xi=x to xxi
      '';image1(xi-x,yi-y)=point(xi,yi)
    '';next
   '';next
      
''; *** This routine drops same image to other position
      
    '';for yi=y to yyi
      '';for xi=x to xxi
        '';pset xi+200,yi+200,image1(xi-x,yi-y)
      '';next
    '';next
      
      

'
