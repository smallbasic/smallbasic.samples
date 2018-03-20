
''' UFO Ver 2
'' ufo.bas
'' Shigeyuki Seko
'' 15/02/2001

hi=0
label top
cls
randomize ticks
rect 10,115,150,150
rect 150,40,155,95
at 148,100:print chr$(143)
for pp=0 to 30
	xx=int(rnd*150)
	yy=int(rnd*100)
	pset xx,yy
next pp
x=37:y=11
sc=0:sca=0
posi=70:lastt=0:gg=0
last=30:alast=0:acount=0:aposi=0
x=10:dirx=1
wt=70
stage=1
hitcount=0

at posi,100:print " =''= "
at 130,y:print "           "
gosub dataout
gosub stageup
while 1
	x=x+dirx
	lastt=lastt+1
	gg=int(lastt/10)
	line 150,40+gg,155,40+gg
	if acount=0
		rd=int(rnd*500)
		if rd=0
			acount=88
			aposi=int(rnd*120)+20
		fi
		else:gosub addlist
	fi
	if stage>=2
		if stage=2
			rd=int(rnd*50)
			else 
				rd=int(rnd*10)
		fi
		if rd=0
			dirx=dirx*-1
		fi
	fi
	if x<10 :dirx=1
		elseif x>130 :dirx=-1
	fi
	at x,y:print " -o- "
	in$=inkey$
	if len(in$)>1
		n= asc(right(in$,1))
		if (n=4)&(posi>10)
			posi=posi-2
		elseif (n=5)&(posi<130)
			posi=posi+2
		elseif n=2
			gosub beem
		fi
		at posi,101:print " =''= "
	fi
	if (last<=0) or (gg>=54)
		goto endmess
	fi
wend


''--- sub routine --

label ggcls
lastt=0
gg=0
rect 150,40,155,95
for n=151 to 154
	line n,41,n,94 color 15
next n
return

label addlist
acount=acount-1
alast=int(acount/20)+1
if acount=0
	at aposi,40
	print "   "
	aposi =0
	else
		at aposi,40
		print alast
fi
return

label beem
line  posi+8,98,posi+8,5 color 7
last=last-1
gosub dataout
line  posi+8,98,posi+8,5 color 15
if (x<posi+3) & (x>posi-3)
	gosub hitani
	gosub dataout
fi
if (aposi<posi+9) & (aposi>posi+4)
	gosub hitadd
	gosub dataout
fi
return

label hitani
sound 1000,10
wt=50
gosub wait
at x,y:print " -*- "
sound 900,10
gosub wait
at x-5,y:print " -***-"
sound 700,10
gosub wait
at x-5,y:print "                   "
sound 300,10
sca=((int(rnd*10))*10)+10
at x-5,y:print "<";sca;">"
wt=300
gosub wait
at x-5,y:print "                   "
sc=sc+sca
hitcount=hitcount+1
if hitcount >= 10
	stage=stage+1
	gosub stageup
	hitcount=0
fi
x=0
gosub ggcls
return

label hitadd
sound 300,10
wt=50
gosub wait
at aposi,40:print "-*-"
sound 500,10
gosub wait
at aposi-1,40:print "         "
sound 900,10
last=last+alast
acount=0
aposi=0
return

label stageup
wt=5
for i=1 to 60 step 2
	at i,70:print " STAGE-";stage
	sound 5000,1
next i
wt=800
if stage>=2
	at 55,80:print "BONUS=300"
	sc=sc+300
	last=last+5
fi
gosub wait
gosub dataout
at 60,70:print "                             "
at 55,80:print "                             "
return

label wait
for w=0 to wt:next n
return

label dataout
at 20,130:print "High Score = ";hi
at 20,140:print "Last =            "
at 50,140:print last
at 80,140:print "Score = ";sc
return

label endmess
restore messdata
for i=0 to 8
	read m
	at 20+(i*10),50
	sound 1000,30
	print chr$(m)
	wt=70
	gosub wait
next i
if sc>hi : hi=sc : fi
at 20,70
print "Schedule button --- Replay"
at 20,80
print "Address button  --- End"
while 1
	c$=inkey$
	if c$<>""
		cc= asc(right(c$,1))
		if cc=3 :goto top
			elseif cc=4: end
		fi
	fi
wend
end

label messdata
data 71,65,77,69,95,79,86,69,82
'
