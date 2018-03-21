'Voronoi spiral gem.bas for SmallBASIC 2016-08-19 MGA/B+

gem = 700
points = 36 * 13 ' 10 degrees needs 36 points for 1 circle
cy = gem\2
ga = 10
dim x(points), y(points), kl(points)
scale = .7
for n = 0 to points
   x(n) = cy + scale * n * cos(rad(n * ga))
   y(n) = cy + scale * n * sin(rad(n * ga))
   if x(n) < gem and x(n) > 0 and y(n) < gem and y(n) > 0 then 
     g = 127 - abs(cy - x(n)) * 127 \ cy  + 127 - abs(cy - y(n)) * 127 \ cy
   else 
     g = 0
   fi
   if x(n) < gem and x(n) > 0 then r = 255 - x(n) * 255 \ gem else r = 0
   if y(n) < gem and y(n) > 0 then b = y(n) * 255 \ gem else b = 0
   kl(n) = rgb(r, g, b)
   circle x(n), y(n), 1, 1, rgb(r, g, b) filled
next
'pause
V

sub V()
for xx = 0 to gem
   for yy = 0 to gem
      d = gem * gem + 1
      for i = 0 to points
         a = x(i) - xx : b = y(i) - yy
         q = a * a + b * b
         if q < d then d = q: kkl = i
      next
      pset xx, yy, kl(kkl)
   next y
next x
end
'pause