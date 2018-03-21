#https://github.com/s-macke/VoxelSpace
map = {
  height:[]
  col:[]
}

camera = {
 x:        512, rem x position on the map
 y:        800, rem y position on the map
 height:   178, rem height of the camera
 angle:     10, rem direction of the camera
 horizon:   10, rem horizon position (look up and down)
 distance: 1200  rem distance of map
}

sub init
  local i,x,y,datac,datah
  local sz = 1024 * 1024

  map.col = seq(-0xFF007050, -0xFF007050, sz)
  map.height = seq(0, 0, sz)
  
  local imageDir = "resources/"
  i = image(imageDir + "C1W.png")
  i.save(datac)
  i = image(imageDir + "D1.png")
  i.save(datah)

  local k = 0
  for y = 0 to 1023
    for x = 0 to 1023
      map.height[k] = -datah[y,x] band 0xff
      map.col[k] = datac[y,x] 
      k++
    next j
  next i
 
end

sub render
  local screenwidth = xmax
  local sinang = sin(camera.angle)
  local cosang = cos(camera.angle)
  local hiddeny = seq(0, 0, screenwidth)
  local i,dz,z,plx,ply,prx,pry,dx,dy
  local mapoffset,y1,y2,invz

  for i = 0 to xmax - 1
    hiddeny[i] = ymax
  next i

  dz = 1
  color 0,rgb(135, 205,250)
  cls
  #  Draw from front to back
  for z = 55 to camera.distance step dz
    #  90 degree field of view
    plx =  -cosang * z - sinang * z
    ply =   sinang * z - cosang * z
    prx =   cosang * z - sinang * z
    pry =  -sinang * z - cosang * z
    dx  = (prx - plx) / screenwidth
    dy  = (pry - ply) / screenwidth
    plx += camera.x
    ply += camera.y
    invz = 1 / z * 240.0
    for i = 0 to screenwidth - 1
      mapoffset = ((floor(ply) band 1023) lshift 10) + (floor(plx) band 1023)
      y1 = (camera.height - map.height[mapoffset]) * invz + camera.horizon
      y2 = hiddeny[i]
      if (y1 <= y2) then
        line i, y1, i, y2, map.col[mapoffset]
        hiddeny[i] = y1        
      endif
      plx += dx
      ply += dy
    next i
    dz+=.3
  next z
  showpage
end

sub moveLeft
  camera.angle += .1
  render
end

sub moveRight
  camera.angle -= .1
  render
end

sub moveBack
  camera.x += 20 * sin(camera.angle)
  camera.y += 20 * cos(camera.angle)
  render
end

sub moveForward
  camera.x -= 20 * sin(camera.angle)
  camera.y -= 20 * cos(camera.angle)
  render
end

init
render

while 1
  select case inkey
  case "a"
    moveLeft
  case "f"
    moveRight
  case "w"
    moveForward
  case "s"
    moveBack
  end select
wend
