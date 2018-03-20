
'ellipse.bas in SmallBASIC 2015-09-23 MGA/B+

'this helps show how SmallBASIC draws an ellipse from a circle

option base 1
dim px(4),py(4) 

? "To draw ellipse inside a frame: click top left corner then bottom right corner."
pen on
XYclick 1 'point 1 recorded into arrays
XYclick 2 'point 2 recorded into arrays
'2 points make a box
rect px(1),py(1),px(2),py(2)

ellipse px(1),py(1),px(2)-px(1),py(2)-py(1),12,1

sub ellipse(tlx,tly,xwide,ytall,colr,fill)
   local cx,cy,cr,ca
   cx=tlx+xwide/2 :cy=tly+ytall/2
   cr=xwide/2     :ca=ytall/xwide
   
   'ca is the circle "aspect" ratio: y axis / x axis
   
   if fill then 
      circle cx,cy,cr,ca,colr filled 
   else 
      circle cx,cy,cr,ca
   end if
end sub
   
sub XYclick(PointIndex)
   local ptx, pty
   ptx=-100
   while ptx=-100
      if pen(3) then ptx=pen(4):pty=pen(5)
   wend
   circle ptx,pty,2,1 filled
   px(pointindex)=ptx
   py(pointindex)=pty
   delay 200
end
