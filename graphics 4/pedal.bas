
' Fun shapes from Pedal Eq.bas  SmallBASIC 0.12.8 [B+=MGA] 2017-03-30
' inpired by Andy Amaya's screen shots and reference to Superformula
' Here is some experimenting with the pedal equation

randomize timer

func fx(ra, mx, my, e) 
  'ra = radian angle
  'mx, my multipliers of angle
  'e exponent of pedal 
  'mx, my simple multipliers of the ra
  fx = ( ( cos(mx * ra) ) ^ e + ( sin(my * ra) ) ^ e) ^ .5
end

sub polarPlotter(x, y, ra, rdist, fillTF)
  'x, y think of as the origin of the plot
  'ra = radian angle
  'rdist = radial distance from the "origin"
  local l
  l.x1 = x + rdist * cos(ra)
  l.y1 = y + rdist * sin(ra)
  if fillTF then line x, y, l.x1, l.y1 else circle l.x1, l.y1, 1 filled
end

scale = 200 : fillTF = 0
for e = 2 to 10
  for m1 = 1 to 10
    for m2 = 1 to 10
      if m1 <> m2 then
        cls
        color 11
        'circle xmax/2, ymax/2, scale color 12  'for frame of reference red circle with radius 100
        locate 1, 1 : ? "e = ";e;"  m1 = ";m1;"  m2 = ";m2
        if rnd < .1 then
          r = rnd ^ 2 : g = rnd ^ 2 : b = rnd ^ 2
          for s = 200 to 0 step -1
            cc = rgb(127+127*sin(r+cn), 127+127*sin(g*cn), 127+127*sin(b*cn))
            cn += .1
            color cc
            for a = 0 to 2 * pi  step .001 
              d = fx(a, m1, m2, e) 
              polarPlotter xmax/2, ymax/2, a, s * d, 0
            next
            showpage
          next
        else
          for a = 0 to 2 * pi  step .001 
            d = fx(a, m1, m2, e) 
            polarPlotter xmax/2, ymax/2, a, scale * d, fillTF
          next
          showpage
        end if
        delay 200
      end if
    next
  next  
next