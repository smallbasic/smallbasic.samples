'draw rectangle.bas SmallBASIC 2015-04-22 B+

? "                   DRAWING RECTANGLES"
? "The top left corner of the screen is 0,0 the X,Y origin."
? "X axis runs right horizontally to say 800 pixels."
? "Y axis runs vertically downwards to say 400 pixels."
? "such that the extreme bottom right corner X,Y is 800,400."
? "So that is our drawing space for the rectangle."
?
? "In SmallBASIC you draw a rectangle by saying X,Y of one corner"
? "and then X,Y of opposite corner that fits within the rectangle"
? "of the drawing area."
?
? "So rectangle 100,100, 200,200 looks like this:
wait4key
'draw screen, big black rectangle
rect 0,0, 800,400, 0 filled
rect 100,100, 200,200, 15
locate 30,0:wait4key

while 1
   cls
   locate 5,0
   ? "Remember top left corner is 0,0 and bottom right corner is 800,400."
   ? "You must choose X,Y that fits inside those corners."
   ?
   Input "Now your turn, type an x,y for top left corner and enter ";x,y
   ?
   Input "Now we need the bottom right corner x,y enter ";x1,y1
   ?
   Input "Now blue is 9 and red is 12, any number to 15 for color ";c
   rect 0,0, 800,400, 0 filled
   rect x,y, x1,y1, c
   locate 30,0:wait4key
   cls
   locate 10,0
   Input "To do again press any key and enter, to quit just press enter ";again
   if !len(again) then ? "OK, goodbye.":end
wend

end
sub wait4key()
   local k
   ? " *** Press any key to continue ***"
   k=0
   while k=0
      k=inkey
   wend
end