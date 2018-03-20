
'    rem SCRAMBLE
    rem a program to scramble a word
    rem Cyril G. Kurtz
    rem ckurtz11@ home.net
    rem ima286@netscape.net

    a = space(12)
    print chr$(27) + "[93m";

10  rem get a new string, check the length, and save it
    print "Word or string to scramble"
    print "(3 to 12 characters) ";:input a
    x = len(a)
    if x > 12 then 10
    if x < 3 then 10

    randomize timer

20  rem scramble (again)
    print:print a
    b = a
    c = a
    count = 1

30  rem generate a random number between 1 and x
    rem and check to see if that letter is available
    p = int(rnd*x + 1)
    z = mid$(b, p, 1)
    if z = "." then 30:rem letter is taken

40  rem place period claiming letter
    if p = 1 then b = "." + right$(b,x - 1):goto 50
    if p = x then b = left$(b,x - 1) + ".":goto 50
    b = left$(b,p-1) + "." + right$(b,x - p)

50  rem place letter in c
    if count = 1 then c = z + right$(c,x - 1):goto 70
    if count = x then c = left$(c,x - 1) + z:goto 70
    c = left$(c,count - 1) + z + right$(c,x - count)

70  count = count + 1
    if count > x then 100
    goto 30

100 print "..........":print c

110 rem does the user want to scramble again
    print:print "again(y/n) ";:input z
    if z = "Y" or z = "y" then 20
    if z = "N" or z = "n" then 120
    goto 130

120 rem does the user want to input a new string
    print:print:print "another word(y/n) ";:input z
    if z = "Y" or z = "y" then 10

130 print:print:print "Thank you for using ''scramble''."
    print "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

    end
'
