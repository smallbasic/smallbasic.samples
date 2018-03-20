
'''AnBall 1.0.bas
''By Vong, Sy Sech (An)
''01-08-2003

LABEL start

''=====Begin screen======

CLS
AT XMAX/3,1:? CAT(3);" AnBall 1.0 "; CAT(0) ''ιcrire message
? ""

IF TXTW(s)>4 AND TXTH(s)>8
? "USE YOUR MOUSE OR YOUR PEN TO CONTROL THE BAR. PRESS [ENTER] TO START."
? ""
? "Utilisez le souris ou le stylet pour contrτler la barre. Appuyez [ENTER] pour commencer."
ELSE
? "USE YOUR MOUSE OR YOUR PEN"
? "TO CONTROL THE BAR."
? "PRESS [ENTER] TO START."
? ""
? "Utilisez le souris ou le stylet"
? "pour contrτler la barre."
? "Appuyez [ENTER] pour commencer."
FI
? ""
? "[q] + [ENTER] = QUIT - Quitter"
? ""
? "Maximun: "+XMAX+" X "+YMAX+" Pixels"
? ""
INPUT "YOUR CHOICE - Votre choix : " ,choix
IF choix="q" OR choix="Q" THEN : GOTO quit
FI

''=====Interface======

CLS ''clear screen
RANDOMIZE TICKS ''set for sys. clock
p=0:l=5:btn=0 ''point,life,btn pause
scYmax=YMAX-3*TXTH(s)-2 ''Var screen Y max
scXmax=XMAX ''Var screen X max
bx=XMAX/2:by=scYmax-4 ''Var bar
barx=bx:bary=by ''Var bar

RECT 0,0,XMAX,15 FILLED
RECT 2,2,15,13 COLOR 15 FILLED
PSET 5,5 COLOR 0 ''pixel set
RECT 0,12,scXmax,scYmax
AT 20,5:? CAT(3); "AnBall 1.0"; CAT(0)
AT 0,YMAX-3*TXTH(s):? "Points: 0" ''"3.1*" for 3 line up from bottom
AT XMAX/2,YMAX-3*TXTH(s):? "Lifes:"
AT 0,YMAX-2*TXTH(s):? "Hit any key to exit" ''for 2 line up from bottom

LINE 7,18,4,25
LINE 8,17,12,25
LINE 8,17,8,35
AT 2,40:? "Hit here to PAUSE"
AT 2,55:? "Hit a key to exit"
AT 2,70:? "Prepare. Start soon."
PAUSE 5 ''wait 5 sec

startdrawlife=XMAX/2+8*TXTW(s)
ballstep=XMAX/5-startdrawlife/5
FOR i=0 TO 4 ''draw balls lifes
	CIRCLE ballstep*i+startdrawlife,scYmax+TXTH(s)/1.5,2 FILLED
NEXT

beginball

''=====Main prog.======

PEN ON ''mouse on
REPEAT
	IF y>=scYmax-3 AND ontime>0 ''Time for restarted new ball
		ontime=ctime-TIMER ''Countdown
		AT 2,YMAX/2.5:? "Restart in "+ontime+" sec."
		IF ontime=0
			Beginball
			lifes
		FI
		GOTO end ''skip to end
	FI

	axex=x:axey=y ''switch var ball
	IF x>bx-9 AND x<bx+9 AND y>scYmax-9 ''ignorer si c''est dans la barre
		x=x+dx
		y=y+dy
		GOTO hit
	ELSE
		x=x+dx
		y=y+dy
	FI

''	bhitx=bx-x
''	bhity=bx-y

	IF x>bx-10 AND x<bx+10 AND y>=scYmax-10 ''Top bar
		dy=-dy
		BEEP
		p=p+1 ''point count
		AT 0,YMAX-3*TXTH(s)
		? "Points: " + p ''points display
		GOTO hit
	FI
	IF x>bx-11 AND x<bx+11 AND y>scYmax-9 ''Side bar
		dx=-dx
		BEEP
	FI

LABEL hit

	IF y<=19
		dy=-dy
		BEEP
	FI
	
	IF y>=scYmax-3 ''Take off 1 life
		BEEP
		explosed
		l=l-1 ''life count
		ctime=TIMER+5 ''temps dιbut
		GOTO end ''skip to end
	FI

	IF x>=xmax-4 or x<=4 ''Cotes
		dx=-dx
		BEEP
	FI

	CIRCLE axex,axey,2 COLOR 15 FILLED ''erased old ball
	CIRCLE x,y,2 FILLED ''draw new ball

LABEL pencil

	IF PEN(0) ''mouse click detected
		IF PEN(1)<15 AND PEN(2)<15
		AT XMAX/2.6,YMAX/2.5
		? CAT(3);" PAUSE "; CAT(0) 
			btn=1
			stoptemp
			GOTO end
		FI
		IF PEN(4)>bx AND bx<=XMAX-14
			barx=bx:bx=bx+5
		ELSEIF PEN(4)<bx AND bx>=11
			barx=bx:bx=bx-5
		FI
		RECT barx-7,bary-3,barx+7,bary+2 COLOR 15 FILLED ''old rectangle
		RECT bx-7,by-3,bx+7,by+2 FILLED ''new rectangle
	FI

LABEL end

UNTIL (INKEY$ != "") ''exit repeat if a key pressed
LABEL quit
CLS
AT XMAX/2.5,50:? CAT(3);" QUIT - Quitter "
? ""
? ""
? ""
PEN OFF ''mouse off

''=====SUB routine======

SUB stoptemp
REPEAT
	IF PEN(0)
		IF PEN(1)<15 AND PEN(2)<15
			btn=0
		FI
	FI
UNTIL (btn = 0)
RECT 1,16,XMAX-1,scYmax-1 COLOR 15 FILLED ''erase screen
RECT bx-7,by-3,bx+7,by+2 FILLED ''Replace bar erased
CIRCLE x,y,2 FILLED ''Redraw ball erased
END

SUB explosed
	FOR i=0 TO 3
		ARC x,y,i*5+10,3.7,5.75
		BEEP
	NEXT
END

SUB beginball
	ontime=1 ''Timer set
	dx=1:dy=-1 ''var step of ball, direction up
	RECT 1,16,XMAX-1,scYmax-1 COLOR 15 FILLED ''erase screen
	RECT bx-7,by-3,bx+7,by+2 FILLED ''replace the bar erased
	x=RND*XMAX/2+XMAX/10:y=RND*XMAX/2+YMAX/8 ''Random started ball
	axex=x:axey=y ''Switch var ball for arithmetic operation later
	IF x>scXmax-3 ''X limited
		x=scXmax-5
	ELSEIF y>scYmax-10 ''Y limited
		y=scYmax-15
	FI
END

SUB lifes
	CIRCLE ballstep*l+startdrawlife,scYmax+TXTH(s)/1.5,2 COLOR 15 FILLED ''erase ball
	IF l=-1
		AT XMAX/2.8,YMAX/2.5
		? "GAME OVER"
		AT XMAX/2.8,YMAX/2
		? "Fin du jeu"
		PAUSE 3 ''wait 3 sec
		GOTO start ''skip to start
	FI
END'
