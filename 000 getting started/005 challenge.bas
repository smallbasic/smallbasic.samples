
' 005 Challenge.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-06-10

Title = "Challenge:" + CHR(13) + CHR(10)
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
?
? "Play this game and then try and code it."
?
? "Challenge part 2:
? "After playing this game then coding and testing it,"
? "you have probably discovered a systematic way to"
? "play it, such that you must find the number within"
? "a certain amount of moves."
?
? "What is the maximum amount of guesses it would" 
? "take to find any number? Write the code to handle"
? "the 'guessing' part in finding the number and say"
? "hello to AI!"
? 
wait 

WHILE 1
  x = RND * 100 \ 1 + 1 'remember \ rounds down to integer
                        'so range is 0 - 99 before adding 1
  guessCOUNT = 0 
  WHILE guess != x 
    INPUT "(0 quits) Guess my number from 1 to 100 > "; guess
    IF guess THEN
      guessCOUNT = guessCOUNT + 1
      IF guess < x THEN 
        ? "Too low"
      ELIF guess > x 
        ? "Too high"
      ELSE
        ? "You guessed in ";guessCount;" guesses."
        ?
      END IF
    ELSE
      end
    END IF
  WEND
WEND
