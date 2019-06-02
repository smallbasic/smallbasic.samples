rem**********************************************************************
REM     FILE -    PRINTA8_5.bas
rem ---------------------------------------------------------------------
rem ROUTINE TO DRAW CHARACTERS WITH DRAW COMMANDrem By Miguel A. MAroto 2019 (from routines translated from TurboBasic of 2001)
rem 
rem for free use but is mandatory maintain author credits
REM rem ----------------------------------------------------------------------
rem rem ROUTINE TO DRAW A TEXT WITH SCALE WITH THE DRAW COMMAND
REM only draw capitals letters and some symbols _ /:;.=<> - , + * ()
REM The tex are in te variable letras
rem  xc and yc  are the initial position of the text
rem  sc is the scale of the text. sc=>1
rem bold = 1 draw character in BoldFace, 0 no Bold
rem UNDERCORE, ud = 1 weite a line under the character (undercore)
REM vertical =1  draw text vertically 
rem micolor defines the text color
rem sep = separation beetwin characters
rem the number of each chararter in the array car(n) is the same of the ASCII code
rem ------------------------------------------------------------------------

rem****************************************************
REM ***************************************************
rem ********** ROUTINE USAGE **************************
rem****************************************************
rem****************************************************
REM FILL THE VARIABLES
REM   POSITION X,Y      SCALE    BOLD    UNDERCORE     VERTICAL TEXT      COLOR TEXT    SEPARATION
REM xc=120  yc= 80      sc =4   bold =1   ud =1      vertical =0      micolor =7         sep =7

REM     TEXT TO PRINT IN letras
REM letras = " HORIZONTAL TEXT"

REM  JUMP TO ROUTINES
REM gosub REFRESH:gosub DRAWCHAR

REM REFRESH  make a refill of the variable that holds the characters and the scale
rem DRAWCHAR  DRAWS efectively the STRING inside letras
rem****************************************************
rem****************************************************
rem****************************************************







rem****************************************************
REM ***************************************************
rem THIS CODE SHOULD BE INCLUDE IN YOUR MAIN
rem****************************************************
rem****************************************************
rem DIMENSION of variable for characters
dim car (150)
rem FILL the matrix of characters with emthy espace for eliminate not defined characters
for f=1 to 150
   car(f)=""
next  f
rem****************************************************
rem****************************************************




rem------------------------------------------------------------------------------------------
rem------------------------------------------------------------------------------------------
REM *********HERE YOUR MAIN CODE*************************************************************
rem------------------------------------------------------------------------------------------
rem------------------------------------------------------------------------------------------


rem------------------------------------------------------------------------------------------
rem FOR DEMO PURPOSES I INCLUDE SOME TEXT EFECT
rem------------------------------------------------------------------------------------------

rem ROUTINE TO EXPAND THE SRCEEN TO VIEW THE FUL TEXT
REM Change parameter of printing
 xc=20: yc= 80: sc =4: bold =1: ud =0 : vertical =0: micolor =12:sep =7
letras = "EXPAND YOUR SCREEN UNTIL YOU CAN READ THIS FULL MESSAGE"
gosub REFRESH:gosub DRAWCHAR

PAUSE 5

rem clear screen
RECT 10,10, 2000,5000, color 0 FILLED

REM ------------------------------------------------------

rem adjust the separation between chararters to 2+sc (scale) pixels to scale  1:1
bold =0: rem draws in BoldFace
ud =0 : rem make undercore
vertical =1:REM WRITE THE TEXT IN VERTICAL
xc= 80
yc= 80
rem Scale factor = sc
sc =3: rem scale
sep =7: rem separion beetwin characters
micolor =12 
REM go to routine to refresh the scale in the variable car(n) with the value of th escale sc
GOSUB REFRESH
 
rem letras = "ABCDEFGHIJKLMNOPQRSTUVWXYZ ? _ /:;.=<> - , + * ()"
rem letras = "ABCDEFGHIJKLMNOPQRSTUVWXZ 0123456789 /:;.=<> - , + * ()"
rem letras ="0123456789 A_A B_B     ? /:;.=<> - , + * ()"
rem letras = "O P OP PO OO PP OPQ TPA BPB GPC HPR UPU "
letras =" VERTICAL TEXT"
rem --------------------------------------------------------
rem HOST PROGRAM  one line of characters
gosub DRAWCHAR:rem firs line of characters

