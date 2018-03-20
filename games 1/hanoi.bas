
''' 20/11/2004 18:56:09

option base 1

const cBackground = rgb(0, 127, 0)
const cDisc = rgb(0, 0, 255)
const cTower = rgb(128, 64, 0)

sub drawScreen(disc())
  wTower = int(xmax / 3)
  wPost = int(wTower / 8)
  hDisc = (ymax - 3 * textheight("M") - 2 * wPost) / 11
  for i = 1 to 3
    x = (i - 1) * wTower + wTower / 2
    rect x - wPost / 2, int(wPost / 2), x + wPost / 2, ymax - 3 * textheight("M"), cTower filled
  next i
  rect 0, ymax - 3 * textheight("M") - wPost, xmax, ymax - 3 * textheight("M"), cTower filled
  for i = 1 to 3
    for j = 1 to 11
      x = (i - 1) * wTower
      y = ymax - 3 * textheight("M") - wPost - j * hDisc
      if disc(j, i) = 0 then
        rect x, y, x + wTower / 2 - wPost / 2, y + hDisc, cBackground filled
        rect x + wTower / 2 + wPost / 2, y, x + wTower, y + hDisc, cBackground filled
      else
		wDisc = wPost + int (disc(j, i) / 11 * (wTower - 2 * wPost))
        rect x + wTower / 2 - wDisc / 2, y, x + wTower / 2 + wDisc / 2, y + hDisc, cDisc filled
        rect x + wTower / 2 - wDisc / 2, y, x + wTower / 2 + wDisc / 2, y + hDisc, 0
      endif
    next j
  next i
end

func getKeyPress(allowedKeys$)
  repeat
    repeat
      key$ = inkey
    until len(key$) > 0
    if key$ >= "a" and key$ <= "z" then key$ = chr$(asc(key$) - 32)
  until key$ in allowedKeys$
  getKeyPress = key$
end

dim tower(3)
dim disc(11, 3)
color 0, 15
cls
rect 0, 0, xmax, ymax - 3 * textheight("M"), cBackground filled
repeat
  tower(1) = 0
  tower(2) = 0
  tower(3) = 0
  for i = 1 to 11
    disc(i, 1) = 0
    disc(i, 2) = 0
    disc(i, 3) = 0
  next i
  drawScreen disc
  rect 0, ymax - 3 * textheight("M"), xmax, ymax, 15 filled
  at 0, ymax - 3 * textheight("M") : print "Level (1 to 9)..."
  key$ = getKeyPress("123456789")
  rect 0, ymax - 3 * textheight("M"), xmax, ymax, 15 filled
  at 0, ymax - 3 * textheight("M") : print "Game at level " + key$ + "..."
  level = val(key$)
  tower(1) = level + 2
  for i = 1 to tower(1)
    disc(i, 1) = tower(1) - i + 1
  next i
  moves = 1
  repeat
    drawScreen disc
    repeat
      rect 0, ymax - 3 * textheight("M"), xmax, ymax, 15 filled
      at 0, ymax - 3 * textheight("M") : print "Move " + moves + ":"
      at 0, ymax - 2 * textheight("M") : print "Source tower (1, 2 or 3)..."
      key$ = getKeyPress("123")
      sIndex = val(key$)
      sTower = tower(sIndex)
      if sTower = 0 then
        rect 0, ymax - 3 * textheight("M"), xmax, ymax, 15 filled
        at 0, ymax - 3 * textheight("M") : print "Tower " + key$ + " is empty..."
        pause 2
      endif
    until sTower <> 0
    rect 0, ymax - 3 * textheight("M"), xmax, ymax, 15 filled
    at 0, ymax - 3 * textheight("M") : print "Move " + moves + ":"
    at 0, ymax - 2 * textheight("M") : print "Destination tower (1, 2 or 3)..."
    key$ = getKeyPress("123")
    dIndex = val(key$)
    dTower = tower(dIndex)
    ok = false
    if dTower = 0 then
      ok = true
    else
      if disc(sTower, sIndex) < disc(dTower, dIndex) then ok = true
    endif
    if ok then
      dTower = dTower + 1
      tower(dIndex) = dTower
      disc(dTower, dIndex) = disc(sTower, sIndex)
      disc(sTower, sIndex) = 0
      sTower = sTower - 1
      tower(sIndex) = sTower
      moves = moves + 1
    else
      rect 0, ymax - 3 * textheight("M"), xmax, ymax, 15 filled
      at 0, ymax - 3 * textheight("M") : print "Illegal move..."
      pause 2
    endif
  until tower(2) = level + 2 or tower(3) = level + 2
  drawScreen disc
  rect 0, ymax - 3 * textheight("M"), xmax, ymax, 15 filled
  at 0, ymax - 3 * textheight("M") : print "GAME OVER in " + moves + " moves !!!"
  at 0, ymax - 2 * textheight("M") : print "Do you wabt to play again?"
  key$ = getkeyPress("YN")
until key$ = "N"
'
