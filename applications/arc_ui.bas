'arc from top-left to bottom-left
points=files("*")
th = txth("Q") 
x_left = 10
y_top = th
y_bottom = ymax - th * 2.5
y_step = (y_bottom - y_top) / th
y_step = th
r = xmax/10
n_points = int((y_bottom - y_top) / th)
offs = 7
mid_p = int(n_points / 2)
gray_col = rgb(64,64,64)

for n = 0 to n_points - 1
  x = x_left + r * sin(n * pi / n_points)
  y = y_top + (n * y_step)
  if (n = mid_p) then
    color 15
  else
    color gray_col
  endif
  if offs+n < len(points) then
    at x,y:print points[offs +n]
  endif
next n
