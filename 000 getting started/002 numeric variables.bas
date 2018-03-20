
'002 Numeric variables.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-06-08

? "!!!  Right click mouse or tap 3 vertical bars (Android)"
? "!!!  to access the popup menu that gives access to vital"
? "!!!  functions. Call this GET POPUP."
?
? "GET POPUP now and select View Source to see this code!"
?
? "Numeric variables:"
?
? "Variables are containers. The variable/container has a" 
? "name and the variable's value is the contents found under"
? "the name. They are called variables because the contents,"
? "the values, are or can be switched."
?
? "With SmallBASIC the name must start with a letter or _ "
? "and may be followed by more letters, _ or digits."
?
? "In SmallBASIC letters are not case sensitive so:"
? "MyVariable = myvariable = MYVARIABLE = MYvariable"
? "just spell them the same (no spaces)."
? 
? "... press any to continue" : pause : cls

' Here are Two typical variable assignments, 
' loading a value into a named variable
a = 5.05 '<== you can assign a number directly

' or you can assign values from numeric expressions
b_1 = 2 * 2 * a / 1.01 '<== should be 20 

? "Here are two typical variable assignments just made:
?
? "Name:", "Value:",, "Name:", "Value:"
? "a    ", A,, "b_1    ", B_1
?
? "Here is look at arithmatic operators +, -," 
? "* multiplication, / division."
? "a + b_1 = ";A + b_1;"      a - b_1 = ";A - B_1
? "a * b_1 = ";a * b_1;"        a / b_1 = ";a / b_1
? 
? "For Powers use ^:"
? "a squared is a ^ 2 = ";a^2
? "b_1 cubed is b_1 ^ 3 = ";b_1^3
? "The square root of a number n is n ^ .5 or n ^ (1/2)"
? "The cubed root of a number n is n ^ (1/3)"
? "So square root of a is a ^ .5 = ";a ^ .5
? "and cube root of b_1 is b_1 ^ (1/3) = ";b_1 ^ (1/3)
?
? "Integer division uses \ the slash that goes the other way."
? "With Integer division the fractional part is just dropped."
? "7 / 2 = ";7/2;"    but 7 \ 2 = "; 7 \ 2
? "7 / 8 = ";7/8;"  but 7 \ 8 = "; 7 \ 8
?
? "Modulus returns the remainder, 5/3 has a remainder = 2"
? "so 5 MOD 3 = 2 (or 5 % 3 = 2)."
? "MOD or %  work with integers (no decimal in number)."
? "2 hours past 12 o'clock is 2 o'clock but what is"
? "49 hours past 12 o'clock ?"
? "It is 49 mod 12 or "; 49 mod 12;" o clock"
? 
? "... press any to continue" : pause : cls

'123456789012345678901234567890123456789012345678901234567890
? "Now that we have some variables and numeric operators,"
? "Let's try input of a radius and calculation of a circle's"
? "Area = pi * radius ^ 2
?
? "pi is a built in constant in SmallBASIC = ";pi
?
? "Next we will see INPUT keyword assigning the variable 
? "radius with a number you enter after a prompt enclosed"
? "with double quotes:"
? 
' The INPUT statement structure or syntax: 
' INPUT "prompt"; inputVARIABLE
'          the  V's are pointing to parts
' V key word    V "prompt"  semi-colon V Variable
input "So please enter a radius now > "; radius
? "We have assigned the value ";radius;" to radius,"
? "using an INPUT statement, a second way to assign"
? "values to variables. Normally we would check INPUT"
? "values but we haven't discussed IF THEN structure."
?
area = pi * radius ^ 2
? "A circle with radius ";radius;" has an area of ";area

? 
? "... press any to continue" : pause : cls

? "OK now is a good time to discuss the order operators"
? "are handled, since it does not go from left to right."
? "The main thing to remember is that + and - are done"
? "last, next to last are * and / (mult. and divide) so:
? "7 - 3 * 5 won't be 4 * 5 == 20 but 7 - 15 == -8."
? "    (I will start using == to mean equals)" 
? "When in doubt use () as the operations inside are"
? "handled first: (7 - 3) * 5 == 4 * 5 == 20
?
? "Remember the quadratic equation?
? 
? "Here is a case where getting the math order correct"
? "is vital specially when expressing the two x values"
? "possible directly from the A, B, C constants for the"
? "equations:"
?
? "For x^2 + 2*x - 3 = 0 
? "if  A = 1, B = 2, C = -3"
? "then x = (-B + ( B^2 - 4*A*C)^.5 )/(2*A)"
? " and x = (-B - ( B^2 - 4*A*C)^.5 )/(2*A)"
rem  do that in code:
rem Next line is 3 variable assignments on one line, 
A = 1 : B = 2 : C = -3 
' a colon : separates statements in Basic
? "x = ";(-B + (B^2 - 4*A*C)^.5)/(2*A);
? " and x = ";(-B - (B^2 - 4*A*C)^.5)/(2*A)
?
? "and for x^2 - 99.1*x - 202.2 = 0 
? "let A = 1, B = -99.1, C = -202.2
A = 1 : B = -99.1 : C = -202.2 
? "x = ";(-B + (B^2 - 4*A*C)^.5)/(2*A);
?" and x = ";(-B - (B^2 - 4*A*C)^.5)/(2*A)
?
? "BASIC makes formula or equation handling easy!"
?
pause
