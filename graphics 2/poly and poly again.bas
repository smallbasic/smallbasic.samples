

'Poly and poly again v2.bas for SmallBASIC 2015-07-10 MGA/B+
ws=740 : d=2
color 14,0
repeat
   cls
   d+=1
   dopoly (ws-10)/2,(ws-10)/2,1
   locate 0,0:print " "+d+" poly and poly again..."
   print " spacebar to continue"
   showpage
   k="":while len(k)=0:k=inkey:wend
   if k<>" " then quit=1
until d=15 or quit
rect 0,0,300,60,0 filled
locate 0,0:print "finished..." 
end

sub dopoly(xc,yc,calln)
   local dm,i,t,a,b,sz,x,y, colr
   sz=(ws-10)/(2^(calln+1))
   if sz<3+d then
      exit
   elseif calln>4 and d>6
      exit
   elseif calln>3 and d>10
      exit
   else
      if calln=1 then
         colr=rgb(255,255,255)
      elseif calln=2
         colr=rgb(220,220,0)
      elseif calln=3
         colr=rgb(0,0,196)
      elseif calln=4
         colr=rgb(0,128,0)
      elseif calln=5
         colr=rgb(255,0,0)
      else 
         colr=rgb(15*sz,15*sz,15*sz)
      endif
      dim x(d)
      dim y(d)
      dm=d-1
      for i=0 to dm
         t=cos(i*2*pi/d)
         x(i)=xc+t*sz
         t=sin(i*2*pi/d)
         y(i)=yc+t*sz
      next
      for a=0 to dm
         b=a+1
         if b>dm then b=0
         line x(a),y(a),x(b),y(b),colr
         dopoly x(a),y(a),calln+1
      next
   endif
end sub
