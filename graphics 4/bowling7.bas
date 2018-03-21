' Bowling 7.bas for SmallBASIC 12.8 [B+=MGA] 2017-01-20
' cross pollinate work with Johnno at SdlBasic Bowling 6
' modify for SmallBASIC

const th = txth("Q")
const tw = txtw("W")
const bh = th + 6
const bw = tw + 8
const bbw = 3 * bw
const bbh = 2 * bh
const xTopSheet = 40
const ytopSheet = 450

const xoff = 0
const yoff = 20
const pins = 10
const pr = 22
const spacer = 80
const ygutter = 4 * spacer + 2 * yoff 

const board1 = rgb(253, 200, 132)
const board2 = rgb(252, 191, 110)
const board3 = rgb(247, 179,  93)
const board4 = rgb(250, 187, 114)
const board5 = rgb(244, 169,  96)

'    PLAY("file://pickup.wav")


dim px(pins), py(pins), pa(pins), pc(pins), ps(pins), pd(pins), pds(pins)
dim rack(pins,2)

pin = 1
for row = 1 to 4
  for col = 1 TO row
    px(pin) = spacer*col + xoff
    py(pin) = spacer*row - spacer/2*col + yoff
    rack(pin, 0) = px(pin) : rack(pin, 1) = py(pin)
    pin += 1
  next
next

allDone = 0 : games = 0 : total = 0
while allDone = 0  'next game
  rect 0, 0, xmax, ymax, 0 filled
  dim score(10, 3) '0 for total, 1 = ball 1, 2 = ball 2, 3 = ball 3 in 10th frame
  gameOver = 0 : frameUpdate = 0 : ball = 1 : frame = 1
