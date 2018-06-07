randomize
game = "etbvgisnnwnsfayt"
dim board(3,3)
for y = 0 to 3
  for x = 0 to 3
    idx = 1 + (y*4 + x)
    ch = mid(game, idx, 1)
    board[y,x] = ch
  next x
next y
for y = 0 to 3
  for x = 0 to 3
    x1=x
    y1=y
    wrd = board[y,x]
    for i = 0 to 5
      x1= min(3, iff(rnd > 0.5, x1+1, 0))
      x1= max(0, min(3, iff(rnd > 0.5, y1-1, 0)))
      logprint y1+" "+x1
      wrd += board[y1,x1]
    next i
    logprint wrd
  next x
next y

