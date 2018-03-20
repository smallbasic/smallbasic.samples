
'
' SmallBASIC,0.12.8 Android Sat, 22 Oct 2016 [jsalai49]
'            >> FileManager.bas <<
' adapted (ie. stolen & exended) from [main.bas] by me.
' Optimized for 600*636 w-s-kb (600*1024 wo-kb) tablet.
' Works fine for me on Android and Win
'
' Warning: Not heavily tested. If you like it, use it &
' adapt it to meet your needs. No waranties, anyway!
'
' Tip-1: if you have selected a file, AND a directory
'   is in the edit field, the file-operations affect
'   the "directory/file" relative pathname construct.
'
' Tip-2: I made /storage/sdcard0/external_sdcard/sb12/
'   directory as my "home directory" on Android.
'   If set, it is NOT allowed to "walk" outside "home".
'   If you set a "home directory", put this program
'   there, and edit next line accordingly.
const _hd="/sb12/" '.../sb12/.../.../; _hd="//" no_home
const _rp=1 '0-full path  1-rel path if _hd above set
const _ch=txth("Q")
const _ls=2+_ch
const _mg=-txtw(" ")
const deleteId = "_/del"
const newId = "_/new"
const saveasId = "_/sav"
const renameId = "_/ren"
const viewId = "_/vie"
const rmdirId = "_/rmd"
const mkdirId = "_/mkd"
const chdirId = "_/chd"
const goupId = "_/upd"
const closeId = "_/ext"
func mk_men(v,l,x)
  local b
  b.x=x
  b.y=ypos*_ch
  b.value=v
  b.label=l
  b.color=15
  b.nofocus=1
  b.backgroundColor=0
  b.type="link"
  mk_men=b
end
sub gt_fil(p,@b,@d)
  local c,e
  c=files(p)
  for e in c
    if isdir(e)
      d << e+"/"
    elif right(e,4)=".bas"
      b << e
    fi
  next
  sort b use fn_cmp(lower(x),lower(y))
  sort d use fn_cmp(lower(x),lower(y))
end
func fn_cmp(x,y)
  fn_cmp=if(x=y,0,if(x>y,1,-1))
end
sub mk_ui
  local b,z
  p=cwd
  cls
  f.inputs << mk_men(deleteId,"[Del",0)
  f.inputs << mk_men(newId,"New",_mg)
  f.inputs << mk_men(saveasId,"SvAs",_mg)
  f.inputs << mk_men(renameId,"Ren",_mg)
  f.inputs << mk_men(viewId,"View]",_mg)
  f.inputs << mk_men(rmdirId,"[RmDir",_mg*2)
  f.inputs << mk_men(mkdirId,"MkDir",_mg)
  f.inputs << mk_men(chdirId,"ChDir",_mg)
  f.inputs << mk_men(goupId,"UpDir]",_mg)
  f.inputs << mk_men(closeId,"[Exit]",_mg*2)
  i_l=len(f.inputs)
  b.color=14
  b.resizable=1
  b.type="label"
  b.x=0
  b.y=_ls
  f.inputs << b
  i_e=len(f.inputs)
  b.backgroundcolor=1
  b.color=15
  b.x=0.1*xmax
  b.y=2*_ls
  b.width=0.8*xmax
  b.type="text"
  f.inputs << b
  i_f=len(f.inputs)
  b.backgroundcolor=0
  b.type="list"
  b.nofocus=1
  b.y=3*_ls
  b.height=ymax-b.y
  b.x=10
  b.color=11
  b.width=xmax\2
  f.inputs << b
  i_d=len(f.inputs)
  b.color=13
  b.width=xmax*0.4
  b.x=xmax*0.55
  f.inputs << b
  f.focus=i_e
  f=form(f)
end
sub rl_lst(i)
  local b_lst,d_lst,l,q,j
  f.refresh(1)
  dim b_lst,d_lst
  gt_fil(p,b_lst,d_lst)
  l=len(b_lst)
  f.inputs(i_f).value=b_lst
'  if !l
    s=""
    i=-1
'  else
'    if i>=l
'      i=l-1
'    fi
'    s=b_lst(i)
'  fi
  f.inputs(i_d).value=d_lst
  f.inputs(i_d).selectedIndex=-1
  f.inputs(i_f).selectedIndex=-1 'i
  f.inputs(i_e).value="" 's
  if _rp
    q=right(p,len(p)-instr(p,_hd))
    f.inputs(i_l).label=q
  else
    f.inputs(i_l).label=p
  fi
  f.refresh(0)
  f.close()
  f=form(f)