while gameOver = 0
  
  if ball =  1 or ball = 3 or ball = 4 or ball = 5 then  'put all the pins in rack
    for i = 1 to pins
      px(i) = rack(i,0) : py(i) = rack(i, 1) : ps(i) = 0 : pa(i) = 0 : pd(i) = 0 : pds(i) = 0
    next
  end if

  x = -100 : y = -100
  while x > xmax - pr or x < xmax - 200 or y < pr or y > ygutter- pr
    rect 0, 0, xmax, yTopSheet, 0 filled
    drawlane
    color 15
    at xTopSheet, ygutter + 20 
    ? "Frame: ";frame;"   Ball: ";sball();"    Click behind red foul line to position ball."
    for i = 1 to pins
      if pd(i) = 0 then
        px(i) = rack(i,0) : py(i) = rack(i, 1)
        pinUp
      fi   
    next
    if pen(4) > xmax - 200 + pr and pen(4) < xmax - pr and pen(5) < ygutter - 18 - pr and pen(5) > pr then
      circle pen(4), pen(5), pr, 1, 9
      if pen(3) then x = pen(4) : y = pen(5)
    end if
    delay 10
    showpage
  wend
  px(0) = x : py(0) = y
  
  x = -10 : y = -10
  while x > 500 or x < 0 or y < 0 or y > ygutter 
    rect 0, 0, xmax, yTopSheet, 0 filled
    drawlane
    color 15
    at xTopSheet, ygutter + 20
    ? "Frame: ";frame;"   Ball: ";sball();"  Click around the pins to set ball angle."
    for i = 1 to pins
      if pd(i) = 0 then
        'circle rack(i,0), rack(i, 1), pr, 1, 15 filled
        pinUp
      fi   
    next
    drawball
    if pen(4) < xmax - 200 - pr and pen(4) > pr and pen(4) < ygutter - pr then
      line px(0), py(0), pen(4), pen(5), 0
      if pen(3) then x = pen(4) : y = pen(5)
    fi
    delay 10
    showpage
  wend
  pa(0) = atan2(y-py(0), x-px(0)) : ps(0) = 25

  if ball = 1 then
    PLAY("file://resources/bowl.wav")
    else
    PLAY("file://resources/pickup.wav")
  end if
  
  notDone = 1
  while notDone
    notDone = 0
    rect 0, 0, xmax, yTopSheet, 0 filled
    color 15
    at xTopSheet, ygutter + 20
    ? "Frame: ";frame;"   Ball: ";sball() 
    drawlane
    for i = 0 to pins
      if px(i) <> -1000 then
        for j = 0 to pins
          if j <> i and pc(j) <> 1 then
            if sqr((px(i)-px(j))^2 + (py(i)-py(j))^2) < 2*pr then
              if i <> 0 then pa(i) = atan2(py(i)-py(j), px(i)-px(j)) : pc(i) = 1 
              if j <> 0 then pa(j) = atan2(py(j)-py(i), px(j)-px(i)) : pc(j) = 1: 
              s = (ps(i) + ps(j))/2 : ps(i) = s : ps(j) = s
              exit for
            fi
          fi
        next

        if ps(i) > 0 then ps(i) -= .007 else ps(i) = 0
        px(i) = px(i)+cos(pa(i))*ps(i)
        py(i) = py(i)+sin(pa(i))*ps(i)
        if pa(i) > 2*pi then pa(i) = pa(i)-2*pi
        if pa(i) < 0 then pa(i) = pa(i)+2*pi
        if py(i) < ygutter and i <> 0 then 
          if pd(i) = 0 and sqr((px(i) - rack(i,0))^2 + (py(i) - rack(i,1))^2) > .5*pr then 
            pd(i) = 1 : pds(i) = rnd * 2 * pi
          end if
          if pd(i) = 0 then
            pinUp
          else 
            pinDown
          fi 
        elseif py(i) >= ygutter and i <> 0 then
          pd(i) = 1
        end if
        if i = 0 then drawball     
        if px(i) > spacer*6 and i<>0 then ps(i) = 0
        pc(i) = 0
        if px(i) > 0 and px(i) < xmax and py(i) > 0 and py(i) < ygutter and ps(i) > 0 then notDone = 1
      fi 'if px(i) <> -100
    next
    showpage
    delay 10
  wend
  
  rect 0, 0, xmax, ymax, 0 filled
  cnt = 0
  color 15
  for i = 1 to pins
      if pd(i) then px(i) = -1000 : py(i) = -1000 : ps(i) = 0 : pa(i) = 0 : cnt += 1
  next
  
  if cnt = 10 and ball = 1 then 
    at xTopSheet, ygutter + 20 :? "Frame: ";frame;"   Strike!"
    score(frame, 1) = "X"
    if frame = 10 then
      ball = 3
    else
      ball = 1 : frameUpdate = 1
    fi
  elif cnt = 10 and ball = 2 then
    at xTopSheet, ygutter + 20 :? "Frame: ";frame;"   Ball 1: ";b1cnt;"   Ball 2: Spared!"
    score(frame, 2) = "/"
    if frame = 10 then 
      ball = 5
    else
      ball = 1 : frameUpdate = 1 : b1cnt = 0
    fi  
  elif cnt = 10 and ball = 3 then 
    at xTopSheet, ygutter + 20 :? "Frame: 10   Strike 2!!"
    ball = 4
    score(frame, 2) = "X"
  elif cnt = 10 and ball = 4 then
    at xTopSheet, ygutter + 20 :? "Frame: 10   Strike 3!!"
    score(frame, 3) = "X"
    gameOver = 1 
  elif cnt = 10 and ball = 5 then
    at xTopSheet, ygutter + 20 :? "Frame 10   Spare and 10 = 20"
    score(frame, 3) = "X"
    gameOver = 1
  elif cnt = 10 and ball = 6 then
    at xTopSheet, ygutter + 20 :? "Frame 10   Strike plus spare = 20"
    score(frame, 3) = "/"
    gameOver = 1 
  elif cnt < 10 and ball = 1 then  
    b1cnt = cnt
    at xTopSheet, ygutter + 20 : ? "Frame: ";frame;"   Ball 1: ";b1cnt
    score(frame, 1) = str(b1cnt)
    ball = 2
  elif cnt < 10 and ball = 2 then 
    b2cnt = cnt - b1cnt 
    at xTopSheet, ygutter + 20 : ? "Frame: ";frame;"   Ball 1: ";b1cnt;"   Ball 2: ";b2cnt
    score(frame, 2) = str(b2cnt)
    ball = 1 : frameUpdate = 1 
  elif cnt < 10 and ball = 3 then
    b3cnt = cnt
    at xTopSheet, ygutter + 20 :? "Frame: 10   Strike plus ";b3cnt;" plus next ball"
    score(10, 2) = str(b3cnt)
    ball = 6
  elif cnt < 10 and ball = 4 then 
    at xTopSheet, ygutter + 20 :? "Frame 10   2 Strikes plus ";cnt
    score(10, 3) = str(cnt)
    gameOver = 1
  elif cnt < 10 and ball = 5 then 
    at xTopSheet, ygutter + 20 :? "Frame 10   Spare plus ";cnt
    score(10, 3)= str(cnt)
    gameOver = 1  
  elif cnt < 10 and ball = 6 then
    at xTopSheet, ygutter + 20 :? "Frame 10   Strike plus ";b3cnt;" plus ";cnt - b3cnt
    score(10, 3) = str(cnt-b3cnt)
    gameOver = 1
  fi
  
  updateScore(frame)
  frame += frameUpdate
  frameUpdate = 0 
  showpage
  delay 3000
  
  if ball = 1 then b1cnt = 0 : b2cnt = 0
  if frame = 11 then gameOver = 1
  
