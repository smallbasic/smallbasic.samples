rem https://en.wikipedia.org/wiki/L-system
const fg_col = rgb(154, 170, 53)
const bg_col = rgb(238, 241, 221)

sub draw_turtle(script, x, y, stem, turn, angle)
  local a, stack, i, idx, x2, y2
  dim stack
  for i = 0 to len(script)
    select case mid(script, i, 1)
    case "F", "1", "0" ' draw forward from current position 
      a = rad(angle)
      x2 = x - (stem * cos(a))
      y2 = y - (stem * sin(a))
      line x, y, x2, y2, fg_col
      x = x2
      y = y2
    case "-" 'turn left
      angle -= turn 
    case "+" 'turn right
      angle += turn 
    case "[" ' push current position and angle
      stack << [x, y, angle] 
    case "]" ' pop saved position and angle
      idx = len(stack) - 1
      [x, y, angle] = stack(idx)
      delete stack, idx, 1
    end select
  next i
end

func create_lsystem(byref rules, byref variables, maxDepth, s, depth)
  local result, i, ch
  if (depth < maxDepth) then
    result = ""
    for i = 0 to len(s)
      ch = mid(s, i, 1)
      if (ch in variables) then
        result += rules(ch)
      else 
        result += ch
      end if
    next i
    result = create_lsystem(rules, variables, maxDepth, result, depth + 1)
  else
    result = s
  endif
  return result
end

sub show_plant
  local x = xmax / 2
  local y = ymax - 10
  local maxDepth = 6
  local rules = {"X" : "F+[[X]-X]-F[-FX]+X", "F" : "FF"}
  local variables = ["X", "F"]
  local angle = 35
  local stem = 4
  local script = create_lsystem(rules, variables, maxDepth, "X", 0)

  for j = 0 to 10
    cls
    draw_turtle(script, x, y, stem, 20, 90)
    showpage
    delay(100)
    cls
    draw_turtle(script, x, y, stem, 36, 90)
    showpage
    delay(100)
    cls
    draw_turtle(script, x, y, stem, 39, 90)
    showpage
    delay(100)
  next j
end

sub show_tree
  local x = xmax / 2
  local y = ymax
  local maxDepth = 6
  local rules = {"1":"11", "0":"1[-0]+0"}
  local variables = ["1", "0"]
  local angle = 70
  local stem = 4

  local script = create_lsystem(rules, variables, maxDepth, "0", 0)
  draw_turtle(script, x, y, stem, angle, 90)
end

color fg_col, bg_col
cls
'show_plant
show_tree
? "ok"
