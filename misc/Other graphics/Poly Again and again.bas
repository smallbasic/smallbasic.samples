'Poly and poly again.bas smallBASIC 2015-06-28 MGA/B+
ws=720
d=2
color 15,0
cx=ws/2:cy=ws/2
repeat
cls
d+=1
side=cy-20
dopoly cx,cy,side
locate 0,0:print d+" poly"
pause 3
until d=11
locate 0,0:print "finished" 
end

sub dopoly(xc,yc,level)
   local dm,i,t,a,b,c,sq,x,y, colr
   sq=level/2
   if sq<3+1.3*d then
      exit
   else
      if sq>100 then
         colr=rgb(0,0,255)
      elseif sq>50
         colr=rgb(255,255,0)
      elseif sq>20
         colr=rgb(0,255,255)
      elseif sq>10
         colr=rgb(255,0,0)
      elseif sq>5
         colr=rgb(0,120,0)
      else 
         colr=rgb(0,0,60)
      endif
      dim x(d)
      dim y(d)
      dm=d-1
      for i=0 to dm
         t=cos(i*2*pi/d)
         x(i)=xc+t*sq
         t=sin(i*2*pi/d)
         y(i)=yc+t*sq
      next
      for a=0 to dm
         b=a+1
         if b>dm then b=0
         line x(a),y(a),x(b),y(b),colr
         dopoly x(a),y(a),sq
      next
   endif
end sub