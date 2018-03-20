
rem Title: recognition_training
rem Description: About 70% of kids have problems with the recognition of letters.
rem When you are reading your eyes are bouncing about part of the words.
rem In case of dyslexia there are often problems with this part of recognition.
rem The program trains the eyes recognition speed.
rem For the Training the window should have the dimensions about 20 X 16 cm.
rem You can find the german versions and 2 articles about the idea under www.decotrain.de/blick/
rem 
rem Category: Applications
rem Copyright: Karsten Malcher
rem Email: logotrainer@decotrain.de
rem Created: 01.02.2004
rem Version: 1.0
rem Sbver: 0.7
'CLS
? cat(1); "Recognition Training"; cat(0)
? "Program by Karsten Malcher"
? "Version 1.0 from 01.02.2004"
? 
?
Label Anfang 
input "Count of Sessions (Standard = 200) ? ", TZ
if TZ = "e" then End 
if TZ = "" then TZ = 200
input "Arrowsize (Standard = 4) ? ", PG
if PG = "" then PG = 4
input "Start in sec. (Standard = 0.7) ? ", IV
if IV = "" then IV = 0.7
SIV = IV
input "Pause in sec.     (Standard = 1) ? ", PU
if PU = "" then PU = 1
?

? "Calibrating time measurement ..."
Calib = 1 : TimeConst = 1
LTimer = Timer
while Timer = LTimer
wend
Warte 1
Calib = 0
TimeConst = TCount / 3

BTimer = Timer
BZeit = Time$
for Schleife = TZ to 1 step -1
	cls
	RI = Int(Rnd * 3 + 1.55555555)	''Richtung
	PS = Int(Rnd * 3 + 1.55555555)	''Position

	RA = 20	''Abstand vom Rand
	''Koordinaten f?r Pfeil
	if PS = 1 then X = RA : Y = RA
	if PS = 2 then X = XMAX - RA : Y = RA
	if PS = 3 then X = XMAX - RA : Y = YMAX - RA
	if PS = 4 then X = RA : Y = YMAX - RA

	PF = 2	''Pfeilproportionen
	''Pfeil nach oben
	if RI = 1 then
		line X, Y, X, Y + PF * PG
		line X, Y, X - PG, Y + PG
		line X, Y, X + PG, Y + PG
	endif
	''Pfeil nach rechts
	if RI = 2 then
		line X, Y, X - PF * PG, Y
		line X, Y, X - PG, Y - PG
		line X, Y, X - PG, Y + PG
	endif
	''Pfeil nach unten
	if RI = 3 then
		line X, Y, X, Y - 2 * PG
		line X, Y, X - PG, Y - PG
		line X, Y, X + PG, Y - PG
	endif
	''Pfeil nach links
	if RI = 4 then
		line X, Y, X + 2 * PG, Y
		line X, Y, X + PG, Y - PG
		line X, Y, X + PG, Y + PG
	endif

	Warte IV
	cls
	at XMAX / 2 - 20, YMAX / 2
	? "? ("; Schleife; ") ?"
	repeat
		K = inkey
	until K <> ""
	if len(K) = 1 and asc(K) = 27 then goto Auswertung
	''Pr?fung der Eingabe
	Check = 0
	if len(k)=2 then
		KA = asc(right(k,1))
		''Oben
		if KA = 9 and RI = 1 then Check = 1
		''Rechts
		if KA = 5 and RI = 2 then Check = 1
		''Unten
		if KA = 10 and RI = 3 then Check = 1
		''Links
		if KA = 4 and RI = 4 then Check = 1
	endif
	OK = OK + Check
	''Anzeigezeit dynamisch anpassen
	if Check then
		SZeit = SZeit + IV
		OKCount = OKCount + 1
		LXCount = 0
		if OKCount = 5 then
			IV = IV * 0.95
			OKCount = 0
		endif
	else
		XZeit = XZeit + IV
		LXCount = XCount + 1
		OKCount = 0
		if LXCount = 2 then
			IV = IV * 1,02
			LXCount = 0
		endif
	endif
	Warte PU
next


Label Auswertung
ETimer = Timer
EZeit = Time$
cls
TZ = TZ - Schleife
''Division durch Null vermeiden
if TZ = OK then
	FRate = 1
else
	FRate = round(XZeit / (TZ - OK), 2)
endif
? cat(1); "Recognition Training complete."; cat(0)
?
? "Begin of Training: "; BZeit
? "End   of Training: "; EZeit
? "Estimated Time   : "; round((ETimer - BTimer) / 60, 2); " minutes"
?
? TZ; " sessions made."
? OK; " correct recognized ("; round(OK / TZ * 100, 2); " %)"
? "average recognition time = "; round(SZeit / TZ, 2); " sec. (rate = "; round(TZ / SZeit, 2); ")"
? "average time by failure  = "; FRate; " sec. (rate = "; round(1 / FRate, 2); ")"
? "last recognition time    = "; round(IV, 2); " sec."

''Log-Datei schreiben
Datum = left$(Date$, 2) + "." + mid$(Date$, 4, 2) + "." + right$(Date$, 4)
Filename = CWD + "recognition_training.log"
if exist(Filename) then
	Open Filename for append as #1
else
	Open Filename for output as #1
endif
? #1, "Date of Training  : "; Datum; chr(13)
? #1, "Begin of Training: "; BZeit; chr(13)
? #1, "End   of Training: "; EZeit; chr(13)
? #1, "Estimated Time   : "; round((ETimer - BTimer) / 60, 2); " minutes"; chr(13)
? #1, "Initial value    : "; SIV; " sek."; chr(13)
? #1, chr(13)
? #1, TZ; " sessions made."; chr(13)
? #1, OK; " correct recognized ("; round(OK / TZ * 100, 2); " %)"; chr(13)
? #1, "average recognition time = "; round(SZeit / TZ, 2); " sec. (rate = "; round(TZ / SZeit, 2); ")"; chr(13)
? #1, "average time by failure  = "; FRate; " sec. (rate = "; round(1 / FRate, 2); ")"; chr(13)
? #1, "last recognition time    = "; round(IV, 2); " sec."; chr(13)
? #1, "--------------------------------------------------"; chr(13)
close #1

''CSV-Datei schreiben
Filename = CWD + "recognition_training.csv"
if exist(Filename) then
	Open Filename for append as #1
else
	Open Filename for output as #1
	? #1, "date;begin;end;duration;sessions;OK;reco-time;fail-time;last-time;initial"; chr(13)
endif
? #1, Datum; ";"; BZeit; ";"; EZeit; ";"; round((ETimer - BTimer) / 60, 2); ";"; TZ; ";"; OK; ";"; round(SZeit / TZ, 2); ";"; FRate; ";"; round(IV, 2); ";"; SIV; chr(13)
close #1

End


Sub Warte (Zeit)
	TCount = 0
	while TCount < Zeit * TimeConst or (Calib and Timer < LTimer + 4)
		TCount = TCount + 1
	wend
End
'