rem --------------------------------------------------------
rem other printing with other modifyers

REM Change parameter of printing
 xc=120: yc= 80: sc =4: bold =1: ud =1 : vertical =0: micolor =7:sep =7
letras = " HORIZONTAL TEXT"
gosub REFRESH:gosub DRAWCHAR

rem several columns
REM Change parameter of printing
 xc=220: yc= 180: sc =3: bold =0: ud =0 : vertical =1: micolor =8:sep =7
for coco =1 to 8
letras = "COLUMN"+ STR(VAL(coco))
gosub REFRESH:gosub DRAWCHAR
xc =xc + 100:yc=180
next coco

rem several rows
REM Change parameter of printing
 xc=220: yc= 480: sc =1: bold =0: ud =0 : vertical =0: micolor =2:sep =7
for ro =1 to 6
letras = " ROWS NUMBER ="+ STR(VAL(ro))
gosub REFRESH:gosub DRAWCHAR
xc =xc + 50:rem xc=380
if ro > 4 then ud=1
if ro > 4 then bold=1

next ro

rem several rows with scal chang
REM Change parameter of printing
 xc=20: yc= 580: sc =1: bold =1: ud =1 : vertical =0: micolor =10:sep =7
for ro =1 to 9
letras = "SIZE"+ STR(VAL(ro))
gosub REFRESH:gosub DRAWCHAR
xc =xc + 30
sc =ro
if ro > 3 then ud=0
if ro > 3 then bold=0
next ro

REM PRINTING NO DEFINED CHARACTERS
 xc=120: yc= 450: sc =3: bold =1: ud =1 : vertical =0: micolor =14:sep =7
letras = "PRINT ONLY CAPITASLS abcde OTHER CHARACTERS CONVERT TO SPACES"
gosub REFRESH:gosub DRAWCHAR

rem --------------------------------------------------------------------------------------------
rem WAIT SCREEN
for espera= to 50
 
 xc=950: yc= 400: sc =8: bold =1: ud =0 : vertical =0: micolor =15:sep =7
letras = "WAIT 50 = "+ STR(espera)
micolor=15
gosub REFRESH:gosub DRAWCHAR
DELAY 200
xc=950: yc= 400
micolor =0
gosub REFRESH:gosub DRAWCHAR

next espera

rem clear screen
RECT 10,10, 2000,5000, color 0 FILLED
rem ---------------------------------------------------------------------------------------------
REM MOVING TEXT !!! (1)
 xc=120: yc= 650: sc =4: bold =1: ud =0 : vertical =0: micolor =12:sep =7
letras = "MOVING TEXT !"
speedx =3: rem speed of text displacement X
speedy =2: rem speed of text displacement X
  bufx = xc
  bufy = yc
for mo=1 to 400
  micolor=12
  bufx = xc
  bufy = yc
gosub REFRESH:gosub DRAWCHAR
rem micorlor =0 for erasing if background is black
micolor =0:xc=bufx: yc=bufy 
DELAY 2
gosub REFRESH:gosub DRAWCHAR
  xc=bufx+speedx
  
  yc=bufy-speedy

micolor =12

next mo
rem ------------------------------------------
REM MOVING TEXT !!! (2)
 xc=120: yc= 100: sc =4: bold =1: ud =0 : vertical =0: micolor =12:sep =7
letras = "MOVING TEXT !"
speedx =3: rem speed of text displacement X
speedy =: rem speed of text displacement X
  bufx = xc
  bufy = yc
  
for mo=1 to 400
  micolor=12
  bufx = xc
  bufy = yc
gosub REFRESH:gosub DRAWCHAR
rem micorlor =0 for erasing if background is black
micolor =0:xc=bufx: yc=bufy 
DELAY 1
gosub REFRESH:gosub DRAWCHAR
  xc=bufx+speedx
  if mo>0 and mo<100 then speedy = speedy *-1
  if mo>100 and mo<200 then speedy = speedy *-1
 if mo>200 and mo<300 then speedy = speedy *-1
  yc=bufy-speedy

micolor =12

next mo


end
stop
REM **************************************************************************************************************************
REM **************************************************************************************************************************
REM  ************************************END of HOST PROGRAM *****************************************************************
REM **************************************************************************************************************************
REM **************************************************************************************************************************


