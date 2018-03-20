'<=== comment signal computer ignores all to the right ==>
' 
' Program "balleta 2-11-15.bas", Bpf copy 
'
'                  test run on SmallBasic v11.5 (Windows) by B+
'notes:
'This program works best for laps < 60 minutes in length (guaranteed error>119 minutes)
'3:05 PM looks like 3:5  or 5:02 PM like 5:2 double digit minutes OK

'PAUSE is not recognized, B+ assume just want to display a title = print
5 print "GO FOR IT!"

'Commented out this part of line 10, B+ have no idea what this part is or does
'10 '"S"; 

'(I THINK THE K SHOULD BE A P AS THERE'S NO K IN ANY OTHER PART OF THE PROGRAM) OK 
10 G=0:P=0:S=0 
20 INPUT "START TIME (hr.min) =",H  'for test 2.45 (PM)     
30 M=INT((H-INT(H))*100):B=INT(H)   'B+ fix 0 ===> ) and put INT(...) after =                
40 INPUT "CAR NUMBER=",N            '(typo extra P) for test purpose this will be 0
50 INPUT "FACTOR=",F                '(FOR INITIAL PURPOSE THIS WILL BE 1)
60 INPUT "INITIAL MILEAGE=",I       '(ODOMETER READING AT START UP) for test say 46,000
70 INPUT "G(-)/P(+)=",E             '(FOR INITIAL PURPOSE THIS WILL BE 0)
80 INPUT "SPEED=",V                 '(SPEED OR VELOCITY FOR THAT PORTION OF THE ROUTE) 
                                    'for test V=60 or 1 mile in 1 minute
                                    'and 15 mile stops 46,015, 46,030 46,045...
'loop begins here
90 INPUT "ACTUAL MILEAGE=",A   '(ACTUAL ODOMETER READING AT A GIVEN PART OF THE ROUTE)
100 D=A-I:I=A

'Basically: T in minutes is calculated time to travel D miles at V speed ===> G
110 T=INT((100*D*60)/(F*V))/100:G=T

'T minutes ==> G is added to start minutes = M to see the expected time of arrival
120 S=S+M+G+N+E:N=0:M=0:E=0   'Oh M is reset =0 because its value is moved into S ! aha!
130 IF S>=60 THEN GOTO 150       
140 GOTO 170
150 S=S-60
160 B=B+1
170 PRINT "TIME=";B;":";S    
'(THIS IS THE PRETENDED (Predicted) OUTCOME, THE TIME AT WHICH YOU ARE  
'SUPPOSED TO BE IN THAT POINT IF YOU FOLLOW THE ROUTE CORRECTLY 
'AND AT THE SPECIFIED SPEED) 
'ah! this comment most helpful we are planning out a course pts A, B, C, D
'and want to know the times of arrival at those points at the speed assigned.
175 GOTO 90