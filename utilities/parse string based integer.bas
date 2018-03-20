
func parseInt(s, b)
  local result = 0
  local num = len(s)
  local value, ch, j
  j = 0
  for i = num to 1 step -1
    ch = mid(s, i, 1)
    if ch >= "a" then
      value = 10 + (asc(ch) - asc("a"))
    else
      value = int(ch)
    fi
    result += pow(b, j) * value
    j++
  next i
  parseInt = result 
end
 
? "result = " + parseInt("999", 10)
? "result = " + parseInt("f3", 16)
? "result = " + parseInt("1bp49b", 36)