REM **************************************************************************************************************************
REM *************************************ROUTINES ROUTINES ROUTINES***********************************************************
REM **************************************************************************************************************************
REM -------------------------------------------------------------------------------------------------
REM ROUTINE DRAWCHAR - Draw the characters in the variable letras at pe position xc, yc with the scale escala
REM -------------------------------------------------------------------------------------------------
 LABEL DRAWCHAR
 
rem DEFINE COLOR
COLOR micolor
rem LOOP OF DRAWING
for S=1 to len(letras ):rem ------------------------
rem Set the initial position (xc, yc) that will be moved to the right for each character without plot
posicion ="bm"+STR(xc)+","+STR(yc)
draw posicion 

rem Extract each character one by one and  draw it
bit =MID(letras ,S,1)
rem TWO SOLUTION for no defined characters, 1- Draw a Space, 2- Draw a SQUARE, You choose wich and uncoment the corresponding line
if bit ="" then bit =" ":rem Solution 1- Draw a SPACE
rem if car(asc(bit)) ="" then bit ="bu"+str(1*sc)+"r"+str(4*sc)+"u"+str(7*sc)+"l"+str(4*sc)+"d"+str(7*sc):draw(bit):rem Solution 2- Draw a SQUARE

rem ------------------
if vertical=1 THEN goto WRITEVERTICAL ELSE goto NOVERTICAL
rem -------------------
LABEL WRITEVERTICAL
rem ROUTINE to DRAW TEXT VERTICALLY
posicion ="bm"+STR(xc)+","+STR(yc):draw posicion

LABEL NOVERTICAL

rem  1 STROKE Draw the first stroke of the character
draw (car (asc(bit)))
rem 2 STROKE, Prepares the second stroke moving 1 pixel  over X
if bd =0 then goto SINGLE 
if sc=1 then separacion =2
xc=xc+1+separacion:moverse="bm"+STR(xc)+","+STR(yc):draw (moverse):draw(car(asc(bit)))

LABEL SINGLE

rem CHANGE HEIGHT if VERTICAL is ON
Rem add the heigth to put the next character down
if vertical =1 THEN yc =yc+11*sc
if vertical =1 THEN xc=(xc-7*sc)- INT(0.1*sc)
rem -------------BOLD ROUTINE
if bold=0 THEN goto NOBOLD
rem 3 STROKE, Third stroke with offset of 1 pixel over Y
yc=yc+1:moverse="bm"+STR(xc)+","+STR(yc):draw (moverse):draw(car(asc(bit)))
rem Returns 1 pixel in Y axe
yc=yc-1:moverse="bm"+STR(xc)+","+STR(yc):draw (moverse):draw(car(asc(bit)))
rem ----------END BOLD ROUTINE 
LABEL NOBOLD


rem return to the initial position previous to bold
posicion ="br"+STR(xc)
draw (posicion )

rem UNDERCORE------------------------
if ud=0 THEN GOTO NOUNDERCORE
rem jump spaces
if bit =" " THEN GOTO NOUNDERCORE
retro=0:rem space to retuns of one character taking in account the scale sc
rem returns to the estart of the actual character
xc=xc-retro*sc: back = "bl"+STR(xc):draw(back):rem
REM DRAW the undercore
REM undercore ="d"+str(1*sc)+ "r"+str(5*sc)+"u"+str(1*sc)+"l"+str(5*sc)
undercore ="bd"+str(1*sc)+ "l"+str(8*sc)+"br"+str(8*sc)
draw (undercore)
 rem Set the posoition of the next character proportional to sc
rem advance to the final position of the actual character to compesante the undercore
xc=xc+retro*sc: fd = "br"+STR(xc):draw(fd):rem
LABEL NOUNDERCORE

rem Set the posoition of the next character proportional to sc
xc=xc+sep*sc
rem Set the cursor on the next character
posicion ="br"+STR(xc)
draw (posicion) 

next S

RETURN
rem----------------------------------------------------------------------------------------------- 

