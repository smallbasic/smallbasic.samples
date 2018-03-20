rem   Capitol pal test.bas, in SmallBASIC, B+ , Bpf 2015-02-28
input "enter palindrome test text: ",t
c = ucase(t) : b = "" : p = "" 
for i= 1 to len(t)
  if asc(mid(c,i,1))>64 and asc(mid(c,i,1))<91 then b=b+mid(c,i,1):p=mid(c,i,1)+p 
next 
if b=p then print "'";t;"' is palindrome." else print "'";t;"' is not palindrome." 