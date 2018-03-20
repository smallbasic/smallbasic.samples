'g2 Life.bas SmallBASIC (not M$) B+ Bpf 2015-03-22 post with 123-28.png an=320 
'g1 can display cells down to pixel level post 2015-03-21 Bpf 23-23 an=650 
'g2:allow seed files from Notepad or File Input ===> load seed array see GetSeed()
'   allow any set of Rules for survival and birth ===> see getRules() + theNextGeneration()
'   fix horizontal/verticals in seed and adjust delays according to an^2 calculations

'keep things square everything depends on "an" the number of rows and columns to use: 
'arrays [an X an] board [an*s X an*s] or cells [s-1 X s-1] most screens ymax < xmax
'ymax is SmallBasic constant for screen height in pixels
'will separate cells until row height (s) drops below 3 then cell side is same
an=320: s=int(ymax/an): if s<3 then cs=s else cs=s-1: bigBlock=an*s
dim a(1 to an,1 to an), seed(1 to an), ng(1 to an,1 to an)
'set default rules to Standard "Conway Life"
surviveRule="23" : birthRule="3"

'load seed string array, if no sdRow then END================== no seed END
getSeed()
if sdRow=0 then ? "Goodbye!" : END

'load seed into main array a()
L = 0 'make L longest string length of seed
for x = 1 to sdRow
   if len(seed(x)) > L then L =  len(seed(x))
next x
'put seed in center of a()
xm = int(an/2) - sdRow/2
ym = int(an/2) - L/2
for x = 1 to sdRow
  for y = 1 to len(seed(x))
     if mid(seed(x), y, 1) = " " then 
       a(ym + y,xm + x) = 0 
     else
       a(ym + y,xm + x) = 1 
       p = p + 1
     fi
  next y
next x
'ShowA 
'pause 5

getRules()

'OK good to go with Life
g=1
while p>0
  theNextGeneration()
  'adjust to your taste the 1,000,000
  delay int(1000000/(an^2))
wend
? "Goodbye!"
end '=============================================== end

'============================================================== getRules
sub getRules()
 local inps
 cls
 ?:? "Now for the rules for deciding the next Generation:":?
 ? "Each cell has 8 nieghbors, like center of tic-tac-toe board."
 ? "note: lets not worry about corners and edges yet."
 ? "We must decide how many neighbors of 8 for an existing alive cell"
 ? "to remain in next round, type 134(enter) if 1 neighbor, 3 or 4 is"
 ? "what you want to try. If you don't type anything, will default to"
 ? "standard Conway Life survival rule '23'." :?
 input "Cell survives rule is ";inps
 if inps<>"" then
   if instr("12345678",left(inps,1)) then surviveRule=inps
 fi
 ?
 ? "Now we need to declare the rule for the birth of a new cell."
 ? "Default is '3' an empty cell needs 3 neighbor cells to cause 
 ? "a birth of an alive cell in the next generation of the board."
 ? "Type in neithbor count(s) (at least one count) 1 to 8 neighbors.":?
 input "Cell is born with neighbor count(s) of ";inps
 if inps<>"" then
    if instr("12345678",left(inps,1)) then birthRule=inps
 fi
end
'============================================================= getSeed
sub getSeed()
  'basically need to get seed() loaded for seeding array a [an X an]
  local menu, f, inps
  color 0,15:cls
  'not local seed(), sdRow
  sdRow=0
  ?
  ? "                 *** THE GAME OF LIFE FOR BPF ***" 
  ? "         version G2 Life.bas in SmallBASIC(not M$)  by B+  2015-March"
  ?
  ? "                 HOW SHALL WE SEED OUR NEXT RUN?"
  ?
  ? " type 1(enter) to seed from input here ie line(enter),line(enter)... d(enter)"
  ?
  ? " type 2(enter) to seed from Notepad file (better editor but temp file)"
  ? "      2 Requires Windows and n.bat that calls Notepad with file to edit."
  ?
  ? " type filename(enter) to seed from file made earlier (BTW don't call files 1 or 2)"
  ?
  ? " type any other to quit (and go make a seed file?)"
  ?
  ? " Oh! BTW, max array sides are currently set at ";an;" X ";an
  ?  
  input "Choice is ";menu
  if menu="1" then
    cls
    ? "Use any character for cell (alive) and spacebar for space (no Life),"
    ? "Characters per line and number of lines is limited to ";an
    ? "           type: d(enter) when done, d+(enter) = done."
    ? "example:
    ?
    ? "? XXXX   XXXX"
    ? "?  XX     XX"
    ? "?      X"    
    ? "?      X" 
    ? "?  X       X"
    ? "?   xxXXXxx"
    ? "?" 
    ? "? d(enter)"
    ?
    f=1
    while f
      input inps
      if lcase(inps) = "d" then 
        f=0
      else
        sdRow+=1:seed(sdRow)=inps 
        if sdrow=an then f=0
      fi
    wend
  elif menu="2"
    f=freefile
    OPEN "tempSeed.txt" FOR OUTPUT AS #f
    PRINT #f, "X"
    CLOSE #f
    RUN "n.bat tempSeed.txt"
    seedfile("tempSeed.txt")
  else
    if exist(menu) then seedfile(menu)
  fi  
end
'======================================================= seedfile
sub seedfile(fname)
  local f, inps
  f=freefile
  OPEN fname FOR INPUT AS #f
  while not EOF(f)
     LINE INPUT #f, inps
     if inps="" then inps=" "
     if sdRow<an then sdRow+=1 :seed(sdRow)=inps
     if sdRow>=an then exit
  wend
  CLOSE #f
end
'============================================= neighbor count nc(x,y)
func nc(x,y)
  nc=a(x-1,y-1)+a(x-1,y)+a(x-1,y+1)+a(x,y-1)+a(x,y+1)+a(x+1,y-1)+a(x+1,y)+a(x+1,y+1)
end
'======================================== theNextGeneration with Rules option
sub theNextGeneration()
  local x,y,r
  p=0:g+=1
  for x=2 to an-1
    for y=2 to an-1
      r=str(nc(x,y))
      if a(x,y) then 'cell is alive so what is surviveRule
        if instr(surviveRule,r) then ng(x,y)=1 :p+=1 else ng(x,y)=0
      else 'birth?
        if instr(birthRule,r) then ng(x,y)=1 :p+=1 else ng(x,y)=0 
      fi
     next
  next
  a=ng 
  showA
end
'============================================ show our work
sub ShowA()
  local x,y
  color 0,15:cls
  rect 1,1,bigBlock,bigBlock,11 filled 
  for y=1 to an
     for x=1 to an
        if A(x,y)=1 then rect (x-1)*s+1,(y-1)*s+1,step cs,cs,12 filled
     next
  next
  color 0,15 
  locate 1,100 :? "GEN: ";g;
  locate 3,100 :? "POP: ";p;
  locate 5,100 :? "Survive Rule:"
  locate 6,100 :? surviveRule
  locate 8,100 :? "Birth Rule:"
  locate 9,100 :? birthRule
  locate 11,100:? "Array: "
  locate 12,100:? an;" X ";an;
  locate 21,100 :? "Press (esc) &";
  locate 22,100 :? "  hold to end";
  locate 41,100
  if inkey=chr(27) then p=0
end