wend  '=======================================================     gameOver
total = total + score(10, 0) : games += 1
color 15
at xTopSheet, yTopSheet + 80
? "Games = ";games;"  Average = ";total\games
at xTopsheet, yTopSheet + 105 
input "Play Again? Enter y for yes (any other quits) ";again
if again <> "y" then allDone = 1
wend  '================================================================== All Done

sub drawball()
  local r
  circle px(0)-15, py(0), pr, 1, 0 filled
  for r = pr+5 to 1 step -1
    circle px(0), py(0), r, 1, rgb(0, 0, 255 - 100 * r/pr) filled
  next
end 

sub pinUp()
  circle px(i), py(i), pr, 1, 15 filled
  p7 = int(.7*pr)
  circle px(i), py(i), p7, 1, 12
  circle px(i), py(i), p7+1, 1, 12
  circle px(i), py(i), .6*pr, 1, 12
end 

sub pinDown()
  local j
  circle px(i)-6, py(i), pr, 1, 0 filled
  circle px(i)+1.5*pr*cos(pds(i))-5, py(i)+1.5*pr*sin(pds(i)), .7*pr, 1, 0 filled
  circle px(i), py(i), pr, 1, 15 filled
  for j = 1 to 1.5*pr
    if (j - .9*pr < 3 and j -.9*pr > 0) then
      circle px(i)+j*cos(pds(i)), py(i)+j*sin(pds(i)), .75*pr, 1, 12 filled
    elseif (j - 1.1*pr < 3 and j -1.1*pr > 0) then
      circle px(i)+j*cos(pds(i)), py(i)+j*sin(pds(i)), .7*pr, 1, 12 filled
    else
      circle px(i)+j*cos(pds(i)), py(i)+j*sin(pds(i)), .7*pr, 1, 15 filled
    end if
  next
end  

sub drawlane()
  local b, y
  b = 0
  for y = 22 to 332 step 10
    select case (b mod 5)
    case 0 : color board1
    case 1 : color board3
    case 2 : color board2
    case 3 : color board5
    case 4 : color board4
    end select
    rect pr, y, xmax - pr, y + 10 filled
    b += 1
  next
  color 12
  rect xmax - 200, pr, xmax - pr, ygutter - 18
  rect xmax - 201, pr-1, xmax - pr+1, ygutter - 19
  ' Pindeck Pin Spots
  for i = 1 to pins
    circle rack[i,0], rack[i,1], pr*.5, 1, 8 filled
  next


end

