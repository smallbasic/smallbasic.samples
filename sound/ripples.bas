
'ripples.bas-run on palm only, will crash windows 98
' 21/08/2006
cls
pen on
while inkey$<>"."
randomize
circle pen(1), pen(2), fix(rnd*60)
sound (pen(1)*7), (pen(2)*0.5)
circle pen(1), pen(2), fix(rnd*60) color 15
sound (pen(1)*7), (pen(2)*0.5)
wend
pen off

end
