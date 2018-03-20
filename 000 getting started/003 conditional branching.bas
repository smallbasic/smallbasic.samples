
' 003 IF THEN ELIF ELSE END IF.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-06-09

Title = "IF... THEN... code structure:" + CHR(13) + CHR(10)
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

? "What makes programs appear smart is their ability to"
? "respond differently to various conditions."
? "For instance, looping would be made impractical without" 
? "the ability to recognize when to stop!"
? "The IF THEN structure provides this ability by evaluating"
? "an expression to True or False and taking the THEN route"
? "when True (anything not == 0) or the ELIF or ELSE or"
? "END IF routes if the expression is False == 0."
? "ELIF or ELSE are optional parts of the IF... THEN..."
? "structure offering alternate code blocks when the"
? "IF expression evaluates to False == 0."
?
? "There is a single line version of IF... THEN... that"
? "does not require an END IF because it's all on one line."
? "The ElIF option is not available for that and most PL's"
? "only use the code blocks version of IF. So the shortest" 
? "way to cover IF... THEN... is to discuss the long version." 
wait

? "The IF is followed by a Boolean expression which is one"
? "that boils down to True (Not 0 or != 0) or False (== 0)."
?
? "IF x > 10 reads as: If x is Greater Than 10." 
? "With this statement, the interpreter will substitute"
? "the value it currently holds for x say 2, and then"
? "see that 2 > 10 is false. So the THEN route will be"
? "skipped and a search for presence of an ELIF or ELSE"
? "block to check or execute. If none are present, it looks"
? "for the END IF and skips to next code line after."
?
? "But, if x contained the value 11, 11 is Greater Than 10,"
? "so the interpreter would look for code following the THEN"
? "and execute that block of code and then look for the"
? "END IF, skipping ELIF or ELSE blocks if present."
?
? "That is how code is executed differently according to"
? "conditions during processing." 
wait

? "Let's look at the simplest of IF expressions:"
? "IF x THEN    'if x <> 0 then
? "   x = x - 1 'assign the value of x-1 to x
? "END IF"
? "I read this as:  IF x is not 0 THEN 
? "                   do the next code block following THEN
? "                   x = x - 1
? "The only time 1 won't be subtracted from x is if it were 0"
?
? "BTW, here is a THEN block that will never be executed
? "IF 0 THEN
? "  PRINT \"This sentence will only be seen in a tutorial.\""
? "ELSE"
? "  PRINT \"I am a very popular ELSE block!\""
? "END IF"
? 
? "A little change:"
? "IF x >= 0 THEN  'reads IF x is Greater Than or Equal to 0"
? "   x = x - 1"   'decrease x by 1
? "END IF"
? "If this were in a loop x would be constantly reduced"
? "until it were Less Than or = 0."
wait

? "SmallBASIC has a useful function called RND that returns a"
? "random real number >= 0 and < 1.0
? "If we multiply this number by 100 we have a random real
? ">= 0 and < 100.
?
? "OK, so we will use RND to show an ELSE code block option.
? "(GET POPUP to View Source for next code block:)"
? "I flipped a coin in code and..."

''''''''''''''''''''''''''''''''''''''''''' View Source
IF RND < .5 THEN
  ? "Heads! I win!"
ELSE
  ? "Tails! You loose!"
END IF
? "As a BASIC programmer, you are in control!"


?
? "Now let's get down to sorting out where RND fell with an"
? "full ELSE and ELIF demo (GET POPUP to View Source):

'''''''''''''''''''''''''''''''''''''''''' View Source
r = RND 

'we have to store our random in a container r
'so that when we do the ELIF tests we are always
'checking against the same value

? r; " the random number just picked,"
IF r < .2 THEN
   ? " was less than .2 (and >= 0)"
ELIF r < .4 
  ? " was less than .4 but >= .2"
ELIF r < .6
  ? " was less than .6 but >= .4"
ELIF r < .8
  ? " was less than .8 but >= .6"
ELSE
  ? " was less than 1 but >= .8"
END IF


? "Behind the screen, r just ran the gauntlet of sorting"
? "with IF... THEN... ELIF... ELSE... END IF"
wait

? "Using AND | OR in Boolean expressions:"
?
? "Suppose you are working on a drawing program, it
? "doesn't make sense to draw anything outside the
? "viewing screen area so you want to check if your
? "your x coordinate will be visible on screen.
? "SmallBASIC provides System constants xmax = ";xmax
? "your drawing screen width and ymax = ";ymax
? "your drawing screen height, for you particular screen."
?
? "So if x >= 0 AND if x <= xmax then x is OK."
? "When you use AND between 2 Boolean expressions BOTH"
? "conditions have to be True for the expression as a
? "whole to be evaluated as True (and the THEN code block
? "is followed).
? "An equivalent result can be done with an OR test:"
? "IF x < 0 OR x > xmax THEN
? " 'dont draw it because x is out of the picture
?
? "The point on this page is that AND and OR can check
? "multiple conditions in a single Boolean expression"
? "that ultimately boils down to True (!=0) Or False (== 0).
? "With AND, the expressions on either side must be True
? "for AND to evaluate the whole expression as True.
? "With OR, only one expression needs to evaluate to True
? "for the whole expression to evaluate as True."
?
? "For more on this subject, check out Truth Tables."
pause
