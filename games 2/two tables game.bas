
'Two Tables.txt Game for SmallBasic 012.2 by [B+=MGA] 2016-01-15
'2016-01-16 fix logic bug to assure all numbers will be unique
'2016-01-16 fix with cols and rows for landscape or portrait screens
'2016-01-16 remove need for keyboard, use "buttons" to quit or play again
'2016-01-16 add delays in inner while loops to reduce CPU usage

'setup for alternate screens based on text height and width, about 100 items in tables 
th=txth("By")
tw=txtw("8")
if tw*7*10> xmax then cols=int(xmax/(tw*7)):rows=int(100/cols) else cols=10:rows=10
items=rows*cols
prow=(2*rows+2)*th
qrow=prow+2*th
dim a(items),b(items)
while 1
    'init tables a and b and display
    cls
    pen on
    a(0)=10000
    for i=1 to items 'save time and presort
        a(i)=a(i-1)+int(rnd*1000)+1
        print "  ";a(i);
        if i mod cols=0 then print
    next
    rwin=int(rnd*items) +1
    if rwin mod cols=0 then xwin=(cols-1)*tw*7 else xwin=((rwin mod cols)-1)*tw*7
    ywin=int((rwin-1)/cols)*th
    win=a(rwin)
    print
    adj=0
    for i=1 to (items-1)
        if a(i)=win then adj=1
        b(i)=a((i+adj))
        print "  ";b(i);
        if i mod cols=0 then print
    next
    b(items)=a(items)+int(rnd*1000)+1
    print "  ";b(items)
    print
    'pose the question then start timing
    t=ticks
    at 0,prow:print "  Tap top table # missing in lower"
    while 1
      if pen(3) then xguess=pen(4):yguess=pen(5):delay 10:exit
      delay 100
    wend
    xright=0:yright=0
    if xguess> xwin and xguess< xwin+7*tw then xright=1
    if yguess> ywin and yguess< ywin+th then yright=1
    at 0,prow:Print space(40):at 0,prow
    if xright and yright then print "  Right! in "; else print "  ";win;", sorry, in ";
    print int((ticks-t)/1000);" sec."
    print "   A short pause then prompt coming..."
    delay 8000
    cls
    rect .125*xmax,.375*ymax,.375*xmax,.625*ymax,10 
    rect .625*xmax,.375*ymax,.875*xmax,.625*ymax,12 
    at .25*xmax-5*tw,ymax/2:? "PLAY AGAIN"
    at .75*xmax-2*tw,ymax/2:? "QUIT"
    mx=0
    while 1
      if pen(3) then 
        mx=pen(4):pen off
        if mx> xmax/2 then
          end
        else
          at (xmax-20*tw)/2,.9*ymax:? "One moment please...":delay 2000: exit
        end if
      end if
      delay 100
    wend
wend
