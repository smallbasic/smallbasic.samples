
''' Calendar Program 
'' with pen GUI extensions
'' Apologies to Bob Riess for hacking his code :-)
''  [This will look best on a palm]
'' GUI/changes
'' opens with current month
'' tap < for previous month
'' tap > for next month
'' tap elsewhere for month/year entry
'' tap "." to exit

const box=18
const lmar=80-box*7/2
const tmar=34

declare sub setup()
declare sub askdate()
declare sub drawcal()
declare sub calcdate()
declare func penio()	'' pen gui
declare sub mup(m y)	'' next month
declare sub mdn(m y)	'' prev month

SUB setup
  dim ds(0 to 6),ms(12,2)
  for i=0 to 6 : read ds(i) : next
  data "Su","Mo","Tu","We","Th","Fr","Sa"
  for i=1 to 2 : for j=1 to 12 : read ms(j,i)
  next : next
  data "January","February","March","April","May","June","July","August","September","October","November","December"
  data 31,28,31,30,31,30,31,31,30,31,30,31
 
  split DATE ,"/,",v	 '' start at current month
  m=val(v(1))
  y=val(v(2))
end

SUB askdate
  at 3,148
  input "Month,Year? ",ln$
  cls
  if ln$="." 		 '' stop
     stop
  elseif  ln$=0
     split DATE ,"/,",v '' restart at current month
     m=val(v(1))
     y=val(v(2))
  else
    split ln$,"/,",v    '' month/year entry
    m=val(v(0))
    y=val(v(1))
  endif
end

SUB calcdate
   d=(1461*(y+4800+(m-14)\\12)\\4+367*(m-2-12*((m-14)\\12))\\12-3*((y+4900+(m-14)\\12)\\100)\\4+1)%7
   ms(2,2)=28+(y%4=0 and (y%100<>0 or y%400=0))
   n=ms(m,1)+" "+str$(y)
end

FUNC penio	'' pen GUI function
  local o
  pen on
  p=tmar/2 + 6*box
  o=0
  while pen(0)=0
  wend
  while pen(3)=1
  wend 
  if pen(1) > tmar/2 and pen(1) < tmar and pen(2)> tmar/2-txth("<") and pen(2) < tmar/2
    o=1
  elif pen(1)>p and pen(1) < p+box and pen(2) > 1 and pen(2) < tmar/2
    o=2
  fi
  penio=o
end

SUB drawcal
   at 1+tmar/2,6
   print "<";
   p=tmar/2 + 6*box
   at 8+p+box/4,6
   print ">";

   '' header
   at 1+(160-txtw(n))/2-len(n)/2,tmar/2-txth(n)
   print cat(1);n;cat(0)

   '' # of rows
   i=(ms(m,2)+d+6)\\7

   '' verticals
   for n=0 to 7 : line lmar+box*n,tmar,lmar+box*n,tmar+box*i : next

   '' horizontals
   for n=0 to i : line lmar,tmar+box*n,lmar+box*7,tmar+box*n : next

   '' days
   for n=0 to 6
     at lmar+1+box*n+(box-txtw(ds(n)))/2,tmar-1-txth(ds(n))
     print ds(n)
   next

   '' actual calendar
   for i=0 to ms(m,2)-1
     row=(d+i)\\7
     col=(d+i)%7
     n=str$(i+1)
     at lmar+1+box*col+(box-txtw(n))/2,tmar+1+box*row+(box-txth(n))/2
     print n
   next
end

sub mup(BYREF m, BYREF y)
  m=m+1
  if m=13
    y=y+1
    m=1
  fi
end

sub mdn(BYREF m, BYREF y)
  m=m-1
  if m=0
    y=y-1
    m=12
  fi
end


#MAIN
setup
repeat
  if ubound(v) then
    calcdate
    drawcal
    q=penio
    if q=2
      cls
      mup m, y
    elseif q=1
      cls
      mdn m, y
    else
      askdate
    fi
  fi
until
'
