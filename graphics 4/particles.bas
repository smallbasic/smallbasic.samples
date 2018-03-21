' more particles.bas  SmallBASIC 0.12.8 [B+=MGA] 2016-11-18
' from: more particles.sdlbas [B+=MGA] 2016-11-18
' attempt to simulate alpha effect

func rand(n1, n2) 
  if n1 > n2 then hi = n1 : lo = n2 else hi = n2 : lo = n1
  rand = (rnd * (hi - lo + 1)) \ 1 + lo 
end 

def rdir = iff(rnd < .5, -1, 1)

numPoints = 100

dim  vx(numPoints), vy(numPoints), clr(numPoints), life(numPoints), lifeTime(numPoints)

wantColor = 1  'colorize on/off, 1 or 0

for i = 0 to numPoints
  initPoint(i)
next
while 1
  cls
  for p = 0 to numPoints
    life(p) += 1
    if life(p) = lifeTime(p) then
      initPoint(p)
    else
      'redraw the whole arc of particle path
      x0 = xmax/2 : y0 = .35 *  ymax : drop = vy(p)
      for i = 0 to life(p)
        if wantColor then
          select case clr(p)
          case 0
            r = 1: g = 0 : b = 0
          case 1
            r =1 : g = 1 : b = 1
          case 2
            r =0 : g = 0 : b = 1
          case 3
            r = 0 : g = .7 : b = 0
          case 4
            r= 1: g = 1 : b = 0
          case 5
            r = 1 : g = 0 : b = 1
          case 6
            r = 1 : g = .6 : b = 0
          end select
          if r = 0 then
            r = 3 * (life(p) - i)
          else
            r = i/life(p) * 255 * r
          end if
          if g = 0 then
            g = 3 * (life(p) - i)
          else
            g = i/life(p) * 255 * g
          end if
          if b = 0 then
            b = 3 * (life(p) -1)
          else
            b = i/life(p) * 255 * b
          end if
          color rgb(r, g, b)
        else
          m = i/life(p) * 255
          color rgb(m, m, m)
        end if
        xnext = x0 + vx(p)
        drop += .1
        ynext = y0 + drop
        radius = i/life(p) * 8
        circle xnext, ynext, radius filled
        x0 = xnext
        y0 = ynext
      next
    end if
  next
  showpage
wend

sub initPoint(p)
  vx(p) = rnd * 7  * rdir
  vy(p) = rnd * 7  * rdir
  clr(p) = rand(0, 6)
  life(p) = 0
  lifeTime(p) = rand(30, 70)
end