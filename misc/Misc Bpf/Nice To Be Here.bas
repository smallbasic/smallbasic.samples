'B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+
'
'  Nice To Be Here.bas for Bpf thread Moody Blues Fan? 2/4/15, HWPinc
'
'B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+B+
dim soNGlyric()
InpuT " y=yes (enter) See HTML file I edited lyrics from? just (enter)='No Thanks' ";Yes
if ucase(yes)="Y" then
 TLOAD "Nice To Be Here.HTML",songlyric
   For i= 0 to len(sOnglyric)-1
    PRint songlyRIC(i)
   displayCOUNT=displaycount +1
    if frac(disPLAYcount/30)=0 then
          ?  'alternate PRINT
          input "Enter to continue, s=stop "; displaystop
        if ucase(displaystop)="S" then
            EXit
        else
            cls
        fi
             FI      
      next
'see the pig pen above? still runs      
fi
