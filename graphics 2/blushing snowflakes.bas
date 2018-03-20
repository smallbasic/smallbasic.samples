
REM blushing snowflakes.bas 2016-03-01 SmallBASIC 0.12.0 [B+=MGA]
'modified and colored from
'a t and t line-art  for sdlbasic  (Windows, Unix etc etc)
'  S Shaw, 2013 http://shawweb.myzen.co.uk/stephen/sdlbasic.htm
'modified with rosey

xoff=xmax/2  '< modified to fit any screen V
yoff=ymax/2
sq=min(xmax,ymax)
maxdist=(xoff^2+yoff^2)^.5  '< for color modification
scale=sq/2
n=4 : d=43 : flag=0
while 1
  color rgb(150,0,0),rgb(0,128,0):cls
  for rosey=.01 to 1.41 step .2
    a=0 : a=a+d 
    newx=xoff 
    while a>0.00001
      a=a+d
      a=(a/360-int(a/360))*360 : a=int(a+0.0001)
      x=n*a : x=(x/360-int(x/360))*6.283185307
      r=sin(x)
      t=a*0.0174532925
      oldx=newx : oldy=newy
      newx=R*sin(t)*scale+xoff : newy=r*cos(t)*scale+yoff
      'do not plot first line to reduce asymetry
      flag=flag+1
      if flag>1 then
        leng=((oldy-newy)^2+(oldx-newx)^2)^.5  'main modification VVVVVVVVV
        if leng<>0 then
          dx = (newx-oldx)/leng
          dy = (newy-oldy)/leng
          for i=0 to leng
            cc=(((oldx+dx*i-xoff)^2+(oldy+dy*i-yoff)^2)^.5)/maxdist
            color rgbf(max(1-cc/rosey,0),min(1,cc/rosey),min(1,cc/rosey))
            circle oldx+dx*i,oldy+dy*i,2
          next                                 'main modification ^^^^^^^^^  
        end if
      end if
    wend
    color 0,rgb(0,128,0)
    at 0,0:? "n=";n;" d=";d;" rosey=";rosey
    showpage
    delay 10
  next
  n+=2:if n>359 then n=1  '< not random V took out RANDOMIZE
  d+=1:if d>359 then d=1
  newx=xoff : newy=yoff : flag=0
  delay 200 'pause between flakes!
wend
