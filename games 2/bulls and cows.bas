
'bulls and cows.bas for SmallBASIC 0.12.0 [B+=MGA] 2016-02-18 translated from:
'2016-02-18 repair secret number maker
'bulls and cows from johnno.sdlbas copied 2016-02-15 [B+=MGA] when it was 
'requested no duplicate numbers. OK, try that by treating digits like deck of cards shuffle and draw 4
'
'    Converted from BBC Basic (Johnno to SdlBasic)
'
' http://www.rosettacode.org/wiki/Bulls_and_cows#BASIC
'
'===================================================== setup
randomize(timer)
'while 1     'test output of shuffle
deck="123456789"
r=int(rnd*9)+1
secret=mid(deck,r,1)
if r < 9 then
  deck=mid(deck,1,r-1)+mid(deck,r+1)+"0"
else
  deck=mid(deck,1,r-1)+"0"
end if
for i=1 to 3
  r=int(rnd*len(deck))+1
  secret=secret+mid(deck,r,1)
  if r < len(deck) then
    deck=mid(deck,1,r-1)+mid(deck,r+1)
  else
    deck=mid(deck,1,r-1)
  end if
next 
'? secret                       'test and debug
'input "press enter... ";t      'test
'wend                           'test
'====================================================== game
? "Guess a four-digit number (no repeating digits)."
guesses=0
while 1
  repeat
    OK=0
    input "(just enter quits) Enter your guess: ";guess
    guess = str(guess)
    if guess="" then ? "Goodbye":end
    if len(guess) <> 4 then
      ? "Must be a four-digit number":?
    else
      OK=1 'galileo had a check to see if a duplicate number was in the guess
      for i=1 to 3
        for j=i+1 to 4
          if mid(guess,i,1)=mid(guess,j,1) then
            ? "Digits must not repeat in guess.":?
            OK=0:exit for
          end if  
        next
        if OK=0 then exit for
      next
    end if
  until OK
  guesses +=1
  if guess=secret then
    ? "You won after "+str(guesses)+" guesses!"
    delay 3000:end
  end if
  bulls=0
  cows=0
  for i=1 to 4
    c=mid(secret,i,1)
    if mid(guess,i,1)=c then
      bulls +=1
    elif instr(guess,c)
      cows +=1
    end if
  next
  ?"You got "+str(bulls)+" bull(s) and "+str(cows)+ " cow(s).":?
wend