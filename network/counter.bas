
'''This is the famous "CGI Counter" in the SmallBasic version
''treat it as any Perl or Shell script used for CGI
''don''t forget about the user rights and to rename file to .cgi or add .bas to allowed cgi
''
''if you have added SSI support to your http server you can include
'' the counter on a page with this: <!--#include virtual="/cgi-bin/counter.cgi" --> 


#!/usr/bin/sbasic -q
print "Content-type: text/html"
print

file$="counter.dat"
counter=""

if exist(file$) then
	open file$ for input as #1
	lineinput #1,counter
	close #1	
	counter=val(counter)+1
	open file$ for output as #1
	print #1,counter
	close #1	
else
	open file$ for output as #1
	print #1,"0"
endif

print counter'
