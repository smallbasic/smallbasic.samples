'B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+
'
'  My Song.bas using SmallBASIC FLTK 11.5 (for Windows)
'        for Bpf thread Moody Blues Fan? 2/4/15, HWPinc
'
' demo: "Pig-pen" code style tolerance = case insensitive, indents mean nothing
'        TLOAD "file", array, (0=default)
'        += (x=x+1)
'        !=NOT 
'        FI=END IF or ENDIF or END (a code block)
'        ?=PRINT (saves on typing)
'
'B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+
dim soNGlyric()
InpuT " press (enter) to see full lyrics to 'My Song' (any key + enter to quit)";Yes
if !len(yes) then
 ' notice array variable does not need (), 
 'default or 0 mode, default: TLOAD "the file", array
 '               or,  0 mode: TLOAD "my file", myarray, 0
   TLOAD "My Song.txt",songlyric
   For i= 0 to len(sOnglyric)-1
       PRint songlyRIC(i)
       displayCOUNT+=1
       iF frAc(disPLAYcount/30)=0 thEn
           ?  'alternate PRINT
           input "Enter to continue, s=stop "; displaystop
           if ucase(displaySTOP)="S" then
               eXit
           else
               cls
fi
FI      
neXt     
fi
?:?:?
'let's try loading HTML to a string and make code look nicer
INPUT "How about: 'Nice To Be Here' in HTML [just (enter)=yes, any key+(enter)=no]";yes
IF !LEN(yes) THEN
 'notice string variable does not need $, 
 'mode 1 would TLOAD the file into a string variable
 TLOAD "Nice To Be Here.html",HTMLlyricString, 1
 HTML HTMLlyricString
FI
'hey it worked for my laptop Windows 7, system 64      
