'snake reconfig v worm holes.bas SmallBASIC 0.12.6 [B+=MGA] 2016-06-29
'2015-06-08 started from BASIC256 game versions 1-5 
'           use board array to store all data
'2016-06-27 v5 update with definekey use arrows
'2016-06-28 reconfigure for SmallBASIC array handling
'           now board only tracks grass colors
'           d = [x, y] direction array
'           food = [x, y] food location
'           snake = [x, y] of snake segments
'2016-06-28 v2 hey, it's way past time to loose base 1 board
'2016-06-29 v worm holes and rocks

const B = 25 'Board and array dimension BxB array and board
const BM1 = B - 1 'B Minus 1, board and drawing 0 based
const title = "SNAKE GAME move: up, down, left, right  (re)start: spacebar"
const th = txth(title)
const tw = txtw(title)
const tly = 2 * th 
const sq = int( (ymax - 5 * th) / B ) 'decide square size according ymax 
const tlx = (xmax - B * sq) / 2

const up = [0, -1]
const dwn = [0, 1]
const rght = [1, 0]
const lft = [-1, 0]

const wormHoles = [[4, 4], [4, 20], [20, 20], [20, 4], [12,12]]
randomize
'======== key instructions: 
definekey 0xFF04, aLeft   'press left arrow
definekey 0xFF05, aRight  'press right arrow
definekey 0xFF09, aUp     'press up arrow
definekey 0xFF0A, aDown   'press down arrow
defineKey 32, startGame   'spacebar restarts game
definekey 27, esc         'press esc to quit

dim snake(), rocks()

'definekey subs for arrows, esc
sub aLeft
  d = lft
end

sub aRight
  d = rght
end

sub aUp
  d = up
end

sub aDown
  d = dwn
end

sub esc
  quit = 1
end 

sub Update()
  local x,y
  for x = 0 TO BM1            'grass patch colors stored in board
    for y = 0 TO BM1
      if [x,y] in wormHoles then
        rect tlx + sq * x, tly + sq * y step sq, sq, 0 filled
      elif [x, y] in rocks
        rect tlx + sq * x, tly + sq * y step sq, sq, 7 filled
      else
        rect tlx + sq * x, tly + sq * y step sq, sq, board(x, y) filled
      fi
    next
  next
  'food is color 13
  rect tlx + sq * food(0), tly + sq * food(1) step sq, sq, 13 filled
  stripeSnake
  showpage
end

sub stripeSnake()
   local j, cc, ccc
   rect tlx + sq * snake(0)(0), tly + sq * snake(0)(1) step sq, sq, 14 filled
   rect tlx + sq * snake(1)(0), tly + sq * snake(1)(1) step sq, sq, 10 filled
   if morsels then
      for j = 1 to morsels
         cc = j mod 4 
         select case cc
         case 0 : ccc = 10
         case 1 : ccc = 9
         case 2 : ccc = 5
         case 3 : ccc = 12
         end select
         rect tlx + sq * snake(j + 1)(0), tly + sq * snake(j + 1)(1) step sq, sq, ccc filled
      next
   endif
end
 
sub startgame()
  local i, j
  dim board(BM1, BM1)
  for i = 0 to BM1
    for j = 0 to BM1
      board(i, j) = rgb(0, rnd * 30 + 60, 0)
    next
  next
  append snake, [12, 6]
  append snake, [12, 5]
  food = [15, 15]
  d = [0, 1]
  for i = 1 to 6
    repeat
      OK = 1
      test = [ int(rnd * B) , int(rnd * B) ]
      if test in snake then 
        OK = 0
      elif test in wormHoles 
        OK = 0
      elif test = snake(0) + d
        OK = 0
      elif test = snake(0) + d + d
        OK = 0
      fi
    until OK
    rocks << test
  next
  quit = 0 : morsels = 0 
  update
end

'=================================================================main
color rgb(200, 200, 220), 0
at (xmax - tw) / 2, 0 : ? title
s1 = "Game over: crash into wall or snake, (reverse) direction,  or esc"
at (xmax - txtw(s1)) / 2, th : ? s1 
startgame
repeat
  new = d + snake(0)
  'are we still in play?
  if new(0) > BM1 or new(0) < 0 or new(1) > BM1 or new(1) < 0 then 
    exit 'game over we hit a wall
  elif new in snake 
    exit 'the snake hit itself
  elif new in rocks
    exit 'hit a rock
  fi
  'still alive?
  if new = food 'we hit our morsel of food and grow one segment, set up another morsel
    morsels += 1
    insert snake, 0, new
    repeat
      OK = 1
      test = [ int(rnd * B) , int(rnd * B) ]
      if test in snake then OK = 0
      if test in wormHoles then OK = 0
      if test in rocks then OK = 0
    until OK
    food = test
  else 'add new segment and loose the last segment
    if new in wormHoles then
      rHole = int(rnd * 5)
      new = d + wormHoles(rHole)
    fi
    insert snake, 0, new
    delete snake, ubound(snake)
  fi
  update
  delay 300
until quit
s1 = "Your snake ate " + morsels + " morsels. Goodbye!"
at (xmax - txtw(s1) ) / 2, ymax - 2 * th - 5 : ? s1
showpage
delay 2000
pause 2
