
'Mine Sweeper v4SB.bas by MGA/B+ 2015-08-25 finally got recursion working
' edit for post On-line 2015-11-05 MGA/B+
' edit for NOOK app 2015-12-04
if xmax> ymax then ssq=ymax else ssq=xmax
randomize
dim dircol(1 to 8)
dim dirrow(1 to 8)
for i=1 to 8
  read col,row
  dircol(i)=col
  dirrow(i)=row
next
data 1,0,1,-1,0,-1,-1,-1,-1,0,-1,1,0,1,1,1
arrd=10 ' for square (arrd X arrd) array pick a size  you want 3x3 to 25x25
th=txth("By")
tly=2.5*th
sq=int((ssq-6*th)/arrd)
tlx=int((ssq-arrd*sq)/2)  ' off set this for prints in first columns
restart=1
color 0,11:cls
t="Mine Sweeper 4SB  tap/click a mine free cell,  q quits"
at (ssq-txtw(t))/2,th:print t
t="Toggle red markers: tap/click here or mouse over+space"
at (ssq-txtw(t))/2,3.5*th+sq*arrd:print t
pen on
toggleON=0
while 1
  k=inkey
  if k="q" then exit
  if len(k)=1 and asc(k)=32 then togglecell
  if restart then initialize
  if pen(0) then 'a right click or a scroll will all do this pen 3 or 0
    if pen(12) then
      if pen(5)>3*th+sq*arrd then
        delay 100
        if ToggleON then ToggleON=0 else ToggleON=1
        if ToggleON then tcc=12 else tcc=15
        rect 0,ssq-th,ssq,ssq,tcc filled
        showpage
      end if   
      dx=bx(pen(4))
      dy=by(pen(5))
      if dx<> 0 and dy<> 0 then
        if toggleON then 
          togglecell
        elif m(dx,dy)=1 
          rect tlx-1,tly-1,tlx+arrd*sq+1,tly+arrd*sq+1,11 filled
          t="KA-BOOM!"
          at (ssq-txtw(t))/2,(ssq-th)/2:print t
          showpage : delay 1000
          rect tlx-1,tly-1,tlx+arrd*sq+1,tly+arrd*sq+1,0 filled
          for x=1 to arrd
            for y=1 to arrd
              if m(x,y)=1 then
                rect tlx+sq*(x-1),tly+sq*(y-1),tlx+sq*(x-1)+sq-2,tly+sq*(y-1)+sq-2,12 filled
              elseif toggle(x,y)=-1
                show x,y
              else
                rect tlx+sq*(x-1),tly+sq*(y-1), tlx+sq*(x-1)+sq-2,tly+sq*(y-1)+sq-2,10 filled
              endif
            next
          next
          showpage
          delay 5000
          restart=1
        else
          if board(dx,dy)=0 and toggleON=0 then showzeros else show dx,dy
          TFwin
        endif 'mine or not
        showpage
      endif 'if dx,dy on board
    elseif pen(13)
      togglecell
    end if ' pen 12 or pen 13 
  endif 'mouse event
wend
'=======================================ending after esc pressed
pen off
end
'================================= procedures
sub initialize()
  restart=0
  dim checked(1 to arrd,1 to arrd)
  dim stack()
  mines=int(.15*arrd^2)
  'mines=1 'for testing recursive sweeps
  minesplaced=0
  dim m(0 to arrd+1,0 to arrd+1)
  while minesplaced< mines
    rx=int(rnd*arrd)+1
    ry=int(rnd*arrd)+1
    if m(rx,ry)=0 then
      m(rx,ry)=1
      minesplaced=minesplaced+1
    endif
  wend
  dim board(1 to arrd,1 to arrd)
  'count mines amoung the neighbors
  for y=1 TO arrd
    for x=1 TO arrd
      if m(x,y)<> 1 then
        board(x,y)=m(x-1,y-1)+m(x-1,y)+m(x-1,y+1)+m(x,y-1)+m(x,y+1)+m(x+1,y-1)+m(x+1,y)+m(x+1,y+1)
      else
        board(x,y)=-1
      endif
    next
  next
  dim toggle(1 to arrd,1 to arrd) ' for red flagging mines
  ' show covered board
  rect tlx-1,tly-1,tlx+arrd*sq+1,tly+arrd*sq+1,0 filled
  for x=1 to arrd
    for y=1 to arrd
      rect tlx+sq*(x-1),tly+sq*(y-1),tlx+sq*(x-1)+sq-2,tly+sq*(y-1)+sq-2,10 filled
    next
  next
  if ToggleON then tcc=12 else tcc=15
  rect 0,ssq-th,ssq,ssq,tcc filled
  showpage
end

func bx(mx) 'convert mouse x to array x
  rtn=int((mx-tlx)/sq +1)
  if rtn< arrd+1 and rtn> 0 then bx=rtn else bx=0
end

func by(my) 'convert mouse y to array y
  rtn=int((my-tly)/sq +1)
  if rtn< arrd+1 and rtn> 0 then by=rtn else by=0
end

sub togglecell()
  dx=bx(pen(4)) : dy=by(pen(5))
  if dx<> 0 and dy<> 0 then
    if toggle(dx,dy)=0 then
      toggle(dx,dy)=1:cc=12
    elseif toggle(dx,dy)=1
      toggle(dx,dy)=0:cc=10
    endif
  endif
  rect tlx+sq*(dx-1),tly+sq*(dy-1),tlx+sq*(dx-1)+sq-2,tly+sq*(dy-1)+sq-2,cc filled
  showpage : delay 100
end

sub TFwin()
  tc=0
  for x=1 to arrd
    for y=1 to arrd
      if toggle(x,y)=-1 then tc=tc+1
    next
  next
  if tc=arrd*arrd-mines then
    rect tlx-1,tly-1,tlx+arrd*sq+1,tly+arrd*sq+1,11 filled
    t="Congratulations, ALL CLEAR!"
    at (ssq-txtw(t))/2,(ssq-th)/2:print t
    showpage : delay 3000
    restart=1
  endif
end

sub show(x,y)
  toggle(x,y)=-1
  rect tlx+sq*(x-1),tly+sq*(y-1), tlx+sq*(x-1)+sq-2,tly+sq*(y-1)+sq-2,11 filled
  t=str(board(x,y))
  at tlx+sq*(x-1)+(sq-txtw(t))/2,tly+sq*(y-1)+(sq-txth(t))/2:print t
end

sub showzeros()
  show dx,dy
  checked(dx,dy)=1
  For dir = 1 To 8
    append stack,dx,dy,dir
    dx = dx + dirCol(dir)
    dy = dy + dirRow(dir)
    if (1 <= dx) and (dx<= arrd) and (1 <= dy) and (dy <= arrd) then
      if checked(dx,dy) = 0 then
        if toggle(dx,dy) <> -1 then show dx,dy
        if board(dx,dy) = 0 then showzeros() else checked(dx,dy) = 1
      endIf
    endif
    dir=stack(ubound(stack))
    delete stack,ubound(stack)
    dy=stack(ubound(stack))
    delete stack,ubound(stack)
    dx=stack(ubound(stack))
    delete stack,ubound(stack)
  next
end