sub updateScore(frame)
  local i
  totalUpScore(frame)  'totals up scores to current frame,  yeah it's wrong for strikes and spares
  'draw score sheet
  line xTopSheet, yTopSheet, xTopSheet + 10 *bbw, yTopSheet
  line xTopSheet, yTopSheet+bbh, xTopSheet + 10 *bbw, yTopSheet+bbh
  for i = 0 to 10
    line xTopSheet + i*bbw, yTopSheet, xTopSheet + i*bbw, yTopSheet+bbh
  next
  for i = 1 to frame   'check game out
    if i = 10 then 'at 10th first box is right at corner
      rect xTopSheet + 9*bbw, yTopSheet step bw, bh
      at xTopSheet + 9*bbw + 5, yTopSheet + 4 : ? score(10,1) 
      rect xTopSheet + 9*bbw + bw, yTopSheet step bw, bh
      at xTopSheet + 9*bbw + bw + 5, yTopSheet + 4 : ? score(10,2) 
    else
      rect xTopSheet + (i-1)*bbw + bw, yTopSheet step bw, bh
      at xTopSheet + (i-1)*bbw + bw + 5, yTopSheet + 4 : ? score(i, 1)
      rect xTopSheet + (i-1)*bbw + 2*bw, yTopSheet step bw, bh
      at xTopSheet + (i-1)*bbw + 2*bw + 5, yTopSheet + 4: ? score(i, 2)
    fi
    at xTopSheet + (i-1)*bbw + bw/2 + 3, yTopSheet + bh + 6 : ? score(i,0)
  next
  if frame = 10 then
    rect xTopSheet + 9*bbw + 2*bw, yTopSheet step bw, bh
    at xTopSheet + 9*bbw + 2*bw + 5, yTopSheet + 4 : ? score(10,3)
  fi
end 

sub totalUpScore(frame)
  local i  
  'OK now let's take the game data and add up the score
  for i = 1 to min(9, frame)
    if score(i,1) = "X" then
      if score(i+1,1) = "X" then
        if i+1 = 10 then
          if score(10,2) ="X" then
            score(i,0) = score(i-1, 0) + 30
          else
            score(i,0) = score(i-1, 0) + 20 + val(score(10,2))
          fi
        else
          if score(i +2, 1) = "X" then
            score(i, 0) = score(i-1, 0) + 30
          else
            score(i, 0) = score(i-1, 0) + 20 + val(score(i+2,1))
          fi
        fi
      else 'not "X"
        if score(i+1, 2) = "/" then
          score(i, 0) =score(i-1,0) + 20
        else
          score(i,0) = score(i-1, 0) + 10 + val(score(i+1, 1)) + val(score(i+1, 2))
        fi
      fi
    else
      if score(i,2) = "/" then
        if score(i+1,1)= "X" then
          score(i, 0) = score(i-1, 0) + 20
        else
          score(i, 0) = score(i-1, 0) + 10 + val(score(i+1, 1))
        fi
      else
        score(i, 0) = score(i-1, 0) + val(score(i, 1)) + val(score(i, 2))
      fi  
    fi
  next
  if frame = 10 then
    '10th frame
    if score(10, 1) = "X" then
      if score(10, 2) = "X" then
        if score(10,3) = "X" then
          score(10, 0) = score(9,0) + 30
        else
          score(10, 0) = score(9,0) + 20 + val(score(10, 3))
        fi
      else
        if score(10, 3) = "/" then
          score(10,0) = score(9,0) + 20
        else
          score(10, 0) = score(9,0) + 10 + val(score(10,2)) + val(score(10,3))
        fi
      fi
    else
      if score(10, 2) = "/" then ' EDIT 2017-01-16 fix spare then strike in 10th frame
        if score(10,3) = "X" then
          score(10, 0) = score(9, 0) + 20
        else
          score(10, 0) = score(9,0) + 10 + val(score(10, 3))
        fi
      else
        score(10, 0) = score(9,0) + val(score(10,1)) + val(score(10, 2))
      fi
    fi
  fi 
end 

func sball()  'what ball number to show with frame
  if ball = 1 or ball = 2 then
    sball = ball
  elseif ball = 3 then
    sball = 2
  else
    sball = 3
  end if
end
