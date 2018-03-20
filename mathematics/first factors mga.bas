

'First Factors MGA.BAS 10/19/14 
'modified 10/24/14 with screen displays improvement a neat general code tip!
'                     for email to SmallBASIC crew
'I was challenged/inspired by the featured Primes.BAS code in SmallBASIC forum 10/18/14
'First Factors works from a different angle producing an array that is actually useful 
'for finding more than just prime numbers. Use it to factor any number up to...
'topN, I left it at 1223 because that is the 200th prime found with Primes.BAS
'on my machine and system I get .002+ or .004+ secs for 200 primes but .02+ something with Primes.BAS
'of course I've gone up to 100,000 for TopN with .2+ secs results
'The algorithm is based on Sieve of Eratostheses, 
'old as Greek Geometry with some prime number study added.
'Ha! looking up how to spell Sieve of Eratostheses I learn of Euler's Sieve (Wiki)
'n+1... there is always more that one can do, if one can do something!
'THANK YOU SmallBASIC crew and the Open Code Spirit - MGA
'
' This program code is a great first tool for Number Theory Study
' I think it's pretty good for teaching SmallBASIC as well
'
option base 1
'===================== topN =1223 for first 200 primes
'===================== topN =1000000 2.5+secs to load, 3.7+ to load and count
topN=1223
testlimitN=sqr(topN)
dim ffA(topN+6)

'In first FOR loop:
'you could go nuts performance wise and build patterns with 30 or 210 which are prime factorials
'here is just 6=2*3 which is an improvement on just 2 odds and evens. 
'Prime factorials: 30=2*3*5 and 210=2*3*5*7... these create ever expanding and overlapping patterns
tock=ticks
for i = 0 to topN step 6
  ffA(i+1)=1:ffA(i+2)=2:ffA(i+3)=3:ffA(i+4)=2:ffA(i+5)=1:ffA(i+6)=2
next
ffa(2)=1:ffa(3)=1 'fix first two primes
for pcand=5 to testlimitN step 2 
  if ffA(pcand)=1 then
    for i=pcand+pcand to topN step pcand
      if ffA(i)=1 then ffA(i)=pcand : i=i+pcand 'booster shot .02 secs on 100,000
    next
  fi
next 
tic=ticks
?
print topN; " First Factors Array Complete in ";(tic-tock)/tickspersec;" secs."
?
pcount=0
for i =2 to topN
  if ffA(i)=1 then pcount =pcount +1
next
tic =ticks
print "In first ";topN;" numbers there are ";pcount;" Primes."
?
print "   In case a prime is not a prime until it is counted as one:"
? "It took "; (tic-tock)/tickspersec;  " secs to load First Factor Array and count it's Primes."
?
Print" press any "
?
pause

'the following demo's a neat way to display tons of screens of data or file
'and stop it where you want, great general programming tip!
cls
for i=2 to topN 
  if ffa(i)=1 then
    print i,
    count=count +1
    if frac(count/10)=0 then print
    if frac(count/200)=0 then
      ?:Input " ** enter s to stop display, just enter to continue **";s
      if ucase(s)="S" then exit
      cls
    fi  
  fi
next

' now let's use our array for something useful besides prime numbers
label FactorNumber
  ? 
  ? "Enter a number up to "+TopN+" to factor ( <2 to quit ) ";
  input xn
  if xn >= 2 and xn <=topN then
    ? xn; " factors are: ",
    while ffA(xn)<>1
      print ffa(xn),
      xn=xn/ffa(xn)
    wend
    print xn
    ?
  else
    'I have learned with SmallBASIC we need to say when we are done
    'because in SmallBASIC we can go back and look inside our code while
    'the program is running, its nice feature but can mess you up if you 
    'forget the program is still running 
    ?:? "That's all Folks!"
    END
  fi
goto FactorNumber

' now use this code to do your own number studies

