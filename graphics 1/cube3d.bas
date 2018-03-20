
''' 3d.bas
'' 07/06/2000

d=100:t=.7:p=1.3
gosub redraw
repeat
  k=inkey$
  if k="1":t=t+.1:gosub redraw
  elif k="2":t=t-.1:gosub redraw
  elif k="3":p=p+.1:gosub redraw
  elif k="4":p=p-.1:gosub redraw
  elif k="5":d=d+10:gosub redraw
  elif k="6":d=d-10:gosub redraw
  endif
until k="q"
end

''
''  sxediasmos olvn v
''
label redraw
cls
? "1/2=+-θ, 3/4=+-φ, 5/6=+-d, q=quit"

st=sin(t):ct=cos(t)
sp=sin(p):cp=cos(p)

restore cubeData
gosub calcPt
pset sx,sy
for i=1 to 15
  gosub calcPt
  line sx,sy
next
return

''
''  ypologismos sx,sy (3d->2d)
''
label calcPt
read x,y,z
xe=-x*st+y*ct
ye=-x*ct*cp-y*st*cp+z*sp
ze=-x*sp*ct-y*st*sp-z*cp+4
sx=d*xe/ze+80
sy=d*ye/ze+80
return

''
''  o kybos (lineto)
''
label cubeData
data 1,1,1,  1,-1,1,  -1,-1,1
data -1,1,1,  1,1,1,  1,1,-1
data 1,-1,-1,  -1,-1,-1,  -1,1,-1
data 1,1,-1,  1,-1,1,  1,-1,-1
data -1,-1,1,  -1,-1,-1,  -1,1,1
data -1,1,-1
'
