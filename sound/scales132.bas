
''' Program: Scales.bas
'' By Alberto Fornasari
'' Version: 1.3.2
'' 16/08/2003

'' Useful constants
const reset=chr$(27)+"[0m"
const ron=chr$(27)+"[7m"
const rof=chr$(27)+"[27m"
const yo=5

'' Selection Parameter
dim SelP(1 to 8)
'' Selection Display
dim SelD(1 to 8)
'' Display Options
dim Dopt(1 to 8)
'' Parameter Options
dim Popt(1 to 8)

'' Notes Numbers
dim NotesN(1 to 9)
'' Notes Frecuencies
dim NotesF(1 to 9)

'' General Fixed Drawings
rect 0,0,159,49 color 9 filled
rect 0,0,159,49
gosub DrwPiano
rect 0,61,159,149 color 9 filled
rect 0,61,159,149
rect 4,65,154,145 color 15 filled
rect 0,150,159,159 filled
at 7,149
? ron+"ScaleMaster V1.3 - By A. L. Fornasari"+rof,
rect 0,150,159,159
at 55,65
? ron+"Scale Type  "
at 55,85
? "Scale Name "
at 55,105
? "Root  Note   "
at 55,125
? " -Octaves-   "
at 105,65
? "Note Durat. "
at 105,85
? "Play Mode   "
at 105,105
? "Play Volum. "
at 105,125
? "PLAY / EXIT "+rof

'' General Init.
randomize ticks
gosub SelDflts
gosub ShwSelFrm
restore s2t5
gosub LoadOpt
gosub ShwOptFrm
msg=left$((Dopt(1)+"-"+Popt(1)),32)
gosub DisMsg
gosub CalcScale
gosub ShwDots
Csel=2
Copt=1

'' Main Loop
pen on
repeat
 if pen(0)
  xp=pen(4)
  yp=pen(5)
  if yp<45 
   gosub KeyAnal
  else
   if yp<65
    gosub Help
   else
    if xp<54
     gosub OptAnal
    else
     gosub SelAnal
    endif
   endif	
  endif
 endif
until(SelP(8)="exit")
pen off
? reset
cls
stop

'' Soubroutines

'' DrwPiano(yo)
Label DrwPiano
rect 4,yo,154,yo+40 color 15 filled
for i=0 to 14
rect 4+10*i,yo,14+10*i,yo+40
if (i<>2)&(i<>6)&(i<>9)&(i<>13)&(i<>14)
rect 11+10*i,yo,18+10*i,yo+24 filled
endif
next
rect 150,yo,155,yo+24 filled
return

Label ShwOptFrm
for i=0 to 7
rect 4,65+10*i,54,75+10*i color 15 filled
next
for i=1 to 8
 at 7,65+10*(i-1) 
 ? left$(Dopt(i),10);
next
for i=0 to 7
 rect 4,65+10*i,54,75+10*i
next
return

Label ShwSelFrm
for i=0 to 3
rect 55,76+20*i,103,85+20*i color 15 filled
rect 105,76+20*i,155,85+20*i color 15 filled
next
for i=1 to 4
 at 55,55+20*i
 ? left$(SelD(i),10)
 at 105,55+20*i
 ? left$(SelD(i+4),10)
next
for i=0 to 7
 rect 54,65+10*i,104,75+10*i
 rect 104,65+10*i,154,75+10*i
 next
return

Label LoadOpt
for i=1 to 8
 read Dopt(i)
 read Popt(i)
next
return

'' Dismsg(msg)
Label DisMsg
rect 0,50,159,60 filled
at 7,50
? ron+msg+rof,
rect 0,50,159,60
return

'' CalcFrec(note,octav):frec
Label CalcFrec
frec=round(16.3516*2^(octav+(note/12)))
return

Label KeyAnal
octav=SelP(4)
if (yp>29) then
 i=int((xp-5)/10)
 j=0
else
 i=int((xp-10)/10)
 j=1
endif 
 if (i>=7) then
  i=i-7
  octav=octav+1
 endif
 note=round(1.76*i)+j
gosub CalcFrec
sound frec,SelP(5),SelP(7) 
return

Label Help
sound 220,1,15
msg="Help: AlbertoFornasari@hotmail.com"
gosub DisMsg
return

Label CalcScale
j=SelP(1)
NotesN(1)=SelP(3)-10
for i=1 to j
NotesN(i+1)=NotesN(i)+val(mid$(SelP(2),i,1))
next
octav=SelP(4)
for i=1 to j+1
 note=NotesN(i)
 gosub CalcFrec
 NotesF(i)=frec
next
return

Label ShwDots
j=SelP(1)+1
for i=1 to j
n=NotesN(i)
m=n mod 12
if (n<12)
 x=0
else
 x=70
endif
if (m=1)|(m=3)|(m=6)|(m=8)|(m=10)
 if (m<5)
  m=m-1
 endif
 x=x+15+5*m
 rect x-2,yo+10,x+1,yo+14 color 15 filled
else
 if (m>4)
  m=m+1
 endif
 x=x+10+5*m
 rect x-2,yo+30,x+1,yo+34 color 0 filled
endif
next
return

Label SeqPlay
j=SelP(1)+1
k=SelP(6)
for i=1 to j
 sound NotesF(i),SelP(5),SelP(7)
 if Pen(0)
  return
 endif
next
if (k mod 2=0)
 for i=2 to j
  sound 2*NotesF(i),SelP(5),SelP(7)
  if Pen(0)
   return
  endif
 next
endif
if (k=4)
 for i=j to 2 step -1
  sound 2*NotesF(i),SelP(5),SelP(7)
  if Pen(0)
   return
  endif
 next
endif
if (k>2)
 for i=j to 1 step -1
  sound NotesF(i),SelP(5),SelP(7)
  if Pen(0)
   return
  endif
 next
endif
return

Label FreePlay
i=1
fm=1
repeat
nn=1+int(SelP(1)*rnd)
nr=1+int(5*rnd)
if nr>3
 nr=1
endif
ns=1+int(4*rnd)
if ns>2
 ns=1
endif
sd=int(2*rnd)
if sd=0
 sd=-1
endif
q=1+int(7*rnd)
if q=1
  fm=0.5*fm
else
 if q=7
  fm=2*fm
 endif
endif
dm=1+int(5*rnd)
if dm=1
  dm=0.5
else
 if dm=5
  dm=2
 else
  dm=1
 endif
endif
rr=1+int(4*rnd)
if rr=1
 i=1
 fm=1
endif
si=i
for j=1 to nr
i=si
for k=1 to nn
if (i=1)|(i=SelP(1)-2)
 vm=1.5
else
 vm=1
endif
sound int(fm*NotesF(i)),int(dm*SelP(5)),int(vm*SelP(7))
if Pen(0)
 return
endif
i=i+sd*ns
if i>SelP(1)
 i=1:fm=2
endif
if i<1
 i=SelP(1):fm=0.5
endif
next
next
until Pen(0)
return

Label Stop
SelD(8)="STOP NOW"
SelP(8)=1
gosub ShwSelFrm
sound 220,1,15
return

Label OptAnal
i=int((yp-65)/10)+1
if (i>8)
 return:fi
if Popt(i)=0
 return:fi
sound 220,1,15
Copt=i
if Popt(Copt)="more"
 gosub LoadOpt
 gosub ShwOptFrm
 return
endif
SelD(Csel)=Dopt(Copt)
SelP(Csel)=Popt(Copt)
gosub ShwSelFrm
if (Csel=1)
 yp=85
 gosub SelAnal
 SelD(2)=Dopt(1)
 SelP(2)=Popt(1)
 gosub ShwSelFrm
endif 
if (Csel<5)
msg=left$((SelD(2)+"-"+SelP(2)),32)
 gosub DisMsg
 gosub CalcScale
 gosub DrwPiano
 gosub ShwDots
endif
if (Csel=8)
 if SelP(8)=2
  gosub SeqPlay
  gosub Stop
 endif
 if SelP(8)=3
  repeat
   gosub SeqPlay
  until Pen(0)
  gosub Stop
 endif
 if SelP(8)=4
  gosub FreePlay
  gosub Stop
 endif
endif
return

Label SelAnal
i=int((yp-65)/20)+1
if (i>4)
 return
endif
if (xp>105)
 i=i+4
endif
sound 220,1,15
if (i=1)
 restore s1:fi
if (i=3)
 restore s3:fi
if (i=4)
 restore s4:fi
if (i=5)
 restore s5:fi
if (i=6)
 restore s6:fi
if (i=7)
 restore s7:fi
if (i=8)
 restore s8:fi
if (i=2)
 if SelP(1)=5
  restore s2t5:fi
 if SelP(1)=6
  restore s2t6:fi
 if SelP(1)=7
  restore s2t7:fi
 if SelP(1)=8
 restore s2t8:fi
endif
Csel=i
gosub LoadOpt
gosub ShwOptFrm
return

Label SelDflts
for i=1 to 8
 read SelD(i)
 read SelP(i)
next
data "Pentatonic",5
data "Maj.Pentatonic(C/F/Fs/G)"
data "22323"
data "C  ,Do  ,0",10
data " 4 and 5",4
data "Quarter",256
data "Up/Down 1",3
data "&#8226;&#8226;&#8226;&#8226;&#8226;",33
data "STOP NOW",1
return

'' General DATA

Label s1
data "Pentatonic",5
data "Hexatonic",6
data "Heptatonic",7
data "Octatonic",8
data "",0
data "",0
data "",0
data "",0

Label s3
data "C  ,Do  ,0",10
data "Cs,Do#,1",11
data "D  ,Re  ,2",12
data "Ds,Re#,3",13
data "E   ,Mi ,4",14
data "F   ,Fa ,5",15
data "Fs ,Fa# ,6",16
data "-- MORE --","more"

data "G  ,Sol ,7",17
data "Gs,Sol#,8",18
data "A  ,La ,9",19
data "As,A#,10",20
data "B ,Ti  ,11",21
data "",0
data "",0
data "",0

Label s4
data " 1 and 2",1
data " 2 and 3",2
data " 3 and 4",3
data " 4 and 5",4
data " 5 and 6",5
data " 6 and 7",6
data " 7 and 8",7
data " 8 and 9",8

Label s5
data "Whole 2",2048
data "Whole 1",1024
data "Half",512
data "Quarter",256
data "Octave",128
data " 16 th.",64
data " 32 th.",32
data " 64 th.",16

Label s6
data "Seq. Up 1",1
data "Seq. Up 2",2
data "Up/Down 1",3
data "Up/Down 2",4
data "",0
data "",0
data "",0
data "",0

Label s7
data "&#8226;",2
data "&#8226;&#8226;",8
data "&#8226;&#8226;&#8226;",13
data "&#8226;&#8226;&#8226;&#8226;",23
data "&#8226;&#8226;&#8226;&#8226;&#8226;",33
data "&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;",43
data "&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;",53
data "&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;&#8226;",63

Label s8
data "STOP NOW",1
data "Play  Once",2
data "Play Cont.",3
data "Improvise",4
data "QUIT/EXIT","exit"
data "",0
data "",0
data "",0

Label s2t5
data "Maj.Pentatonic (C/F/Fs/G)"
data "22323"
data "Min.Pentatonic (D/Ds/E/A)"
data "32232"
data "Egyptian (D/G/Gs/A)"
data "23232"
data "Dominant Pentatonic (G)"
data "22332"
data "B Pentatonic (B)"
data "12324"
data "Balinese 1 (E)"
data "12414"
data "Pelog/Balinese 2 (E) "
data "12432"
data "-- MORE --"
data "more"

data "Hirajoshi (A)"
data "21414"
data "Iwato (B)"
data "14142"
data "Japanese(C)/Kumoi(E)"
data "14214"
data "Jap.in Sen (E)"
data "14232"
data "Mixolydian Pentatonic (G)"
data "41232"
data "Raga Zilat (C)"
data "41214"
data "Raga Valaji/Boogie (G/C/F)"
data "43212"
data "Raga Neroshta (C/F)"
data "22521"

Label s2t6
data "Whole Tone (F/G/A/B)"
data "222222"
data "Augmented (E/F)"
data "313131"
data "Blues 2 (A/B)"
data "321132"
data "Hawaiian (C/F)"
data "214221"
data "Minor Hexatonic (D/A)"
data "212232"
data "Ritsu (E/B)"
data "122322"
data "Raga Manavi (D)"
data "214212"
data "AF. Inventio 65 (D/A)"
data "212115"

Label s2t7
data "Major/Ionian (C)"
data "2212221"
data "Dorian/GM I (D)"
data "2122212"
data "Phrigian/GM III (E)"
data "1222122"
data "Lydian/GM V (F)"
data "2221221"
data "Mixolydian/GM VII (G)"
data "2212212"
data "Nat.Minor/Aeolian (A)"
data "2122122"
data "Locrian (B)"
data "1221222"
data "-- MORE --"
data "more"

data "Min.Melodic (A)"
data "2122221"
data "Min.Harmonic (A)"
data "2122131"
data "Maj.Neapolitan (D)"
data "1222221"
data "Min.Neapolitan (E/A)"
data "1222131"
data "Maj.Hungarian (F)"
data "3121212"
data "Min.Hungarian (A)"
data "2131131"
data "Hungarian Gypsy (A)"
data "2131122"
data "-- MORE --"
data "more"

data "Enigmatic (B)"
data "1322211"
data "Harmonic Domin. (E/A)"
data "1312122"
data "Altered (B)"
data "1212222"
data "Blues 1 (D/E/A)"
data "3111132"
data "Double Harmonic (C)"
data "1312131"
data "Overtone (F/G)"
data "2221212"
data "Lead.Whole Tone (C/F)"
data "2222211"
data "-- MORE --"
data "more"

data "Hindu (G)"
data "2212122"
data "Mohamedane (D/A)"
data "2122311"
data "Javanese  (D/E)"
data "1222212"
data "Persian (B)"
data "1311231"
data "Byzantine (C/G)"
data "1312311"
data "Arabian (G/B)"
data "2211222"
data "Gypsy (F/B)"
data "1312131"
data "Spanish(C)-Jewish(E)"
data "1312122"

Label s2t8
data "Diminished (A/B)"
data "21212121"
data "Maj.Bebop (C)"
data "22121121"
data "Min.Bebop (D/G)"
data "21112212"
data "Dom.Bebop (C)"
data "22122111"
data "Spanish 8T (B)"
data "12111222"
data "Blues 8T (D)"
data "21211212"
data "Prokofiev (B)"
data "12212211"
data "Shostakovich (F)"
data "12121221"

end
'
