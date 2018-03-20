
'''agendus.bas
''Sep/15/2004
''Version 1.0
''By Adolfo Leon Sepulveda
''Sort a file in palm memo pad or a file by input data using bubble sort
''This program use tap method for menu selection
menu
end

sub menu()
local x,y
x=0
y=0
DataFile= "memo:data"
While true
   cls
   locate 1,10:print "Agendus"
 
   locate 2,1 : print "1. Input data"
   locate 3,1 : print "2. Display data"
   locate 4,1 : print "3. Sort data"
   locate 5,1 : print "4. Quit"
   locate 6,1 : print "do tap on option"
   WaitTap x, y
	
   If y>10 and y<20 and x >1 and x<150 then
  	InputData DataFile
   elseif y>21 and y<30 and x >1 and x<150 Then
   	DisplayData DataFile
   elseif y>31 and y<40 and x >1 and x<150 Then
   	BubbleSort DataFile
   elseif y>41 and y<50 and x >1 and x<150 Then
   	Exit loop
   else
    locate 9,1: print "do tap on option"
    pause 1
    locate 9,1: print spc(32)
   endif
wend
end

sub InputData(NameFile)
local f
local pho, na

f=freefile
if exist(NameFile) then
  repeat
    Cls
    locate 1,10:print "Input data"
    locate 2,1:print "1. Append data"
    locate 3,1:print "2. Create a new File"
    locate 4,1:print "3. Return"
    locate 5,1:print "do tap on option"
    WaitTap x,y
    If y>10 && y<20 && x >1 && x<150 Then
      Open NameFile FOR APPEND AS #f
    ElseIf y>21 && y<30 && x >1 && x<150 Then
   	  Open NameFile FOR OUTPUT AS #f
      CHMOD NameFile, 0o777
    ElseIf y>31 && y<40 && x >1 && x<150 Then
      exit Sub
    Else
      locate 6,1: print "do tap on option"
      pause 1
      locate 6,1: print spc(32)
    endif
  until false
else
  OPEN NameFile FOR output AS #f
  CHMOD NameFile, 0o777
endif

while true
  input "Name: (Press Enter to quit)"; na

  if empty(na) then
    close #f
    exit loop
  endif
  input "Phone: "; pho
 
  pho = padl(pho,15," ")  ''add spaces for left
  print#1; na,pho
wend

end


sub DisplayData(NameFile)
local f
f=freefile

OPEN NameFile for input AS #f
CHMOD NameFile, Oo777

while !eof(f)
  input#f; na,pho
  print na,pho
wend
close #1
print "do tap on screen"
WaitTap x,y
end


sub BubbleSort(NameFile)
local name(),phone(),na,pho,i,j
local f

f=freefile
OPEN NameFile for input AS #f
CHMOD NameFile, Oo777
i=0
while !eof(f)
  input#f; na,pho
  append name,na  '' dinamic add to array
  append phone,pho
  i=i+1
wend

NumRecs = i
''sort array
for i = 0 to NumRecs-2
   for j = i+1 to  NumRecs-1
     if name(i) > name(j) then
	     tmp = name(j)
	     name(j) = name(i)
	     name(i) = tmp
     endif
   next j
next i

close#f
''rewrite data on palm memo pad
fo=freefile
OPEN NameFile for output AS #fo
CHMOD NameFile, Oo777
for j = 0 to NumRecs-1
  print#fo; name(j),phone(j)
next j
close#fo
print "file sorted! "
print "use option 2 for view data"
print "or go to palm memo pad in data"
print "do tap onscreen"
WaitTap x,y
end


func padl(s,ancho,car)
local length,tmp
s = trim(s)
length = len(s)
for i=1 to ancho-length
  s = car+s
next i
padl=s
end

sub WaitTap(byref x, byref y)
  pen on
  repeat
  until pen(0) <> 0
  x=pen(4)
  y=pen(5)
  pen off
end

'