REM *********************************************************************************************
rem *************************************ROUTINE REFRESH ****************************************
REm ROutine to refresh the variable CAR(n) with the scle sc *************************************
REM *********************************************************************************************
REM *********************************************************************************************
LABEL REFRESH
car(32)="br"+str(5*sc):rem SPACE
car(40)="br"+str(4*sc)+" bu"+str(10*sc)+" g"+str(2*sc)+" d"+str(7*sc)+" f"+str(2*sc)+" bu"+str(1*sc)+" br"+str(3*sc) :rem (
car(41)="br"+str(1*sc)+ " bu"+str(10*sc)+" f"+str(2*sc)+" d"+str(7*sc)+" g"+str(2*sc)+" bu"+str(1*sc)+" br"+str(4*sc):rem )
car(42)="br"+str(3*sc)+" bu"+str(4*sc)+" nu"+str(3*sc)+" nd"+str(3*sc)+" nl"+str(3*sc)+" nr"+str(3*sc)+" nf"+str(2*sc)+" nh"+str(2*sc): rem *
car(42)=car(42) +"ne"+str(2*sc)+"ng"+str(2*sc)+"bd"+str(4*sc)+"br"+str(4*sc)
car(43)="br"+str(3*sc)+ "bu"+str(4*sc)+ "nu"+str(3*sc)+"nd"+str(3*sc)+"nl"+str(3*sc)+ "nr"+str(3*sc)+"bd"+str(4*sc)+ "br"+str(2*sc):rem +
car(44)="br"+str(3*sc)+ "bu"+str(1*sc)+ "g"+str(2*sc)+ "be"+str(1*sc)+ "br"+str(3*sc):rem ,
car(45)="br"+str(3*sc)+"bu"+str(4*sc)+ "nl"+str(3*sc)+ "nr"+str(3*sc)+  "bd"+str(4*sc)+"br"+str(2*sc):rem -
car(46)="br"+str(3*sc)+ "u"+str(1*sc)+ "r"+str(1*sc)+ "d"+str(1*sc)+ "l"+str(1*sc)+ "br"+str(2*sc):rem .
car(47)= "e"+str(6*sc)+"bd"+str(6*sc):rem /
car(48)="br"+str(4*sc)+ "bu"+str(1*sc)+ "g"+str(1*sc)+ "l"+str(2*sc)+ "h"+str(1*sc)+ "u"+str(7*sc)+ "e"+str(1*sc)+ "r"+str(2*sc)+ "f"+str(1*sc)+ "d"+str(7*sc)+ "bf"+str(1*sc):rem 0
rem ---------------------
car(49)="br"+str(1*sc)+ "r"+str(4*sc)+ "l"+str(2*sc)+ "u"+str(9*sc)+ "g"+str(2*sc)+ "r"+str(2*sc)+ "bd"+str(7*sc)+ "br"+str(2*sc):rem 1
car(50)="bu8 e1 r3 f1 d1 g5 d2 r5 u1 bd1":rem 2
car(50)="bu"+str(8*sc)+ "e"+str(1*sc)+ "r"+str(3*sc)+ "f"+str(1*sc)+ "d"+str(1*sc)+ "g"+str(5*sc)+ "d"+str(2*sc)+ "r"+str(5*sc)+ "u"+str(1*sc)+ "bd"+str(1*sc):rem 2
car(51)="bu"+str(1*sc)+"f"+str(1*sc)+"r"+str(3*sc)+"e"+str(1*sc)+"u"+str(3*sc)+"h"+str(1*sc)+"l"+str(3*sc)+"br"+str(3*sc)+"e"+str(1*sc): Rem 3 parte 1
car(51)=car(51)+"u"+str(2*sc)+"h"+str(1*sc)+"l"+str(3*sc)+ "g"+str(1*sc)+"br"+str(5*sc)+"bd"+str(8*sc):rem 3 parte 2
car(52)="br"+str(3*sc)+ "r"+str(2*sc)+ "l"+str(1*sc)+ "u"+str(9*sc)+ "g"+str(4*sc)+ "d"+str(1*sc)+ "r"+str(5*sc)+ "bd"+str(4*sc):rem 4
car(53)="bu"+str(1*sc)+ "f"+str(1*sc)+ "r"+str(3*sc)+ "e"+str(1*sc)+ "u"+str(3*sc)+ "h"+str(1*sc)+ "l"+str(4*sc)+ "u"+str(4*sc)+ "r"+str(5*sc)+ "bd"+str(9*sc):rem 5
car(54)="br"+str(4*sc)+"bu"+str(9*sc)+"l"+str(1*sc)+"g"+str(2*sc)+"d"+str(6*sc)+"f"+str(1*sc)+"r"+str(3*sc)+"e"+str(1*sc)+"u"+str(3*sc)+"h"+str(1*sc)+"l"+str(4*sc)+"br"+str(4*sc)+"bd"+str(5*sc):rem 6
car(55)="br"+str(2*sc)+"u"+str(3*sc)+"e"+str(3*sc)+"u"+str(3*sc)+"l"+str(5*sc)+"d"+str(1*sc)+"br"+str(5*sc)+"bd"+str(8*sc):rem 7
car(56)="bu"+str(8*sc)+"d"+str(2*sc)+"f"+str(1*sc)+"g"+str(1*sc)+"d"+str(3*sc)+"f"+str(1*sc)+"r"+str(3*sc)+"e"+str(1*sc)+"u"+str(3*sc)+"h"+str(1*sc):rem 8 Parte 1
car(56)= car(56)+"l"+str(3*sc)+"br"+str(3*sc)+"e"+str(1*sc)+"u"+str(2*sc)+"h"+str(1*sc)+"l"+str(3*sc)+"g"+str(1*sc)+"br"+str(5*sc)+"bd"+str(8*sc): REM 8 parte 2
car(57)="br"+str(1*sc)+"r"+str(2*sc)+"e"+str(2*sc)+"u"+str(6*sc)+"h"+str(1*sc)+"l"+str(3*sc)+"g"+str(1*sc)+"d"+str(2*sc)+"f"+str(1*sc)+"r"+str(4*sc)+"bd"+str(5*sc):rem 9
rem -------------------
car(58)="br"+str(3*sc)+"bu"+str(1*sc)+"u"+str(1*sc)+ "bu"+str(3*sc)+ "u"+str(1*sc)+ "bd"+str(6*sc)+ "br"+str(2*sc):rem :
car(59)="br"+str(3*sc)+ "bu"+str(1*sc)+ "g"+str(2*sc)+ "be"+str(1*sc)+ "br"+str(1*sc)+ "bu"+str(4*sc)+ "u"+str(1*sc)+ "bd"+str(5*sc)+ "br"+str(3*sc):rem ;
car(60)="br"+str(4*sc)+ "bu"+str(7*sc)+ "g"+str(3*sc)+ "f"+str(3*sc)+ "br"+str(1*sc)+"bd"+str(1*sc):rem <
car(61)="br"+str(1*sc)+ "bu"+str(3*sc)+ "r"+str(3*sc)+"bu"+str(2*sc)+ "l"+str(3*sc)+ "br"+str(4*sc)+ "bd"+str(5*sc):rem =
car(62)="br"+str(1*sc)+"bu"+str(7*sc)+ "f"+str(3*sc)+ "g"+str(3*sc)+ "bd"+str(1*sc)+ "br"+str(4*sc):rem >
car(63)="br"+str(1*sc)+ "u"+str(1*sc)+ "bu"+str(1*sc)+ "u"+str(1*sc)+"e"+str(2*sc)+"u"+str(2*sc)+"h"+str(1*sc)+"l"+str(2*sc)+"g"+str(1*sc)+"bd"+str(7*sc)+"br"+str(1*sc):rem ?
rem car(64)="br"+str(3*sc)+ "bu"+str(4*sc)+ "nl"+str(3*sc)+"nr"+str(3*sc)+"bd"+str(4*sc)+"br"+str(2*sc):rem ARROBA HACER
rem ---------------
car(65)="u"+str(6*sc)+"e"+str(3*sc)+"f"+str(3*sc)+"d"+str(6*sc)+"u"+str(4*sc)+"l"+str(6*sc)+"d"+str(4*sc)+"br"+str(6*sc):rem A
car(66)="r"+str(5*sc)+"e"+str(1*sc)+"u"+str(3*sc)+"h"+str(1*sc)+"l"+str(4*sc)+"br"+str(4*sc)+"e"+str(1*sc)+"u"+str(2*sc)+"h"+str(1*sc)+"l"+str(5*sc):rem b parte 1
car(66)=car(66)+"r"+str(1*sc)+"d"+str(9*sc)+"br"+str(5*sc):rem B Parte 2
car(67)="br"+str(5*sc)+"bu"+str(1*sc)+"g"+str(1*sc)+"l"+str(3*sc)+"h"+str(1*sc)+"u"+str(7*sc)+"e"+str(1*sc)+"r"+str(3*sc)+"f"+str(1*sc)+"bd"+str(8*sc)+"br"+str(1*sc):rem C
car(68)="r"+str(5*sc)+"e"+str(1*sc)+ "u"+str(7*sc)+"h"+str(1*sc)+"l"+str(5*sc)+"r"+str(1*sc)+"d"+str(9*sc)+"br"+str(5*sc):rem D
car(69)="br"+str(5*sc)+"bu"+str(1*sc)+"g"+str(1*sc)+"e"+str(1*sc)+"d"+str(1*sc)+"l"+str(5*sc)+"r"+str(1*sc)+"u"+str(5*sc)+"r"+str(2*sc)+"u"+str(1*sc):rem E Parte 1
car(69)=car(69)+"d"+str(2*sc)+"u"+str(1*sc)+"l"+str(2*sc)+"u"+str(4*sc)+"l"+str(1*sc)+"r"+str(5*sc)+"d"+str(1*sc)+"h"+str(1*sc)+"br"+str(1*sc)+"bd"+str(9*sc):rem E
car(70)="br"+str(1*sc)+"r"+str(2*sc)+"l"+str(1*sc)+"u"+str(5*sc)+"r"+str(3*sc)+"u"+str(1*sc)+"d"+str(2*sc)+"u"+str(1*sc)+"l"+str(3*sc):rem F Pparte 1
car(70)=car(70)+"u"+str(4*sc)+"l"+str(1*sc)+"r"+str(5*sc)+"d"+str(1*sc)+"h"+str(1*sc)+"br"+str(1*sc)+"bd"+str(9*sc)+"bl"+str(1*sc):rem F Parte 2
car(71)="br"+str(3*sc)+"bu"+str(4*sc)+"r"+str(2*sc)+"d"+str(4*sc)+"u"+str(1*sc)+"g"+str(1*sc)+"l"+str(3*sc)+"h"+str(1*sc)+"u"+str(7*sc):rem G Parte 1
car(71)=car(71)+"e"+str(1*sc)+"r"+str(3*sc)+"f"+str(1*sc)+"bd"+str(8*sc): rem G parte 2 
car(72)="u"+str(9*sc)+"bd"+str(4*sc)+"r"+str(5*sc)+"u"+str(4*sc)+"d"+str(9*sc):rem H
car(73)="br"+str(1*sc)+"r"+str(2*sc)+"l"+str(1*sc)+"u"+str(9*sc)+"l"+str(1*sc)+"r"+str(2*sc)+"br"+str(2*sc)+"bd"+str(9*sc):rem I
car(74)="br"+str(1*sc)+"bu"+str(2*sc)+"d"+str(1*sc)+"f"+str(1*sc)+"r"+str(1*sc)+"e"+str(1*sc)+"u"+str(8*sc)+"l"+str(2*sc)+"r"+str(4*sc)+"bd"+str(9*sc)+"bl"+str(1*sc):rem J
car(75)="r"+str(1*sc)+"u"+str(9*sc)+"l"+str(1*sc)+"br"+str(4*sc)+"d"+str(2*sc)+"g"+str(3*sc)+"f"+str(3*sc)+"d"+str(1*sc)+"br"+str(1*sc):rem K
car(76)="br"+str(5*sc)+"bu"+str(1*sc)+"g"+str(1*sc)+"e"+str(1*sc)+"d"+str(1*sc)+"l"+str(5*sc)+"r"+str(1*sc)+"u"+str(9*sc)+"l"+str(1*sc)+"r"+str(2*sc)+"br"+str(3*sc)+"bd"+str(9*sc): rem L
car(77)="u"+str(9*sc)+"f"+str(3*sc)+"e"+str(3*sc)+"d"+str(9*sc)+"bl"+str(1*sc):rem M
car(78)="u"+str(9*sc)+"f"+str(5*sc)+"u"+str(5*sc)+"d"+str(9*sc):rem N
car(79)="br"+str(1*sc)+"h"+str(1*sc)+"u"+str(7*sc)+"e"+str(1*sc)+"r"+str(3*sc)+"f"+str(1*sc)+"d"+str(7*sc)+"g"+str(1*sc)+"l"+str(3*sc)+"br"+str(4*sc):rem O
car(80)="br"+str(1*sc)+"r"+str(2*sc)+"bl"+str(1*sc)+"u"+str(9*sc)+"r"+str(3*sc)+"f"+str(1*sc)+"d"+str(3*sc)+"g"+str(1*sc)+"l"+str(3*sc)+"br"+str(4*sc)+"bd"+str(4*sc):rem  P
car(81)="br"+str(1*sc)+"h"+str(1*sc)+"u"+str(7*sc)+"e"+str(1*sc)+"r"+str(3*sc)+"f"+str(1*sc)+"d"+str(7*sc)+"g"+str(1*sc)+"l"+str(3*sc):rem Q Parte 1
car(81)=car(81)+"r"+str(3*sc)+"bu"+str(1*sc)+"f"+str(2*sc)+"bu"+str(1*sc):rem Q parte 2
car(82)="br"+str(1*sc)+"r"+str(2*sc)+"bl"+str(1*sc)+"u"+str(9*sc)+"l"+str(1*sc)+"r"+str(4*sc)+"f"+str(1*sc)+"d"+str(3*sc)+"g"+str(1*sc):rem  R Parte 1  
car(82)=car(82)+ "l"+str(3*sc)+"br"+str(2*sc)+"f"+str(2*sc)+"d"+str(2*sc):rem  R Parte 2
rem --------------------------------------------
car(83)="bu"+str(2*sc)+"d"+str(1*sc)+"f"+str(1*sc)+"r"+str(3*sc)+"e"+str(1*sc)+"u"+str(1*sc)+"h"+str(5*sc)+"u"+str(1*sc):rem S parte 1
car(83)=car(83)+"e"+str(1*sc)+"r"+str(3*sc)+"f"+str(1*sc)+"d"+str(1*sc)+"bd"+str(7*sc):rem S Parte 2
car(84)="br"+str(1*sc)+"r"+str(2*sc)+"l"+str(1*sc)+"u"+str(9*sc)+"l"+str(3*sc)+"d"+str(1*sc)+"e"+str(1*sc):rem T Parte 1
car(84)= car(84)+"r"+str(5*sc)+"d"+str(1*sc)+"h"+str(1*sc)+"bf"+str(1*sc)+"bd"+str(8*sc):rem Parte 2
car(85)="bu"+str(9*sc)+"d"+str(8*sc)+"f"+str(1*sc)+"r"+str(3*sc)+"e"+str(1*sc)+"u"+str(8*sc)+"bd"+str(9*sc):rem U
car(86)="bu"+str(9*sc)+"d"+str(6*sc)+"f"+str(3*sc)+"e"+str(3*sc)+"u"+str(6*sc)+"bd"+str(9*sc):rem V
car(87)="bu"+str(9*sc)+"d"+str(7*sc)+"f"+str(2*sc)+"e"+str(1*sc)+"u"+str(2*sc)+"d"+str(2*sc)+"f"+str(1*sc)+"e"+str(2*sc)+"u"+str(7*sc)+"bd"+str(9*sc):rem W
car(88)="bu"+str(9*sc)+"d"+str(2*sc)+"f"+str(5*sc)+"d"+str(2*sc)+"bl"+str(5*sc)+"u"+str(2*sc)+"e"+str(5*sc)+"u"+str(2*sc)+"bd"+str(9*sc):rem X
car(89)="br"+str(1*sc)+"r"+str(2*sc)+"l"+str(1*sc)+"u"+str(5*sc)+"e"+str(2*sc)+"u"+str(2*sc)+"bl"+str(4*sc)+"d"+str(2*sc)+"f"+str(2*sc)+"bd"+str(5*sc)+"br"+str(2*sc):rem Y
Rem ----------------
car(90)="br"+str(5*sc)+"bu"+str(1*sc)+"g"+str(1*sc)+"be"+str(1*sc)+"d"+str(1*sc)+"l"+str(5*sc)+"u"+str(2*sc):rem Z parte 1
car(90)=car(90)+"e"+str(5*sc)+"u"+str(2*sc)+"l"+str(5*sc)+"d"+str(1*sc)+"e"+str(1*sc)+"br"+str(5*sc)+"bd"+str(9*sc):rem Z parte 2
car(95) = "br"+str(1*sc)+"r"+str(4*sc):rem low undercore _
rem --------------------------------------------------------------


RETURN
rem ******************************END OF CODE**************************************