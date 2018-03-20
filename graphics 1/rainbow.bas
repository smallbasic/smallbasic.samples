
'10 REM     RAINBOW SIMULATION
11 REM
12 REM  Modified by Dave La Rosa for use with Small Basic on an EBM
13 REM  8000 points takes 1/2 hour on 23MHz EBM
14 REM  
15 REM Genesis 9:13 I do set my bow in the cloud, and it shall be
16 REM              a token as a covenant between me and the earth.
20 REM 
21 cls
22 npstop=299999 : if OS="EBM" then npstop=7998
23 mode$="Landscape" :  mode$=""  
24 st$=time$
25 R0=180/PI
26 RANDOMIZE(23)
30 REM     RANDOM IMPACT PARAMETER
35 X=-1+2*RND
40 Y=-1+2*RND
45 B=SQR(X*X+Y*Y)
50 IF B>=1 THEN goto 30
55 REM     COLOR & INDEX OF REFR.
60 C=1+INT(08-7.5*RND)
65 N=1.125+.08*(C-1)
70 REM     COMPUTE ANGLES
75 I=ATN(B/SQR(1-B*B))
80 R=ATN(B/SQR(N*N-B*B))
85 T1=(4*R-2*I)*R0
90 T2=(6*R-2*I)*R0-180
95 REM     INTENSITY FACTORS
100 RS=(SIN(I-R)/SIN(I+R))^2
105 RP=(TAN(I-R)/TAN(I+R))^2
110 RB=(1-RP)*(1-RP)
115 RC=(1-RS)*(1-RS)
120 I1=(RS*RC+RP*RB)/2
125 I2=(RS*RS*RC+RP*RP*RB)/2
130 IF I1<.04*RND THEN goto 140
135 TH=T1:  GOSUB 180
140 IF I2<.02*RND THEN goto 150
145 TH=T2:  GOSUB 180
146 if NP > npstop then goto 300
150 GOTO 30
155 REM     COLORS & SCREEN
160 rem Was SCREEN 9  CLS  KEY OFF  NP=0
161 CLS: NP=0
165 rem PALETTE 1,4  PALETTE 2,2
170 rem PALETTE 3,9
175 RETURN
180 REM     PLOT ON SCREEN 
185 TH=ABS(TH)
190 IF TH>60 THEN RETURN
191 x0=xmax/2: y0=ymax/2
195 XP=x0+x0*(TH/60)*(X/B)
200 YP=y0-y0*(TH/60)*ABS(Y/B)
201 C=8-C
202 if (C=0) then RETURN
203 if mode$!="Landscape" then goto 206
204 XP=y0+y0*(TH/60)*ABS(Y/B)
205 YP=x0+x0*(TH/60)*(X/B)
206 PSET XP,YP,C:  NP=NP+1
210 LOCATE 1,1:  PRINT NP;" C=";C;" " :  RETURN
215 REM Removed Apple II comments lines 220-275
280 REM **************************************
285 REM   APPEARED IN ASTRONOMICAL COMPUTING
290 REM   SKY & TELESCOPE, FEBRUARY 1991 ISSUE
291 REM http://skyandtelescope.com/resources/software/
300 REM **************************************
310 at 1,ymax*.75
320 if mode$!="Landscape" then goto 340
330 at 1,y0
340 Print "Time Start: ";st$;"   End: "; time$
350 PRINT ""'
