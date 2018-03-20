' Mouse springs v1.bas SmallBASIC MGA 2015-04-18 post SmallB, 4-19 Bpf
' Demo fun mouse graphics effect, developed on Windows 7-64
maxX=800:maxY=600                                 ' draw area
centerX=maxX/2:centerY=maxY/2                     ' this is where the screen effect center is
maxR=40:dColor=1                                  ' Max Radius of Springs, ChangeColor
lowXY=maxR*2:highX=maxX-maxR*2:highY=maxY-maxR*2  ' mouse pen borders for effect 
red=12:blue=9                                     ' some color commentary
locate 0,120 : ? "Mouse Springs v1.bas"           ' a little title
locate 1,120 : ? "2015-04-18, MGA/B+"             ' a little credit
locate 3,120 : ? "Move mouse around"              ' a little description
locate 4,120 : ? "center of screen"
locate 5,120 : ? "to see the effect."
locate 7,120 : ? "press esc to END" 
while 1                                             ' loop forever
   rect 0,0,maxX,maxY,0 filled                      ' erase/blackout drawing area
   for y=lowXY to highY step maxR                   ' update our little drawing area
      for x=lowXY to highX step maxR                ' according to where current mouse is
         distance=((x-centerX)^2+(y-centerY)^2)^.5  ' calculate spring distance mouse
         topRadius=distance/11                 ' use this calculation for max spring radius 
         for radius=topRadius to 0 step -4     ' draw the spring according to distance from mouse
            dColor*=-1                         ' alternate red/blue for colorful spring
            if dColor<0 then circle x,y,radius,1,red else circle x,y,radius,1,blue 
         next r
      next x
   next y
   delay 50           'slow down the drawing
   
   label doloop
   k=inkey                                        ' check to quit
   if asc(k)=27 then locate 20,120: ? "END" :end  ' if esc pressed then end
   pen on             'check current mouse and record to variables
   cmX=pen(10)        'current mouse X
   cmY=pen(11)        'current mouse Y 
   pen off            'done checking mouse x,y, now check in borders
   if cmX<highX and cmX>lowXY and cmY<highY and cmY>lowXY then centerX=cmX :centerY=cmY
   if centerX=oldX and centerY=oldY then goto doloop else oldX=centerX :oldY=centerY
wend
