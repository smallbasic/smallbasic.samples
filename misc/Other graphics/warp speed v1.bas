'warp speed v1.bas SmallBASIC (not MS) 2015-04-03 B+
'speed up = pg up    slow down = pg dn  quit = esc
ym=ymax:yc=int(ym/2):howManyStars=200:mStars=60:a=5 
Dim starfield(1 to howManyStars, 1 to 2)
'setup field
for i=1 to howManyStars
  starfield(i,1)=int(ym*rnd):starfield(i,2)=int(ym*rnd)
next
'setup stars that will be moving
Dim star(1 to mStars,1 to 3)
for i=1 to mStars
  star(i,1)=int(ym*rnd)
  star(i,2)=int(ym*rnd)
  star(i,3)=rndStarColr()
next
color 0,15:cls
rect 1,1,ym,ym,0 filled 'draws our black space

'========================================end of setup start run
while 1
drawfield()
k=inkey
if len(k)=2 then
  if asc(right(k,1))=1 then 'pgup move stars farther each round
    if a<20 then a=a+1  
  elif asc(right(k,1))=2 
    if a>2 then a=a-1 'pgdown move stars less far each round
  fi
else
  if asc(k)=27 then end
fi    
wend
end '============================================= the end
func radius(xis,yis)
  local distance,ris
  distance=((yc-xis)^2+(yc-yis)^2)^.5
  if distance<.04*yc then
    ris=0
  else
    ris=distance*.009
  fi
  radius=ris
end     
func rndStarColr()
  local c
  c=rnd
  if c<.70 then
    rndStarColr=15
  elif c<.87
    rndStarColr=rgb(255,255,0)
  elif c<.90
    rndStarColr=rgb(255,200,0)
  elif c<.93
    rndStarColr=rgb(0,255,200)
  elif c<.96
    rndStarColr=rgb(200,255,200)
  else
    rndStarColr=rgb(200,200,0)
  fi
end
sub drawfield()
  local i,id,distance
  for i=1 to howManyStars-25
    if i mod 2 then fieldStarColr=15 else fieldStarColr=7
    pset starfield(i,1),starfield(i,2),fieldStarColr
  next
  for i=howManyStars-25+1 to howManyStars
    if i mod 2 then fieldStarColr=15 else fieldStarColr=7
    circle starfield(i,1),starfield(i,2),.5,1,fieldStarColr filled
  next
  'above is the field next are the stars that move
  for i=1 to mStars
    xis=star(i,1):yis=star(i,2):cis=star(i,3)
    ris=radius(xis,yis)
    'blackout old
    circle xis,yis,ris,1,0 filled
    'next calc next x,y draw next star
    if ris then
      if yc-xis<>0 then
        Radangle=atan(abs((yc-yis)/(yc-xis)))
        if yc-xis>0 then star(i,1)=xis+Int(a*cos(radangle)) else star(i,1)=xis-Int(a*cos(radangle))
        if yc-yis>0 then star(i,2)=yis+Int(a*sin(radangle)) else star(i,2)=yis-Int(a*sin(radangle))
      else
        'star(i,1) is fine sin=1 cos=0
        if yc-yis>0 then star(i,2)=yis+a else star(i,2)=yis-a
      fi 
    else 'time for a new star for i
      coin=int(4*rnd):place=int(rnd*ym)+1
      select coin
        case 0 : star(i,1)=place : star(i,2)=7
        case 1 : star(i,1)=ym-7 : star(i,2)=place
        case 2 : star(i,1)=place : star(i,2)=ym-7
        case 3 : star(i,1)=7 : star(i,2)=place
      end select    
      star(i,3)=rndStarColr()
    fi
    xis=star(i,1):yis=star(i,2):cis=star(i,3):ris=radius(xis,yis)
    circle xis,yis,ris,1,cis filled 
  next
end