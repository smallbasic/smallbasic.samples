
' 004 Loops.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-06-10

Title = "Loops:" + CHR(13) + CHR(10)
sub wait
  ?
  ? "...press any to continue" : pause : cls
  ? Title
end

? Title
? "!!!  Right click mouse or tap 3 vertical bars (Android)"
? "!!!  to access the popup menu that gives access to vital"
? "!!!  functions. Call this GET POPUP."
?
? "You can GET POPUP now and select View Source"
? "to see the code for this, specially if you are viewing"
? "On-line samples for which the editor is not available."
wait

? "Loops have a code block (or not) that is repeated over
? "and over again usually until an exit condition is met.
?
? "SmallBASIC has several looping structures:
? "FOR... NEXT... (one of the oldest)
? "REPEAT... UNTIL... 
? "probably the most universal is WHILE... WEND which we
? "will withdraw to in a while.
? 
? "First let us simulate a FOR... NEXT loop with line 
? "labels that will print and label 3 lines.
? 
? "To see the code that is generating the next lines
? "GET POPUP and select View Source.
?
'''''''''''''''''''''''''''''''''''''''''''' View Source
? "FOR NEXT loop simulated with Line labels and GOTO
'try it forwards
start = 1 : last = 3 : stepper = 1 : index = start
'try it backwards, remove comment next line
'start = 3 : last = 1 : stepper = -1 : index = start
'try it in steps or -5, remove comment next line
'start = 15 : last = 1 : stepper = -5 : index = start
label labelFOR 'basically the FOR line marks the loop start
   ' a For loop won't execute a line of code in block 
   ' if index is already past last
   if stepper > 0 then 'oh dang stepper could be negative!
     if index > last then goto labelNext '< exit condition
   elif stepper = 0 
     stepper = 1 'set default of 1
     if index > last then goto labelNext
   else 'stepper is negative
     if index < last then goto labelNEXT
   end if
   'code block inside FOR NEXT
   ? "This is line number ";index
   'the incrementin is sort of hidden in a FOR NEXT
   'STEP stepper allows increments of any amount
   index = index + stepper : goto labelFOR 
label labelNEXT 'basically the NEXT marks the loop end
?
? "Here is the FOR NEXT loop
'compared to sim above you can now see all the stuff 
'it does behind those simple 3 lines!
FOR index = start TO last STEP stepper
  ? "This is line number ";index 
NEXT
?
? "I am hoping seeing these two versions together in code
? "especially the variables used and placed, will help
? "each explain the other, next up is the WHILE WEND loop.
wait

? "A WHILE... WEND loop has an exit condition stated at
? "the start of the loop, when that exit condition is met
? "the code following WEND is executed.
?
? "I should mention that all loop structures, have an 
? "alternate way to exit a loop, EXIT LOOP or EXIT FOR.
?
? "Let's see if we have enough tools now to make a 
? "factoring program. Yes!
?
? "GET POPUP select View Source for code listing.
?
''''''''''''''''''''''''' view source

'prime test.bas  
'either find a factor (lowest) or report a number prime

number = 2
WHILE number >= 2
  INPUT "Enter a number to factor (if < 2, quit), number > ";number
  IF number >=2 THEN
    test = 2 : factorFOUND = 0
    WHILE test <= number ^.5  'don't need to go past square root
      IF number % test = 0 THEN 'test divides number without remainder
        factorFOUND = test : EXIT LOOP
      END IF
      IF test = 2 THEN 
        test = 3 
      ELSE 
        test = test + 2 'just check odd numbers after 2
      END IF
    WEND
    IF factorFOUND THEN
      ? number;" is divisible by ";factorFOUND
    ELSE
      ? number; " is Prime."
    END IF
  END IF
WEND

'append a demo with REPEAT... UNTIL
'and some one line IF... THEN examples
?
? "This code will fully factor a number to all it's prime factors!
?
n = 2
WHILE n >= 2
  INPUT "Enter a number to factor (if < 2, quit), number > ";n
  IF n < 2 THEN END
  REPEAT
    fd = 0 : test = 2
    WHILE test <= n ^.5
      IF n % test = 0 THEN fd = test : EXIT LOOP
      IF test = 2 THEN test = 3 ELSE test = test + 2 
    WEND
    IF fd THEN n /= fd : ? fd;" "; ELSE ? n
  UNTIL fd = 0
WEND
