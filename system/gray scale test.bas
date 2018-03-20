
'gray scale test.bas for SmallBASIC 0.12.2 [shian & B+=MGA] 2016-02-27

' gray() accepts the same values as Rgb(), i.e. 0..255:
Func gray(r, g, b)
  Local RGBF_SCALE = 1 / 255
  Local n
  
  'n = Sum(r * 0.30, g * 0.59, b * 0.11) ' gray=(30% red + 59% green + 11% blue)
  ' origninal yes on my screen blue is way too dark
  
  'n = Sum(r * 0.4, g * 0.4, b * 0.2)
  '1st experiment yes on my screen this is better but blue still too dark and red and purple  not enough
  
  'n = Sum(r * 0.3, g * 0.4, b * 0.3)
  '2nd experiment  well red green  blue are the same almost blue still doesn't look bright enough
  

  'n = Sum(r * 0.33, g * 0.34, b * 0.33)
  '3rd No green too dark
  
  'n = Sum(r * 0.25, g * 0.4, b * 0.35)
  '4th  more darker red lighter blue nice purple, green still too dark
  
  n = Sum(r * 0.15, g * 0.55, b * 0.3)
  '5th yeah here !!!! it kind of reverses red/blue in original
  
  n *= RGBF_SCALE ' scale 0..255 palette to 0..1 (for Rgbf)
  
  gray = Rgbf(n, n, n)
End

sub ball(x,y,cx)
   local r,sc,start, ym2
   ym2=ymax*.75
   sc=32/radi:start=int(32/sc)-2
   for r=start to 0 step -1
      if cx ="R" then 
         circle x,y,r,1,rgb(255-6*r*sc,0,0) filled
         circle x,ym2,r,1,gray(255-6*r*sc,0,0) filled
      elif cx="B"
         circle x,y,r,1,rgb(0,0,255-6*r*sc) filled
         circle x,ym2,r,1,gray(0,0,255-6*r*sc) filled
      elif cx="G"
         circle x,y,r,1,rgb(0,220-6*r*sc,0) filled
         circle x,ym2,r,1,gray(0,220-6*r*sc,0) filled
      elif cx="O"
         circle x,y,r,1,rgb(255-3*r*sc,150-3*r*sc,0) filled
         circle x,ym2,r,1,gray(255-3*r*sc,150-3*r*sc,0) filled
      elif cx="Y"
         circle x,y,r,1,rgb(255-4*r*sc,255-4*r*sc,0) filled
         circle x,ym2,r,1,gray(255-4*r*sc,255-4*r*sc,0) filled
      elif cx="P"
         circle x,y,r,1,rgb(255-7*r*sc,0,130-2*r*sc) filled
         circle x,ym2,r,1,gray(255-6*r*sc,0,0) filled
       fi
   next
end

radi=xmax/7/2-2
Print "An example gray-scale graphics:"
Print
For i = 1 to 6
  cc=mid("RGBYOP",i,1)
  bx=xmax/7*i
  ball bx,.25*ymax,cc
Next
Pause
