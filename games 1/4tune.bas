
' 11/03/2008
'randomize
open "MEMO:4tune" for input as #1
'open "PDOC:4tune" for input as #1
open "MEMO:sbout" for append as #2
while inkey$<>"."
randomize
line input #1, fortune$
if "eof" then
print "*";
play "p2"
endif
wend
print fortune$
print #2, fortune$
close #1
close #2
pause
end
'for memo pad:
'4tune
'A celebrity is a person who is known for his well-knownness.
'A chicken is an egg's way of producing more eggs.
'A clash of doctrine is not a disaster - it is an opportunity.
'A clever prophet makes sure of the event first.
'A closed mouth gathers no foot.
'A conclusion is simply the place where someone got tired of thinking.
'A couch is as good as a chair.
'A day for firm decisions!!!!!  Or is it?
'A day without orange juice is like a day without orange juice.
'A day without sunshine is like night.
'from gpl program 'fortune'
