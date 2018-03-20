
const maxx = 800
const maxy = 600
CONST NumInvaders = 10

DIM Invaders(NumInvaders)
DIM	InvadersPic(NumInvaders)
DIM	InvadersKilled(NumInvaders)
DIM	InvadersSpeed(NumInvaders)
DIM	InvadersHeight(NumInvaders)
DIM	InvadersWidth(NumInvaders)
DIM	InvadersDrop(NumInvaders)
DIM InvadersRight(NumInvaders)
DIM	InvadersSpacing(NumInvaders)
DIM	InvadersY(NumInvaders)
DIM	InvadersX(NumInvaders) 

WindowWidth = maxx
WindowHeight = maxy

replay = 1
levelup = 0
level = 0

open "assets/shooter2.png" as #1
open "assets/shot.png" as #2
open "assets/newvader.png" as #3
open "assets/continue.png" as #4
open "assets/doomed.png" as #5
open "assets/goodbye.png" as #6
open "assets/saved.png" as #7

again = image(#4)
doomed = image(#5)
goodbye = image(#6)
saved = image(#7)

while replay = 1
    CLS
    rect 0,0,800,600 color rgb(9,167,9)
    gosub LoadSettings
    repeat
		k = inkey
		if k = chr(27) then end
        gosub MoveShooter
        gosub FireShot
        gosub CheckHit
        gosub checklevel
        gosub MoveInvaders
        gosub CheckGameOver
    until Win = 1 or Lose = 1
    gosub EndGame
wend
cls
goodbye.show(315,288)
pause 3
cls
end
'==================
'
'	SUBROUTINES
'
'==================
LABEL LoadSettings
	Lose = 0
	Win = 0
	ShotDown = 0
	ShooterPic = image(#1)
	ShooterSpeed = 6
	ShooterHeight = 50
	ShooterWidth = 50
	ShooterX = (WindowWidth / 2) - (ShooterWidth / 2) - 1
	ShooterY = WindowHeight - (ShooterHeight * 2) - 1
	ShotPic = image(#2)
	ShotSpeed = 6
	ShotHeight = 20
	ShotWidth = 10
	ShotFired = 0
	FOR i = 1 TO NumInvaders
		InvadersRight(i) = 1
		InvadersPic(i) = image(#3)
		InvadersKilled(i) = 0
		InvadersSpeed(i) = 5
		InvadersHeight(i) = 40
		InvadersWidth(i) = 45
		InvadersDrop(i) = 40
		InvadersSpacing(i) = 20
		InvadersY(i) = 0
		InvadersX(i) = -i * (InvadersWidth(i) + InvadersSpacing(i))
	NEXT
return

LABEL MoveShooter
	IF k = "," AND ShooterX >= 0 THEN
		ShooterX = ShooterX - ShooterSpeed
	END IF
	IF k = "." AND ShooterX + ShooterWidth <= WindowWidth - 1 THEN
		ShooterX = ShooterX + ShooterSpeed
	END IF
	ShooterPic.show(ShooterX, ShooterY)
return

label FireShot
	IF k = " " AND ShotFired = 0 THEN
		' ShotSound
		ShotFired = 1
		ShotX = ShooterX + (ShooterWidth / 2) - (ShotWidth / 2)
		ShotY = ShooterY
	END IF

	IF ShotFired = 1 THEN
		ShotY = ShotY - (ShotSpeed + (level * 0.5))
		ShotPic.show(ShotX, ShotY)
	END IF

	IF ShotFired = 0 THEN
		ShotY = -30
	END IF

	IF ShotY + ShotHeight <= 0 THEN
		ShotFired = 0
	END IF
return

label CheckHit
	FOR i = 1 TO NumInvaders
		IF (ShotX + ShotWidth >= InvadersX(i)) AND (ShotX <= InvadersX(i) + InvadersWidth(i)) AND (ShotY <= InvadersY(i) + InvadersHeight(i)) AND (ShotY + ShotHeight >= InvadersY(i)) AND (InvadersKilled(i) = 0) THEN
			' HitSound
			InvadersKilled(i) = 1
			ShotPic.show(-100,-100)
			critter = InvadersPic(i)
			critter.show(-100,-100)
			ShotDown = ShotDown + 1
			ShotFired = 0
		END IF
	NEXT
return

label checklevel
	if levelup = 1 then
		level = level + 1
		levelup = 0
	end if
	at (maxx/2) - 25,maxy-30: Print "LEVEL: " + str(level+1)
return

label MoveInvaders
	FOR i = 1 TO NumInvaders
		IF InvadersRight(i) = 1 THEN
			InvadersX(i) = InvadersX(i) + (InvadersSpeed(i) + (level * 0.5))
		ELSE
			InvadersX(i) = InvadersX(i) - (InvadersSpeed(i) + (level * 0.5))
		END IF
		IF InvadersX(i) + InvadersWidth(i) >= WindowWidth - 1 AND InvadersRight(i) = 1 THEN
			InvadersY(i) = InvadersY(i) + InvadersDrop(i)
			InvadersRight(i) = 0
		END IF
		IF InvadersX(i) <= 0 AND InvadersRight(i) = 0 THEN
			InvadersY(i) = InvadersY(i) + InvadersDrop(i)
			InvadersRight(i) = 1
		END IF
		IF InvadersKilled(i) = 0 THEN
			critter = InvadersPic(i)
			critter.show(InvadersX(i),InvadersY(i))
		END IF
	NEXT
return

label CheckGameOver
	FOR i = 1 TO NumInvaders
		IF InvadersY(i) + InvadersHeight(i) >= ShooterY AND InvadersKilled(i) = 0 THEN
			Lose = 1
		END IF
	NEXT
	IF ShotDown = NumInvaders THEN
		Win = 1
	END IF
return

label EndGame
	IF Win = 1 THEN
		saved.show(182,237)
		' WinSound
		pause 3
	END IF
	IF Lose = 1 THEN
		doomed.show(171,237)
		' DeadSound
		pause 3
	END IF
	'
	'	Y or N loop
	'
	repeat
		again.show(243,327)
		yn = ucase(inkey)
		if yn = "Y" then
			replay = 1
			levelup = 1
		end if
		if yn = "N" then
			replay = 0
			levelup = 0
		end if
	until yn = "Y" or yn = "N"
return
