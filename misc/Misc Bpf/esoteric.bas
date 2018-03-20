'copied from Bpf 2015-04-10 TheMeq (spike_132000)
'adapted to SmallBasic (not MS) 2015-04-09 B+ 11.22PM
dim i(1000): p=1 : k=1                 'K=1 not 0 to start modified
open "Hi.txt" for input as #1    'modified
lineinput #1, a$                     'modified
close #1                             'added seems important
label top
if k>len(a$) then ? "k exceeded length of string." : goto endexec
'? len(a$),k
thechar$ = mid$(a$,k,1)
if thechar$ = "+" then i(p)=i(p)+1
if thechar$ = "-" then i(p)=i(p)-1
if thechar$ = "=" then i(p)=i(p)+10
if thechar$ = "_" then i(p)=i(p)-10
if thechar$ = "." then i(p)=i(p)+50
if thechar$ = "," then i(p)=i(p)-50
if thechar$ = ":" then i(p)=i(p)+100
if thechar$ = ";" then i(p)=i(p)-100
if thechar$ = ">" then p=p+1
if thechar$ = "<" then p=p-1
if thechar$ = "r" then p=1
if thechar$ = "p" then print chr$(i(p));
if thechar$ = "q" then p1=i(p)
if thechar$ = "w" then p2=i(p)
if thechar$ = "a" then i(p) = (p1+p2)
if thechar$ = "s" then i(p) = (p1-p2)
if thechar$ = "d" then i(p) = (p1*p2)
if thechar$ = "f" then 
   if p2=0 then 'here's where program goes wrong !!!!!!!!!
      'do nothing?????? seems to work,            div by 0
   else
      i(p) = (p1/p2)
   fi
fi
if thechar$ = "z" then p1=p2
if thechar$ = "x" then p2=p1
if thechar$ = "f" then print i(p);
if thechar$ = "!" then goto endexec
if thechar$ = "[" then
   startloop=k:looping=1:numloops=i(p-1):curloop=0
endif
if thechar$ = "]" then
   if curloop < numloops then
      curloop = curloop + 1 : k = startloop
   else
      looping=0:startloop=0:numloops=0:curloop=0
   fi
fi
if thechar$ = "@" then gosub about
k=k+1
goto top
label about
? "Hello from B+"
return
label endexec
?
'for k=1 to 64
'   ? i(k);" ";
'next i
?:?:input "Finished Executing. Press Enter to Exit",ix