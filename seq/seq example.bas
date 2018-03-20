
'SEQ example.bas for SmallBASIC 0.12.6 [B+=MGA] 2016-07-31

? "Numbers from 1 to 10 using seq:"
for i in seq(1,10,10) do ? i;", ";
?:?

? "Numbers from 1 to 10 in increments of .5
for i in seq(1,10,19) do ? i;", ";
?:? "notice there are 9 numbers between the integers"
?
s = "test string"
dim chars(1 to len(s)) 'note: will get 0 for first char if 0 based array
for i in seq(1, len(s), len(s)) do chars(i) = mid(s,i,1)
for i in chars do ? i;
?
pause
