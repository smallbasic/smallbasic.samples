
'#!/usr/local/bin/sbasic -q

## Generate permutations of a word
## Chris Warren-Smith 21/11/2004

dim pword
dim plist

sub perm(s, pos, slen)
    local i, tail, c

    if (slen = 1)
        # end of word scan
        pword = replace(pword, pos, s, 1)
        plist << pword
        exit sub
    fi

    for i = 1 to slen
        # replace the next character at pos with
        # the leftmost character in s
        c = mid(s, 1, 1)
        pword = replace(pword, pos, c, 1)

        # find the permutations of the string tail
        tail = mid(s, 2)
        perm tail, pos+1, slen-1

        # rotate the source string
        s = tail + c
    next i
end 

cls
input "Enter a word:", pword
perm pword, 1, len(pword)
tsave "words.txt", plist


'
