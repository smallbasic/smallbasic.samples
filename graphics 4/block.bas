' OPAZ Classic Sliding Blocks.bas  SmallBASIC 0.12.8 [B+=MGA] 2016-12-28
? "     Sliding Blocks Puzzle" : ? : ? "Select Board size from 3 up to 9 ";
while s < 3 or s > 9 : input "";sz : s = int(val(sz)) : wend : dim board(s, s)
for r = 1 to s : for c = 1 to s : board(c, r) = c + (r - 1) * s : next : next
board(s, s) = 0 : c0 = s : r0 = s
for i = 0 to 50 * s * s : handle mid("opaz", int(rnd * 4) + 1, 1) : next
cls : locate s + 2, 1 : ? " press:   o =left   p =right   a =up   z =down"
while 1
    locate 1, 0 : b = space(20) : solved = 1
    for r = 1 to s : for c = 1 to s
        if board(c, r) then
            if board(c, r) <> c + (r - 1) * s then solved = 0 'not solved
            b = b + right("   " + board(c, r), 3) + " "
        else : b = b + "    " : end if
    next : ? b : b = space(20) : next : ?
    if solved then locate s + 4, 20 : ? "Solved!" : delay 5000 : end
    k = inkey : if k = "Q" then cls : end else handle k
wend
sub handle(d)
    select case d
    case "o" : if c0 < s then board(c0,r0)=board(c0+1,r0) : board(c0+1,r0)=0 : c0=c0+1
    case "p" : if c0 > 1 then board(c0,r0)=board(c0-1,r0) : board(c0-1,r0)=0 : c0=c0-1
    case "a" : if r0 < s then board(c0,r0)=board(c0,r0+1) : board(c0,r0+1)=0 : r0=r0+1
    case "z" : if r0 > 1 then board(c0,r0)=board(c0,r0-1) : board(c0,r0-1)=0 : r0=r0-1
    end select
end sub