
rem Title: recognition_training_AZ
rem Description: Recognition traning with numbers and letters.
rem About 70% of kids have problems with the recognition of letters.
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
? "Version 1.0 vom 01.02.2004"
? 
?
Label Anfang 
input "Numbers (N) or Letters (L) ? ", ZB
if ZB = "e" then End
ZB = MeUpper(ZB)
if ZB = "" then ZB = "N"
input "Count of Sessions (Standard = 200) ? ", TZ
if TZ = "" then TZ = 200
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
	if ZB = "N" then
		RI = chr(Int(Rnd * 9 + 48.55555555))	''Zahl
	else
		RI = chr(Int(Rnd * 25 + 65.55555555))	''Buchstabe
	endif
	PS = Int(Rnd * 3 + 1.55555555)	''Position

	RA = 20	''Abstand vom Rand
	if PS = 1 then X = RA : Y = RA
	if PS = 2 then X = XMAX - RA : Y = RA
	if PS = 3 then X = XMAX - RA : Y = YMAX - RA
	if PS = 4 then X = RA : Y = YMAX - RA

	at X, Y
	? RI

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
	if MeUpper(K) = RI then Check = 1
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
Filename = CWD + "recognition_training_AZ.log"
if exist(Filename) then
	Open Filename for append as #1
else
	Open Filename for output as #1
endif
if ZB = "Z" then
	? #1, "Traning with numbers";chr(13)
else
	? #1, "Traning with letters";chr(13)
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
Filename = CWD + "recognition_training_AZ.csv"
if exist(Filename) then
	Open Filename for append as #1
else
	Open Filename for output as #1
	? #1, "date;begin;end;duration;sessions;OK;reco-time;fail-time;last-time;initial"; chr(13)
endif
? #1, Datum; ";"; BZeit; ";"; EZeit; ";"; round((ETimer - BTimer) / 60, 2); ";"; TZ; ";"; OK; ";"; round(SZeit / TZ, 2); ";"; FRate; ";"; round(IV, 2); ";"; SIV; ";"; ZB; chr(13)
close #1

End


Sub Warte (Zeit)
	TCount = 0
	while TCount < Zeit * TimeConst or (Calib and Timer < LTimer + 4)
		TCount = TCount + 1
	wend
End

Func MeUpper (Char)
	if asc(Char) > 96 then
		MeUpper = chr(asc(Char)-32)
	else
		MeUpper = Char
	endif
end'
