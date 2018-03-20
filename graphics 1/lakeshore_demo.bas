
' A small water waving/flickering program 
' For SB(fltk) 2 Jan 2009 , by Keijo Koskinen
' You can download lakeshore1.jpg from:
'   http://users.csolve.net/~keiko/smallbasic/lakeshore1.jpg
' When lakeshore1.jpg appears to screen, 
'  ..right clic it and choose save as
'  ..to your bas_home directory

' *** load image ***
   'img= env("C:\sb_fltk_97\FLTK_0.9.7\Bas-Home")+"lakeshore1.jpg"
   ' or
 img= env("Bas-Home")+"lakeshore1.jpg"
  if (!exist(img)) then
    ? "Lakeshore1.jpg does not exist "
  else
    open img for input as #1
       w = imagew(#1,0)
       h = imageh(#1,0)
       x = 1
       y = 1
       image #1,0, x,y,0,0,w,h
    close #1
  fi

' This image size: 1,1-400,270
' Water area: 1,190 - 400,270  that means wh=270-190=80 ww=400-1=399
   wh=270-190 : ww=400-1
 dim t1(91,401)    ' store water area > t1(), make it slighly bigger 
    for ii=191 to 270
      for iii=1 to 400
        t1(ii-190,iii)=point(iii,ii)
      next
    next
 
' *** Let's wave it ***
label  waveit     
   mo=4   '  height of strip, bigger > waves, smaller > flickering
 if bb < mo then bb=wh-6
    colp=rnd * (mo+4)  'need to random place for to create clickering 
    aa=0
  for aa1=1 to (mo-2)
     aa=bb-aa1+190
   for aaa=1 to 400
      pset aaa,aa,t1(aa+colp-190,aaa)
   next
  next
     bb=bb-(mo+1)  ' next strip place
goto waveit
