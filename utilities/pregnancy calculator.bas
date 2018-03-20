
''' Pregnancy Calculator.bas
'' 19/11/2001

''JD=Julian Date
''K=Year (1901 to 2099)
''M=Month''I=Day of month
''
Input "What was the start month";ms
Input "What was the start day of month";ds
Input "What was the start year";ys
''
''Change the following line to reflect the correct conception date
''currently hard-coded for Sep. 17, 2001
ys=2001
ms=9
ds=17
concep=jul(ys,ms,ds)
yn=val(mid$(date$,7,4))
dn=val(mid$(date$,1,2))
mn=val(mid$(date$,4,2))
today=jul(yn, mn, dn)
weeks=int ((today-concep)/7)
days=(today-concep)-weeks*7
? "Pregnancy Calculator"
? "Currently set for a conception date of ";ms;"/";ds;"/";ys;"."
? "Today is ";mn;"/";dn;"/";yn;"."
? "Current gestational age:"
? ,weeks;" weeks ";days;" days."remain=280-weeks*7-days
? ,remain;" days left."
? "(That''s ";int(remain/7);" weeks and ";remain-int(remain/7)*7;" days.)"
?
end

FUNC JUL(k,m,i)	
JUL=367*k-int((7*(k+int((m+9)/12)))/4)+int((275*m)/9)+i
END
'
