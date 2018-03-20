
'fireworks 3.bas SmallBASIC 0.12.2 [B+=MGA] 2015-05-09 
'fireworks 2.bas 2016-05-05 now with Gravity, Newtonian bounce, smoke debris
'fireworks 3.bas try with map variables make bursts around a central point


flare_max = 300 : debris_max = 5000 : debris_stack = 0
dim flare(flare_max)
dim debris(debris_max)

sub NewDebris(i)
  local c
  debris(i).x = rnd * xmax
  debris(i).y = rnd * ymax
  c = rnd * 255
  debris(i).c = rgb(c, c, c)
end

while 1
   rnd_cycle = rnd * 30 
   loop_count = 0 
   burst.x = .75 * xmax * rnd + .125 * xmax
   burst.y = .5 * ymax * rnd +.125 * ymax
   repeat
      cls
      'color 14 : locate 0,0: ? debris_stack; " Debris" 'debug line
      for i=1 to 20   'new burst using random old flames to sim burnout
         nxt = rnd * flare_max + 1
         angle = rnd * 2 * pi
         flare(nxt).x = burst.x + rnd * 5 * cos(angle)
         flare(nxt).y = burst.y + rnd * 5 * sin(angle)
         angle = rnd * 2 * pi
         flare(nxt).dx = rnd * 15 * cos(angle)
         flare(nxt).dy = rnd * 15 * sin(angle)
         rc = int(rnd * 3)
         if rc = 0 then
            'flare(nxt).c = 12 'patriotic theme
            flare(nxt).c = rgb(255, rnd * 255, 0)
         elseif rc = 1
            'flare(nxt).c = 9 'patriotic theme
            flare(nxt).c = rgb(100 + rnd * 155, 100 + rnd * 155, 220)
         else
            flare(nxt).c = 15
         endif
      next
      for i = 0 to flare_max
         if flare(i).dy then 'while still moving vertically
            line flare(i).x, flare(i).y step flare(i).dx, flare(i).dy, rgb(98, 98, 98)
            circle step flare(i).dx, flare(i).dy, 1, 1, flare(i).c filled
            flare(i).x += flare(i).dx
            flare(i).y += flare(i).dy
            flare(i).dy += .4  'add  gravity
            flare(i).dx *= .99 'add some air resistance
            if flare(i).x < 0 or flare(i).x > xmax then flare(i).dy = 0  'outside of screen
            'add some spark bouncing here
            if flare(i).y > ymax then
              if abs(flare(i).dy) > .5 then 
                flare(i).y = ymax : flare(i).dy *= -.25 
              else 
                flare(i).dy = 0
              fi
            fi 
          fi
      next
      for i = 0 to debris_stack
        pset debris(i).x, debris(i).y, debris(i).c
        debris(i).x += rnd * 3 - 1.5
        debris(i).y += rnd * 3.5 - 1.5
        if debris(i).x < 0 or debris(i).y < 0 or debris(i).x > xmax or debris(i).y > ymax then NewDebris(i)
      next
      showpage
      delay 2
      loop_count += 1
    until loop_count > rnd_cycle
    if debris_stack < debris_max then 
      for i = 1 to 20
        NewDebris i + debris_stack
      next
      debris_stack += 20
    fi
wend
