func CapFilt(xS)
  'isolate punctuation so when we look for key words they don't interfere
  local b, i
  b=" "
  if len(xS)
     for i= 1 to len(xS) 
        if asc(mid(xS,i,1))>64 and asc(mid(xS,i,1))<91 then
           b=b+mid(xS,i,1)        
        fi
     next
  fi
  CapFilt=ltrim(b)
end

rem   Punc palindrome test.bas, in SmallBASIC, B+
input "enter palindrome test text: ",t
test=CapFilt(ucase(t))
print "'";test;"'"
mirror=" "
for i=1 to (len(test))
  mirror=mid(test,i,1)+mirror 
next i
mirror=rtrim(mirror)
print "'";mirror;"'"
if mirror=test then print t;" is palindrome." else print t;" is not palindrome."