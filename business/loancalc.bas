
'#sec:Main
'' loancalc.bas
'' 31/05/2002
'' V 1.0 - 062702:1007A
'' Loan calculator - gives general
'' info regarding a loan, and can 
'' solve for the unknown 1 of 4
'' variables given the other 3.
'' This is based on a CGI program
'' which performs the same functions
'' originally written by Karl Dunn. 
'' Karl''s cgi program can be found at
'' http://home.hiwaay.net/~kdunn
'' SBas interface/port of the original
'' loan analyzer by Tim O''Brien
'' http://home.hiwaay.net/~tjobrien
'' This program is intended to be used
'' as a guideline, and there are no
'' guarantees of its accuracy, or of
'' anything else for that matter. The
'' author and other parties involved
'' accept no liability for its use or
'' misuse. 
''
'' InitVariables
devel=0:oldx=0:oldy=0:dp=0:pr=0:ar=0
pmts=0:mopmt=0:intpd=0:totpb=0
actual=0
gosub ScrInit:gosub UpdScreen
label hell:
	pen on
	while (pen(0)=0):wend
	x=pen(4):y=pen(5)
	pen off
'' See if ''x'' is clicked
if (x>149 && x<159&&y<11&&y>1)
	cls:end	
endif
'' Check if ''calculate'' is clicked
if (x>0&&x<56&&y>141&&y<155)
	dp=0:pr=0:ar=0:pmts=0:mopmt=0
	intpd=0:totpb=0:entpr=0:pri=0
	gosub UpdScreen
endif
''Input field - DownPayment
if (y>44&&y<54)
	locate 5,23:print spc(24);
	locate 5,23:input dp;
	if (dp="")
		dp=0
	endif
	dp=val(dp) 
	if (pri>0)
		pr = pri - dp
	endif
	gosub calculate:gosub UpdScreen
endif
''Input field - Principal
if (y>33&&y<43)
	locate 4,23:print spc(24);
	locate 4,23:input pri;
	if (pri="")
		pri=0
	endif
	pri=val(pri)
	if (dp>0&&pri>=dp)
		pr=pri-dp
	else
		pr=pri
	endif
	gosub calculate:gosub UpdScreen
endif
''Input Field - Annual Rate
if (y>55&&y<65)
	locate 6,23:print spc(24);
	locate 6,23:input ar;
	if (ar="")
		ar=0
	endif
	ar=val(ar)
	gosub calculate:gosub UpdScreen
endif
''Input Field - Number of Payments
if (y>66&&y<76)
	locate 7,23:print spc(24);
	locate 7,23:input pmts;
	if (pmts="")
		pmts=0
	endif
	pmts=val(pmts)
	gosub calculate:gosub UpdScreen
endif
''Input Field - Monthly Payment
if (y>77&&y<87)
	locate 8,23:print spc(24);
	locate 8,23:input mopmt;
	if (mopmt="")
		mopmt=0
	endif
	mopmt=val(mopmt)
	gosub calculate:gosub UpdScreen
endif
goto hell
label calculate:
if(pr<0||ar<0||pmts<0||pri<0||mopmt<0||dp<0)
		err="Negative Numbers Illegal"
		gosub ErrBox:return
	endif
	if(pr=0&&ar!=0&&pmts!=0&&mopmt!=0)
		''solve for pr (principal)
		r=ar/1200
	pr=(mopmt*(1.0-pow(1.0+r,-pmts)))/r
		entpr=pr:totpb=mopmt*pmts
		intpd=totpb-pr
		if (dp>0)
			pri=pr+dp
		else 
			pri=pr
		endif
		return
	endif

if (pr!=0&&ar=0&&pmts!=0&&mopmt!=0)
''solve for ar
r=0:ar=0:rp=0:rmn=0:rmn1=0
if (((pmts*mopmt)>pr)&&(pmts>1.0))
r=2.0*(pmts-pr/mopmt)/(pmts*(pmts+1.0))
	if (r<0.0008)
		ar=0
		err="Interest less than 1%"
		gosub ErrBox:return
	else 
		while (abs((r-rp/r)>=0.00000001))
			rp=r
			rmn=pow(1.0+r,-pmts)
			rmn1=1.0-rmn
r=r+(mopmt*rmn1/pr-r)/(1.0-pmts*r*rmn/((1.0+r)*rmn1))
		wend
	ar=r*1200
	totpb=mopmt*pmts:intpd=totpb-pr
	if (dp>0)
		pr=pri-dp
	else 
		pr=pri
	endif
	return
	endif
else
	ar=0
	err="Pmt too small for schedule"
	gosub ErrBox:return
endif
endif
	if (pr!=0&&ar!=0&&pmts=0&&mopmt!=0)
		''solve for num of pmts
		r=ar/1200
		if((pr*r)<mopmt)
    pmts=-log(1.0-pr*r/mopmt)/log(1.0+r)
		 totpb=mopmt*pmts
		 intpd=totpb-pr:return
		else
		  err="Payment too small"
		  gosub ErrBox
		  return
		endif
	endif
	if ((pr!=0&&ar!=0&&pmts!=0&&mopmt=0)||(pr!=0&&ar!=0&&pmts!=0&&mopmt!=0))
		''solve for mopmt or recalc
		''if all are not zerg
		r=ar/1200
	  mopmt=pr*r/(1.0-pow(1.0+r,-pmts))
		totpb=mopmt*pmts
		intpd=totpb-pr:return
	endif	
return
#sec:ScrInit
'' ScrInit
label ScrInit:
cls
? chr$(27)+"[81m";
? "Loan Calculator/Analyzer"
? chr$(27)+"[80m";
? "(c) 2002 - DBMI - GPL"
line 0,24,xmax,24
line 150,2,157,9:line 150,9,157,2
locate 4,1:?"Original Amount";
locate 5,1:?"Down Pmt/Trade";
locate 6,1:?"Annual Rate";
locate 7,1:?"Number of Payments";
locate 8,1:?"Monthly Payment";
locate 10,1:?"Actual Principal";
locate 11,1:?"Interest Paid";
locate 12,1:?"Total Payback";
locate 14,2:?"Reset Form";
line 0,142,0,154:line 55,142,55,154
line 0,142,55,142:line 0,154,55,154
return
#sec:UpdScreen
'' UpdScreen
label UpdScreen:
	locate 4,23:print spc(24);
	locate 4,23
	print using "#######.00" ;pri;
	locate 5,23:print spc(24);
	locate 5,23
	print using "#######.00" ;dp;
	locate 6,23:print spc(24);
	locate 6,23
	print using "#######.0000" ;ar;
	locate 7,23:print spc(24);
	locate 7,23
	print using "#######.00" ;pmts;
	locate 8,23:print spc(24);
	locate 8,23
	print using "#######.00" ;mopmt
	locate 10,23:print spc(24);
	locate 10,23
	print using "#######.00" ;pr
	locate 11,23:print spc(24);
	locate 11,23
	print using "#######.00" ;intpd
	locate 12,23:print spc(24);
	locate 12,23
	print using "#######.00" ;totpb
return
#sec:ErrBox
'' ErrBox
label ErrBox
cls
x=5:y=20:x1=155:y1=80
line x,y,x1,y:line x,y+14,x1,y+14
line x,y1,x1,y1:line x,y,x,y1
line x1,y,x1,y1
locate 3,6
?"Press Return or Tap Screen";
locate 5,4:? chr$(27)+"[81m";
? err;
? chr$(27)+"[80m";
pen on
repeat
  qwe=inkey
until (qwe<>""||pen(0)!=0)
pen off
gosub ScrInit
gosub UpdScreen
return'
