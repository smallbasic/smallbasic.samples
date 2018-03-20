
' 006 Arrays+.bas  SmallBASIC 0.12.6 [B+=MGA] 2016-06-11

? "!!!  Right click mouse or tap 3 vertical bars (Android)"
? "!!!  to access the popup menu that gives access to vital"
? "!!!  functions. Call this GET POPUP."
?
? "You can GET POPUP now and select View Source"
? "to see the code for this, specially if you are viewing"
? "On-line samples for which the editor is not available."
?
? " press any to continue..." : PAUSE : CLS

'Here is a list of keywords we have gone over
DATA "print", "input", "while", "wend", "exit"
DATA "cls", "rnd", "mod", "for", "next", "pause"
DATA "if", "then", "elif", "else", "end"

'I've written these in DATA statements because we will
'load then into an array called keyWORDS. First let's
'tell SmallBASIC keyWORDS will be an array.

DIM  keyWORDS()
'we could count the 15 words and tell SmallBASIC
'to get ready for 15 words with
'DIM keyWORDS(15) but what if we add to our list?
'Notice "end" is our last word in the list,
'we will use that to signal the end of our list

'coming upon WHILE, Word is nothing yet so we can enter
'the WHILE loop
WHILE Word != "end" 
  'if you have DATA statement, you need READ to access
  'them in code to do something with them through a 
  'varaible, we will use Word
  READ Word
  'read will start at first DATA item and through the
  'WHILE loop keep READing DATA into Word until it 
  'encounters "end" or runs out of DATA 
  'RESTORE is used to reset the READ start point
  
  'So what are we to do with Word before we get another?
  'append it to our keyWORDS array, using symbol <<
  keyWORDS << Word
WEND

'OK how are we doing so far?
? "Here is a list of Key Words covered so far:" ' title
?
'Here is a way to see the contents of an array
FOR item IN keyWORDS
  ? item
NEXT
' !!!!!!!!!!!!! HEY a new way to loop !!!
?:? " press any to see this list sorted
PAUSE 'to see what we have
CLS
' yep! 15 words loaded in the same order as in the data

'let's sort them
? "Here is our Key Words list sorted:" : ?
SORT keyWORDS
'OK. look again
FOR item IN keyWORDS
  ? item
NEXT
?:? " press any to see all the e items removed from this list."
PAUSE
CLS

'now we will need to index the items to DELETE them from array
'LBOUND(array) and UBOUND(array) will give us the lower and upper
' index for our keyWORDS array.

'also we will need the string function LEFT(string, amount_from_left)
'to give us a reading on what letter is left most in our word

'OK, ever time we delete an item from the array,
'we have to start over looking for e's 
'because the indexes will be messed up
'and UBOUND will shrink

checkAGAIN = 1 'flag to look for e word, 
'every time we find an e word reset checkAGAIN to true 
WHILE checkAGAIN
  checkAGAIN = 0 'assume we have all e words 
  FOR index = LBOUND(keyWORDS) to UBOUND(keyWORDS)
    IF LEFT(keyWORDS(index), 1) = "e" THEN
      ? "Goodbye ";keyWORDS(index)
      DELETE keyWORDS, index
      checkAGAIN = 1
      EXIT FOR 'get out of town because we just messed up indexes
    END IF
  NEXT 
WEND

'OK let's see if we got all the e words in keyWORDS
FOR item IN keyWORDS
  ? item
NEXT
?:? " press any to see all the new words we learned today."
PAUSE
CLS

REDIM keyWORDS() 'will clear keyWORDS for new stuff

DATA "DIM", "<<", "IN", "SORT", "LBOUND", "UBOUND", "REDIM"
DATA "DELETE", "READ", "DATA", "RESTORE","LEFT"
WHILE Word != "LEFT"
  READ Word
  keyWORDS << Word
WEND

'OK let's see if we got all the NEW words added to keyWORDS
? "New Key Words we went over here in Arrays+.bas." : ?
FOR item IN keyWORDS
  ? item
NEXT
?:? " WOW! press any to end lesson."
pause
