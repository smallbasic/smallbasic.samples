rem Welcome to SmallBASIC
rem see https://github.com/anvaka/atree
nmax = 19
xScale = 6
zScale = 2.5
yScale = 16
startFrom = 0
dz = 400

redSpiralShadow  = createSpiral(rgb(0x66,0,0), rgb(0x33,0,0), true, 1.01)
redSpiral        = createSpiral(rgb(0xff,0,0), rgb(0x44,0,0), true, 1)
cyanSpiralShadow = createSpiral(rgb(0,0x33,0), 0, false, 1.01)
cyanSpiral       = createSpiral(rgb(0,0xff,0xcc), rgb(0, 0x56, 0x33), false, 1)

while 1
  cls
  renderFrame() 
  if (startFrom > 1) then
    startFrom = 0
  else
    startFrom += 0.1
  endif
  showpage
  delay 30
wend

sub renderFrame()
  xScale *= 0.93
  forEachStep(redSpiralShadow)
  forEachStep(cyanSpiralShadow)
  xScale /= 0.93 
  forEachStep(redSpiral)
  forEachStep(cyanSpiral)
end

sub forEachStep(spiral)
  local i = -startFrom
  while i < nmax + startFrom
    if (i >= 0 && i <= nmax) then
      spiral.show(i)
    endif
    i += 0.08
  wend
end

func createSpiral(foreground, background, isLeft, yLocalScale)
  local spiral
  spiral.sign = iff(isLeft, -1, 1)
  spiral.yLocalScale = iff(LocalScale > 0, yLocalScale, 1)

  if isLeft == 0 then
    spiral.background = foreground 
    spiral.foreground = background 
  else
    spiral.background = background
    spiral.foreground = foreground
  endif

  func getX(i, z, sign)
    return sign * i * cos(i) * z * xScale + 255 
  end

  func getY(i, z)
    return i * z * yScale + 50 
  end
  
  sub show(i)
    local zoff = i * sin(i)
    local z = dz / (dz - self.sign * zoff * zScale)
    local x = getX(i, z, self.sign)
    local y = getY(i * self.yLocalScale, z)
    local c = iff(zoff + self.sign * PI / 4 < 0, self.foreground, self.background)
    line x, y, getX(i + 0.03, z, self.sign), getY((i + 0.01) * self.yLocalScale, z), c
  end

  spiral.show = @show
  return spiral
end

