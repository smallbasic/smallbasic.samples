
REM 3 ways to print hello five time.bas 2016-03-05 SmallBASIC 0.12.2 [B+=MGA]
'modified for 001 Getting Started

REM remember ? is the same as PRINT, each ? is a print statement
? "!!!  Right click mouse or tap 3 vertical bars (Android)"
? "!!!  to access the popup menu that gives access to vital"
? "!!!  functions. Call this GET POPUP."
?
? "GET POPUP now and select View Source to see the code for this!"
?
? "Three Ways to PRINT hello Five Times:"
? 
? "It's all in the punctuation at the end of a print statement."
?
? "1) no punctiation at the end of a print statement"
?
print "hello"
print "hello"
print "hello"
print "hello"
print "hello"
?
? "Each hello takes a whole line."
?:? '2 blank lines, the colon : separates statements

? "2) a comma which tabs to next avaiable tab column" 
? "   and will stay on same line until run out of columns"
?
print "hello",
print "hello",
print "hello",
print "hello",
print "hello",
? "& this will finish the hello, line."
?:? 'print two are blank lines a : colon separates statements

? "3) a semicolon (and space after hello)
?
print "hello ";
print "hello ";
print "hello ";
print "hello ";
print "hello ";
'notice I put a space after hello otherwise > hellohellohellohellohello
? "... this line needs to be finsihed."

pause 'now we do need the pause! to see the screen before returning to editor

# note for those not reading this from On-Line samples
# comment out the PAUSE above, and the output screen will flash and return here
# GET POPUP and select Show Output and you can veiw it from editor

