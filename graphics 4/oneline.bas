'one liner graphic.bas for SmallBASIC 0.12.6 [B+=MGA] 2016-07-31
'for x in seq(0,512^2,512^2) do pset x mod 512,x\512,rgb((x mod 512)mod 256,((x mod 512) xor (x\512))mod 256,(x\512)mod 128)

'More blue version:
for x in seq(0,512^2,512^2) do pset x mod 512,x\512,rgb((x mod 512)mod 256,((x mod 512) xor (x\512))mod 256,(x\512)mod 256)
showpage
pause