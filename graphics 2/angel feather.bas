
'Angel feather.bas SmallBASIC 0.12.2 [B+=MGA] 2016-01-13 
'copy and modify PeterMaria's

sc= 0.5 : a = rnd*(99999999)/1000000000 : b = 0.933
t="Angel Feather"
zo="Zoom out"
zi="Zoom in"
color 12,0
pen on
while 1
  cls
  c = 2.0-2.0*a : x = 3.0 : a=0 : w=a*x+c*x*x/(1+x*x)
  for n=0 to 20000
                 'less than 0.0001 then x = rnd*(10)
    if abs(x)<0.0001 then x = rnd*(10)
            'less than .5 then rc=15 else rc=14
    if rnd<.5 then rc=15 else rc=14
    pset x*50*sc+xmax/2, y*50*sc+ymax/2,rc   '350
    z = x : x = b*y+w : u = x*x : w = a*x+c*u/(1+u) : y = w-z
  next
  at 50,50+txth(t):? t
  at 50,ymax-txth(zi)-10:? zi
  at xmax-txtw(zo)-50,50+txth(zo):? zo
  at xmax-txtw(t)-50,ymax-txth(t)-10:? t
  showpage
  delay 10
  if pen(3) then mx=pen(4) else mx=0
  if mx then
           'less than xmax/2 then sc = sc*1.4 else sc = sc*0.6
    if mx<xmax/2 then sc = sc*1.4 else sc = sc*0.6 
  end if
wend