end
sub rm_Dir
  local n,b
  n=f.inputs(i_e).value
  if !(exist(n) && isdir(n))
    exit sub
  fi
  b=files(n)
  if len(b)
    w.alert(n+" - Dir not empy!")
    exit sub
  fi
  w.ask("Remove Dir  ["+n+"] ?")
  if w.answer=0
    rmdir n
    rl_lst(0)
  fi
end
sub mk_Dir
  local n
  n=f.inputs(i_e).value
  if n=""
    exit sub
  fi
  if lower(right(n,4))=".bas"
    n=leftoflast(n,".bas")+"/"
  fi
  if exist(n)
    w.alert(n+" - Dir exist")
    exit sub
  fi
  w.ask("Create Dir  ["+n+"] ?")
  if w.answer=0
    mkdir n
    rl_lst(0)
  fi
end
sub ch_Dir
  n=f.inputs(i_e).value
  if isdir(n) and left(n)!="."
    chdir n
    p=cwd
    rl_lst(0)
  fi
end
sub up_Dir
  p=cwd
  if instr(p,_hd)!=len(p)-len(_hd)+1
    chdir ".."
    p=cwd
    rl_lst(0)
  fi
end
sub deleteFile
  n=f.inputs(i_e).value
  if n=""
    exit sub
  fi
  if exist(n) && isdir(n)
    if right(n)!="/"
      n+="/"
    fi
    n=n+s
  fi
  if !exist(n)
    w.alert(n+" - File not exist")
    exit sub
  fi
  w.ask("Delete file:  ["+n+"] ?")
  if w.answer=0
    kill n
    rl_lst(0)
  fi
end
sub newFile(x)
  local i,t,n,b
  n=f.inputs(i_e).value
  i=f.inputs(i_f).selectedIndex
  if n="" or s=n or (x && !exist(s))
    exit sub
  fi
  if exist(n) && isdir(n)
    if right(n)!="/"
      n+="/"
    fi
    n=n+s
  fi
  if lower(right(n,4))!=".bas"
    n+=".bas"
  fi
  if exist(n)
    w.alert(n+" - File exist")
    exit sub
  fi
  if x=1
    w.ask("Save:  ["+s+"]  as:  ["+n+"] ?")
    if w.answer=0
      tload s,t
      tsave n,t
      rl_lst(i)
    fi
  elif x=2
    w.ask("Rename/Move:  ["+s+"]  to:  ["+n+"] ?")
    if w.answer=0
      rename s,n
      rl_lst(i)
    fi
  else
    w.ask("Create empty file:  ["+n+"] ?")
    if w.answer=0
      dim t
      t << "","'SmallBASIC,"+sbver+", [jsalai49]"
      tsave n,t
      rl_lst(i)
    fi
  fi
end
sub viewFile
  local d,i,j,g,b
  n=f.inputs(i_e).value
  if n=""
    exit sub
  fi
  if exist(n) && isdir(n)
    if right(n)!="/"
      n+="/"
    fi
    n=n+s
  fi
  if n="" or !exist(n)
    w.alert(n+" - File not exist")
    exit sub
  fi
  i=f.inputs(i_f).selectedIndex
  tload n,d
  w.graphicsScreen2()
  cls
  color 11,0
  for j in d
    ?j
  next
  if j!=""
    ?
  fi
  b.label="[Close "+n+"]"
  b.color=14
  b.y=-1
  b.x=(xmax-txtw(b.label))\2
  b.type="link"
  b.backgroundColor=0
  g.inputs << b
  g=form(g):?
  g.doEvents()
  w.graphicsScreen1()
  rl_lst(i)
end
sub upd_ed
  if len(f.value)>0
    f.inputs(i_e).value=f.value
    f.refresh(0)
    if isfile(f.value)
      s=f.value
    elif isdir(f.value)
      z=f.value
    fi
  fi
end
 
w=window()
w.showKeypad()
mk_ui
rl_lst(0)
while 1
  f.doEvents()
  select case f.value
  case deleteId
    deleteFile
  case newId
    newFile(0)
  case saveasId
    newFile(1)
  case renameId
    newFile(2)
  case viewId
    viewFile
  case rmdirId
    rm_Dir
  case mkdirId
    mk_Dir
  case chdirId
    ch_Dir
  case goupId
    up_Dir
  case closeId
    cls
    exit loop
  case else
    upd_ed
  end select
  f.value=""
wend
