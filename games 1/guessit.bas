
REM const variables
const Lowest = 1
const Highest = 99

REM main loop of program
CanExit = false
while (CanExit = false)
    cls
    randomize timer
    Randomed = int(Highest * rnd) + Lowest        : REM number to guess
    Rounds = 0
    print " # Guess the number im thinking?"
    print " # E.K.Virtanen 2007, public domain."
    print " # www.ascii-world.com"
    print ""
    print "Ok, i think random number between "; Lowest; " to "; Highest + Lowest; "."
    print "Your job is to guess what it is in as minimal tries as possible."
    print ""
    print "After your every guess, ill give you hint is my number higher or lower than your guess."
    print "You can exit by 'guessing' 0."
    print "Press any key to start game.";
    pause

    REM loop of game
    Rounds = 0
    ExitGame = false
    cls
    repeat
        Rounds = (Rounds + 1)
        print ""
        print ""
        print "This is round number: "; Rounds; "."
        input "Give your guess: "; PlrGuess

        REM now we check the user input
        REM if player wants to quit we change falses to trues
        if PlrGuess = 0 then
            CanExit = true
            exit
        end if

        REM if it's higher...
        if PlrGuess > Randomed THEN
            Print "My number is smaller..."
        end if

        REM if it's lower
        if PlrGuess < Randomed THEN
            Print "My number is higher..."
        end if

        REM and finally, if it was correct guess we end loop
        if PlrGuess = Randomed then
            ExitGame = true
        end if
    until(ExitGame = true)

    REM if only correct answer and no full exit we print out result of rounds.
    if CanExit = false then
            print "You got it!!!"
            print "It took "; Rounds; " rounds to guess right number."
            print ""
            input "Press 'y' to play again. Any other key to quit."; YesNo$
            if upper(YesNo$) <> "Y" then
                CanExit = true
            end if
    end if

wend
print "Thank you for playing."
