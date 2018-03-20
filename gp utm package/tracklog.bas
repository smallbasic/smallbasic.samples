
'#sec:Main
G2UINIT
repeat
	? "Cetus tracklog ? PDOC:";
	lineinput ifn
	ifn="PDOC:"+ifn
until exist(ifn)
ifh = freefile
open ifn for input as #ifh
while 1
	? "Output dataset ? ";
	lineinput ofn
	if exist(ofn) then
		?"Overwrite existing file? ";
		lineinput ans
		if asc(lower(ans))=121 then
			kill ofn
			exit loop
		endif
	else
		exit loop
	endif
wend
ofh = freefile
open ofn for output as #ofh
while not eof(ifh)
	lineinput #ifh,v
	if left(v,6) = "record" then
		exit loop
	endif
wend
print #ofh,space(10)
cls
? "Processing Cetus tracklog"
? "''";ifn;"''"
z=0
while not eof(ifh)
	lineinput #ifh,v
	split v,chr(9)+";",x
	if len(x)<>13 then
		?
		? "Parse = ";x,len(x)
		? "''";v;"''"
		? "Continue? ";
		lineinput ans
		if asc(lower(ans))=110 then
			exit loop
		else
			? "Skipping record"
		endif
	else
		GP2UTM 2,VAL(x(6)),0,&
		VAL(x(7)),0,zn,east,north
		print #ofh,east;",";north
		? ".";
		z=z+1
	endif
wend
close #ifh
seek #ofh,0
print #ofh,z;
close #ofh
?
? z;" records written to ''";ofn;"''"
end

#inc:"LIB$GPUTMCon.bas"
'
