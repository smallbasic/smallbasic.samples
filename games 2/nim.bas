
?"Nim is a mathematical game of strategy in which two"
?"players take turns removing objects from distinct"
?"heaps. On each turn, a player must remove at least"
?"one object, and may remove any number of objects"
?"provided they all come from the same heap. The goal"
?"of the game is to be the player to remove the last"
?"object. (https://en.m.wikipedia.org/wiki/Nim)":pause
' Here the program I wrote back in 80's for ZX-Spectrum
' adapted for SB by jsalai, 2016-08-07 update
while 1
  cls
  p=1
  randomize
  input "NIM - No of heaps(3-9): ",n
  if n<3 or n>9 then stop
  ?"heaps coins"
  dim d()
  w=seq(1,15,15)
  m=len(w)
  while n
    x=int(rnd*m)
    d << w(x)
    m--
    n--
    swap w(m),w(x)
  wend
  sort d
  while 1
    locate 3,0
    i=0
    for x in d
      i++
      ?usg"###. ### ";i;x;
      ?string(x,"o");spc(15-x)
    next
    for i=i to 9 do ?spc(40)
    if p
      gosub 20
    else
      gosub 30
    fi
    if d(a)=0 then delete d,a
    if len(d)=0 then exit loop
    p=!p
  wend
  ?iff(p,"Player","Computer")+" wins! Press a key"
  pause
wend

20
  while 1
    k=0:a=0
    while a=0
      locate 15,0
      ?"Your move (0-hint, 99-end): "
      input "from heap:",a
      if a=0
        x=0
        for y in d do x=x xor y
        if x
          ?"the NIM (aka XOR) sum is ";x
          ?"Your goal is to make this sum 0."
        else
          ?"sorry, there is no hope anymore"
        fi
        pause:locate 17,0:?spc(40):?spc(40)
      fi
    wend
    if a=99 then stop
    if a and a<=len(d)
      a--
      while k=0
        locate 17,0
        input "       no:",k
        if k=99 then stop
        if k<1 or k>d(a) then k=0
      wend
      d(a)=d(a)-k
      exit loop
    fi
  wend
  locate a+3,0
  ?usg;a+1;d(a);
  if d(a) then ?string(d(a),"o");
  ?string(k,".")
  locate 18,0
  ?"Press a key":pause
  locate 15,0
  for i=1 to 4 do ?spc(40)
return

30
  x=0
  for y in d do x=x xor y
  if x
    a=0
    while 1
      m=x xor d(a)
      if m<=d(a)
        k=d(a)-m
        d(a)=m
        exit loop
      fi
      a++
    wend
  else
    a=int(rnd*len(d))
    k=int(rnd*d(a))+1
    d(a)=d(a)-k
  fi
  locate a+3,0
  ?usg;a+1;d(a);
  if d(a) then ?string(d(a),"o");
  ?string(k,".")
  locate 15,0
  ?"My move: from ";a+1;", ";k;" coins"
  ?"Press a key"
  pause
return
