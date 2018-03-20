
' Man race.bas  SmallBASIC 0.12.2 [B+=MGA] 2016-03-27
'Copied and heavily modified Walking man by Johnno SB post 2016-03-27

randomize
dim mx(6),my(6),mr(6)
for i=1 to 6
  mx(i)=0
  my(i)=120*(i-1)
  mr(i)=rnd/10+4
next
for a = 1 to 8
open "assets/" + str(a) + ".png" as #a
next a
a = 1:winner="":endrace=0
while 1
  cls
  for man=1 to 6
    select case man
    case 1
      m1=image(#a)
      m1.show(mx(man),my(man))
    case 2
      m2=image(#a)
      m2.show(mx(man),my(man))
    case 3
      m3=image(#a)
      m3.show(mx(man),my(man))
    case 4
      m4=image(#a)
      m4.show(mx(man),my(man))
    case 5
      m5=image(#a)
      m5.show(mx(man),my(man))
    case 6
      m6=image(#a)
      m6.show(mx(man),my(man))
    end select
    if mx(man)>=xmax then winner=winner+str(man)+" ":endrace=1
    rndluck=iff((rnd<.5),((rnd*-10)\1),((rnd*10)\1))
    mx(man)=mx(man)+mr(man)+rndluck
  next
  if endrace then exit
  delay 75
  if inkey = chr$(27) then exit
  a+=1
  if a=9 then a=1
wend
for a = 1 to 8
close #a
next
? "And the winner(s) are: ";winner
for i=1 to 6
  at 0,my(i)+60 : ?"#";i;" @";mr(i);" pixels (+/- rnd*10) per round"
next
at 0,my(6)+100:? "press any to end..."
pause
