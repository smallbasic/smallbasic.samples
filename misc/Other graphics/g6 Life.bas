'g6 Life.bas SmallBASIC (not MS) B+ for Bpf 2015-03-25 5.30PM
'show neighbor count color only if the cell is NOT active!!!
'VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV  settings
'keep things square everything depends on "an" the number of rows and columns to use: 
'arrays [an X an] board [an*s X an*s] or cells [s-1 X s-1] most screens ymax < xmax
'ymax is SmallBasic constant for screen height in pixels
'will separate cells until row height (s) drops below 3 then cell side is same  
an=130: s=int(ymax/an): if s<10 then cs=s else cs=s-1: bigBlock=an*s '<==============only set an
dim a(1 to an,1 to an), seed(1 to an), ng(1 to an,1 to an),ls(1 to an, 1 to an)
waitms=0 '<100 good for an130, 0 after 150?=======================according to an, set waitms
liveCellColr=0 'black
'liveCellColr=14 'br yellow
'std conways 23/3, crystal 23/23, pagoda 1234/28, Mazectric 1234/4, Ameoba 1358,357

surviveRule="1234" : birthRule="38" '<================================set SurviveRule and birthRule

'seedMenu=1 '<=====================================================set seedMenu to manual input

'seedMenu=2 '<=======================================================set seedMenu to Notepad edit

'seedMenu=3 'to use a Random Seed <===================================set seedMenu to random seed
rndseedrow=20 '<=====================================set rndSeedRow
rndseedcol=20 '<=====================================set rndSeedCol
rndseedfill=.5 '<====================================set rndSeedFill

'=====================================================================set seedMenu to seed file 
'seedMenu="seed2.txt" 'file 3 rows of 30, 10 rows apart, pop 90
seedMenu="sd30sq.txt" '30 X 30 square, pop 118
'seedMenu="sd 2 eyed blinker.txt" 'just a row of 9 that blinks in std Conway life, pop 9
'^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ all settings

'load seed string array, if no sdRow then END================== no seed END
getSeed()
if sdRow=0 then ? "Goodbye!" : END

'load seed into main array a()
L = 0 'make L longest string length of seed
for x = 1 to sdRow
   if len(seed(x)) > L then L =  len(seed(x))
next x
'put seed in center of a()
xm = int(an/2) - int(sdRow/2)
ym = int(an/2) - int(L/2)
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
saveNote=seedNote
seedNote="press any key"
ShowA 
pause 10
seedNote=saveNote

'OK Life, live long and prosper
g=0
while flgQuit=0
  theNextGeneration()
  delay waitms
wend
? "Goodbye!"
end '=============================================== end

'============================================================= getSeed
sub getSeed()
  'basically need to get seed() loaded for seeding array a [an X an]
  local f, inps, cols, r, c 
  color 0,15:cls
  'not local seed(), sdRow, an
  sdRow=0
  if seedMenu="1" then
    ? "Use any character for cell (alive) and spacebar for space (no Life),"
    ? "Characters per line and number of lines is limited to ";an
    ? "           type: d(enter) when done, d+(enter) = done."
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
    seedNote="Manual"
  elif seedMenu="2"
    RUN "n.bat tempSeed.txt"
    seedfile("tempSeed.txt")
    seedNote="Notepad"
  elif seedMenu="3"
    for r=1 to rndSeedRow
      inps=""
      for c=1 to rndSeedCol
        if rnd<rndSeedFill then inps+="X" else inps+=" "
      next
      seed(r)=inps
    next
    sdrow=rndSeedRow
    seedNote="RND seed"
  else 'menu = fname? well if it exists!
    seedNote=seedMenu 'if exists
    if exist(seedMenu) then seedfile(seedMenu) else ? "Sorry, "+seedMenu+", file does not exist."
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
'======================================== theNextGeneration with Rules option
sub theNextGeneration()
  local x,y,r,pc
  p=0:g+=1
  for x=2 to an-1
    for y=2 to an-1
      pc=a(x-1,y-1)+a(x-1,y)+a(x-1,y+1)+a(x,y-1)+a(x,y+1)+a(x+1,y-1)+a(x+1,y)+a(x+1,y+1)
      ls(x,y)=pc
      r=str(pc)
      if a(x,y) then 'cell is alive so what is surviveRule
        if instr(surviveRule,r) then ng(x,y)=1 :p+=1 else ng(x,y)=0
      else 'birth?
        if instr(birthRule,r) then ng(x,y)=1 :p+=1 else ng(x,y)=0 
      fi
    next
  next
  if inkey=chr(32) then flgquit=1 
  lightShow
end
'============================================ show our work
sub ShowA()
  local x,y
  color 0,15:cls
  rect 1,1,bigBlock,bigBlock,0 filled 
  for y=1 to an
     for x=1 to an
        if A(x,y)=1 then 
          rect (x-1)*s+1,(y-1)*s+1,step cs,cs,12 filled
        else
          rect (x-1)*s+1,(y-1)*s+1,step cs,cs,15 filled
        fi
     next
  next
  detail
end

sub lightShow()
  local x,y,lc,cl
  color 0,15:cls
  rect 1,1,bigBlock,bigBlock,15 filled 
  for y=1 to an
     for x=1 to an
       if a(x,y) then 'show old a with it's neighbor counts br yellow or black
         rect (x-1)*s+1,(y-1)*s+1,step cs,cs,liveCellColr filled
       else
         lc=ls(x,y)
         select lc
         case 0 :cl=15 'br white
         case 1 :cl=11 'cyan 
         case 2 :cl=7  'low white, br gray
         case 3 :cl=10 'light green
         case 4 :cl=9  'blue 
         case 5 :cl=13 'violet 
         case 6 :cl=12 'br red
         case 7 :cl=4  'dark red
         case 8 :cl=0  'black
         end select
         rect (x-1)*s+1,(y-1)*s+1,step cs,cs,cl filled
       fi
     next
  next
  a=ng 'now! update a
  if inkey=chr(32) then flgquit=1
  detail
end

sub detail()
  local cc
  color 0,15 
  locate 1,110 :? "GEN: ";g;
  locate 3,110 :? "POP: ";p;
  locate 5,110 :? "Survive Rule:"
  locate 6,110 :? surviveRule
  locate 8,110 :? "Birth Rule:"
  locate 9,110 :? birthRule
  if liveCellColr=0 then cc="Black"
  if liveCellColr=14 then cc="Yellow"
  if len(cc) then
    locate 11,110:? "Active Cells:"
    locate 12,110:? cc
  fi
  locate 14,110:? "Array: "
  locate 15,110:? an;" X ";an;
  locate 17,110:? "Seed Note:"
  locate 18,110:? seedNote
  locate 37,110:? "Press spacebar";
  locate 38,110:? "& hold to end";
  locate 41,110
  if inkey=chr(32) then flgquit=1
end
