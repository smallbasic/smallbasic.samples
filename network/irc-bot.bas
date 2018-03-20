
''' IRC Bot with Eliza
'' Copyright (c) 2004, Nicholas Christopoulos
'' Yet another smallbasic example
'' 
'' see also RFC1459
''
'' say: ''smallbot, options'' for help on IRC

'' --- configuration ---

'' IRC server and port
IRCServer="rea.irc.gr:6667"

'' bot''s nickname
botName="smallbot"

'' bot''s nickname password
botPassword="*" '' use * for no password

'' default channel
botChannel="#cynics"

'' usernames that are recognized as bot masters
botMaster=["diogenisX", "myfriend1", "myfriend2"]

'' --- end of configuration ---

'' --- init eliza ---
DIM S(36),R(36),N(36)
DIM KEYWORD(36),WORDIN(7)
DIM WORDOUT(7),REPLIES(112)
N1=36:N2=14:N3=112
L=0:C=0:F=0:K=0:X=0

FOR X = 1 TO N1
	READ KEYWORD(X)
NEXT X
FOR X = 1 TO N2/2
	READ WORDIN(X)
	READ WORDOUT(X)
NEXT X
FOR X = 1 TO N3
	READ REPLIES(X)
NEXT X
FOR X=1 TO N1
	READ S(X),L
	R(X)=S(X)
	N(X)=S(X)+L-1
NEXT X

'' --- init resp tables ---
rplove = ["a *mwah*","a wet kiss","a tight and long hug", &
  		"an ass-squeeze", "a tight hug","a wet kiss","a nice, tight hug", &
  		"a kiss on the cheek","a wet, french kiss","a kiss","a hug", &
		"sex","sweet romance","some groping","bed actions","oral sex","a porn-tape", &
		"anal love"]
		
'' --- connect ---
open "socl:"+IRCServer as #1

print #1; "PASS "+botPassword
print #1; "NICK "+botName
print #1; "USER "+botName+" tartarus * :SmallBASIC bot"
print #1; "JOIN "+botChannel

'' loop
svr=""
while !eof(1)
	'' receive
	if lof(1)
		k=input$(1,1)
		print k;
		if asc(k)=10 '' EOL
			takeCare svr
			svr = ""
		else
			svr += k
		fi
	fi

	'' send
	k=inkey$
	if k then
		print #1, k;
		print cat(1);k;cat(0);
  	fi
wend

close #1
end

'' say something to nick or channel (privmsg)
sub tell(n,s)
print #1; "PRIVMSG "+n+" :"+s
end

'' say something to nick or channel (notice)
sub ptell(n,s)
print #1; "NOTICE "+n+" :"+s
end

'' automatic responses
sub takeCare(stxt)

if len(stxt) 
	split stxt, " ", w()
	
	'' PING/PONG
	if w(0) = "PING"
		print #1; "PONG "+w(1)
		if keeplog then print #2; "PONG "+w(1)

	'' notice message received
	elif w(1) = "NOTICE"		
		nick = leftOf(w(0), "!")
		if len(nick) = 0 then nick = w(0)
		if left(nick,1) = ":" then nick=mid(nick,2)

		if nick in botMaster
			msg = rightof(stxt, "NOTICE")
			msg = rightof(msg, ":")
			
			sinput msg; cmd, " ", rest
			if cmd = "say"
				tell botChannel, rest
			elif cmd = "sayx"
				sinput rest; xname, " ", rest	
				ptell xname, rest
			elif cmd = "cmd"
				print #1; rest
			fi
		else
			ptell nick, "you are not my master"
		fi
	
	'' privmsg received
	elif w(1) = "PRIVMSG"
		nick = leftOf(w(0), "!")
		if len(nick) = 0 then nick = w(0)
		if left(nick,1) = ":" then nick=mid(nick,2)
			
		if w(2) = botName
			'' this message is for me... let eliza to talk
			eliza nick, mid(w(3),2)
			
		elif left(w(2),1) = "#"
			'' this message is on channel
			msg = rightof(stxt, "PRIVMSG")
			msg = rightof(msg, ":")
			curchan = w(2)
			
			if instr(msg, botName) <> 0
				if instr(msg, " options") <> 0
					ptell nick, "SmallBot version 0.1, by Nicholas Christopoulos"
					ptell nick, "- action ------------ description -----------------------------------"
					ptell nick, "kill yourself         quit..."
					ptell nick, ":**                   kisses"
					ptell nick, "my baby               funny love texts"
					ptell nick, "speak                 unix fortune (BSD fortune required)"
					ptell nick, "(query)               talk with Eliza"
					ptell nick, "- bot''s master options (use /notice smallbot) -"
					ptell nick, "say <text>            say something on default channel"
					ptell nick, "sayx <nick|channel> <text> say something to ''nick'' (notice)"
					ptell nick, "cmd <irc-cmd>         write a raw IRC command (xmp: join #newchan)"
					ptell nick, "----------------------------------------------------------------------"
					ptell nick, "examples:"
					ptell nick, "<userX>: smallbot, kill yourserlf"
					ptell nick, "<smallbot>: userX, yes master"
					ptell nick, "<userX>: /notice smallbot cmd join #smallbasic"
																				
				elif instr(msg, " kill yourself") <> 0
					tell curchan, nick+", yes master"
					print #1; "QUIT"
					
				elif instr(msg, ":**") <> 0
					tell curchan, ":"+string(int(rnd*30)+1, "*")
					
				elif instr(msg, " my baby") <> 0
					new  = rplove(int(rnd*len(rplove)))
					tell curchan, "cheers "+nick+" with "+new
					
				elif instr(msg, " speak") <> 0
					new=run("fortune")
					split new, chr(10), anew
					for new in anew
						tell curchan, new
					next				
					tell curchan, chr(3)+"15----------------------------------------------------- fortune files ---"+chr(3)
					
				else
					'' default response
					new=translate(msg, botName, nick)
					tell curchan, new
				fi
			fi
		fi
	fi
fi
end

''---------------
sub eliza(nick,i)
I=UCASE$(I)
I="  "+I+"  "

'' GET RID OF APOSTROPHES
FOR L=1 TO LEN(I)
	if L+4>LEN(I) THEN 250
	IF MID(I,L,4) <> "SHUT" THEN 250
	tell nick, "O.K. IF YOU FEEL THAT WAY I''LL SHUT UP...."
	exit sub
250 
NEXT

IF I=P
	tell nick, "PLEASE DON''T REPEAT YOURSELF!"
	exit sub
fi

270
'' FIND KEYWORD IN I
FOR K=1 TO N1
	FOR L=1 TO LEN(I)-LEN(KEYWORD(K))+1
		IF MID(I,L,LEN(KEYWORD(K)))<>KEYWORD(K) THEN 350
		IF K<>13 THEN 349
		IF MID(I,L,LEN(KEYWORD(29)))=KEYWORD(29) THEN K=29
349
		F = KEYWORD(K)
		GOTO 390
350
	NEXT L
NEXT K
370 K=36: GOTO 570

390
''
'' TAKE PART OF STRING AND CONJUGATE IT
''
C=" "+RIGHT(I,LEN(I)-LEN(F)-L+1)+" "
FOR X=1 TO N2/2
	FOR L=1 TO LEN(C)
		IF L+LEN(WORDIN(X))>LEN(C) THEN 510
		IF MID(C,L,LEN(WORDIN(X)))<>WORDIN(X) THEN 510
		C=LEFT(C,L-1)+WORDOUT(X)+RIGHT(C,LEN(C)-L-LEN(WORDIN(X))+1)
		L = L+LEN(WORDOUT(X))
		GOTO 540
510 
		IF L+LEN(WORDOUT(X))>LEN(C) THEN 540

		IF MID(C,L,LEN(WORDOUT(X)))<>WORDOUT(X) THEN 540
		C=LEFT(C,L-1)+WORDIN(X)+RIGHT(C,LEN(C)-L-LEN(WORDOUT(X))+1)
		L=L+LEN(WORDIN(X))
540
	NEXT L
NEXT X
IF MID(C,2,1)=" " THEN
	C=RIGHT(C,LEN(C)-1)
FI
FOR L=1 TO LEN(C)
557
	IF MID(C,L,1)="!"
		C=LEFT(C,L-1)+RIGHT(C,LEN(C)-L)
		GOTO 557
	FI
NEXT L

570
F = REPLIES(R(K))
R(K)=R(K)+1
IF R(K)>N(K) THEN R(K)=S(K)
IF RIGHT(F,1)<>"*" THEN 
	tell nick, F
	P=I
	exit sub
FI
IF C<>"   " then 630
tell nick, "YOU WILL HAVE TO ELABORATE MORE FOR ME TO HELP YOU"
exit sub

630
? LEFT(F,LEN(F)-1);C
P=I
end

'' === DATA ===

'' KEYWORDS
DATA "CAN YOU ","CAN I ","YOU ARE ","YOU''RE "
DATA "I DON''T ","I FEEL "
DATA "WHY DON''T YOU ","WHY CAN''T I ","ARE YOU "
DATA "I CAN''T ","I AM ","I''M "
DATA "YOU ","I WANT ","WHAT ","HOW ","WHO "
DATA "WHERE ","WHEN ","WHY "
DATA "NAME ","CAUSE ","SORRY ","DREAM "
DATA "HELLO ","HI ","MAYBE "
DATA "NO","YOUR ","ALWAYS ","THINK "
DATA "ALIKE ","YES ","FRIEND "
DATA "COMPUTER", "NOKEYFOUND"

'' STRING DATA FOR CONJUGATIONS
DATA " ARE "," AM "," WERE "," WAS "
DATA " YOU "," I "," YOUR"," MY "
DATA " I''VE "," YOU''VE "," I''M "," YOU''RE "
DATA " ME "," YOU "

'' REPLIES
DATA "DON''T YOU BELIEVE THAT I CAN*"
DATA "PERHAPS YOU WOULD LIKE TO BE LIKE ME*"
DATA "YOU WANT ME TO BE ABLE TO*"
DATA "PERHAPS YOU DON''T WANT TO*"
DATA "DO YOU WANT TO BE ABLE TO*"
DATA "WHAT MAKES YOU THINK I AM*"
DATA "DOES IT PLEASE YOU TO BELIEVE I AM*"
DATA "PERHAPS YOU WOULD LIKE TO BE*"
DATA "DO YOU SOMETIMES WISH YOU WERE*"
DATA "DON''T YOU REALLY*"
DATA "WHY DON''T YOU*"
DATA "DO YOU WISH TO BE ABLE TO*"
DATA "DOES THAT TROUBLE YOU*"
DATA "DO YOU OFTEN FEEL*"
DATA "DO YOU OFTEN FEEL*"
DATA "DO YOU ENJOY FEELING*"
DATA "DO YOU REALLY BELIEVE I DON''T*"
DATA "PERHAPS IN GOOD TIME I WILL*"
DATA "DO YOU WANT ME TO*"
DATA "DO YOU THINK YOU SHOULD BE ABLE TO*"
DATA "WHY CAN''T YOU*"
DATA "WHY ARE YOU INTERESTED IN WHETHER OR NOT I AM*"
DATA "WOULD YOU PREFER IF I WERE NOT*"
DATA "PERHAPS IN YOUR FANTASIES I AM*"
DATA "HOW DO YOU KNOW YOU CAN''T*"
DATA "HAVE YOU TRIED?"
DATA "PERHAPS YOU CAN NOW*"
DATA "DID YOU COME TO ME BECAUSE YOU ARE*"
DATA "HOW LONG HAVE YOU BEEN*"
DATA "DO YOU BELIEVE IT IS NORMAL TO BE*"
DATA "DO YOU ENJOY BEING*"
DATA "WE WERE DISCUSSING YOU--NOT ME."
DATA "OH, I*"
DATA "YOU''RE NOT REALLY TALKING ABOUT ME, ARE YOU?"
DATA "WHAT WOULD IT MEAN TO YOU IF YOU GOT*"
DATA "WHY DO YOU WANT*"
DATA "SUPPOSE YOU SOON GOT*"
DATA "WHAT IF YOU NEVER GOT*"
DATA "I SOMETIMES ALSO WANT*"
DATA "WHY DO YOU ASK?"
DATA "DOES THAT QUESTION INTEREST YOU?"
DATA "WHAT ANSWER WOULD PLEASE YOU THE MOST?"
DATA "WHAT DO YOU THINK?"
DATA "ARE SUCH QUESTIONS ON YOUR MIND OFTEN?"
DATA "WHAT IS IT THAT YOU REALLY WANT TO KNOW?"
DATA "HAVE YOU ASKED ANYONE ELSE?"
DATA "HAVE YOU ASKED SUCH QUESTIONS BEFORE?"
DATA "WHAT ELSE COMES TO MIND WHEN YOU ASK THAT?"
DATA "NAMES DON''T INTEREST ME."
DATA "I DON''T CARE ABOUT NAMES --PLEASE GO ON."
DATA "IS THAT THE REAL REASON?"
DATA "DON''T ANY OTHER REASONS COME TO MIND?"
DATA "DOES THAT REASON EXPLAIN ANYTHING ELSE?"
DATA "WHAT OTHER REASONS MIGHT THERE BE?"
DATA "PLEASE DON''T APOLOGIZE!"
DATA "APOLOGIES ARE NOT NECESSARY."
DATA "WHAT FEELINGS DO YOU HAVE WHEN YOU APOLOGIZE?"
DATA "DON''T BE SO DEFENSIVE!"
DATA "WHAT DOES THAT DREAM SUGGEST TO YOU?"
DATA "DO YOU DREAM OFTEN?"
DATA "WHAT PERSONS APPEAR IN YOUR DREAMS?"
DATA "ARE YOU DISTURBED BY YOUR DREAMS?"
DATA "HOW DO YOU DO ...PLEASE STATE YOUR PROBLEM."
DATA "YOU DON''T SEEM QUITE CERTAIN."
DATA "WHY THE UNCERTAIN TONE?"
DATA "CAN''T YOU BE MORE POSITIVE?"
DATA "YOU AREN''T SURE?"
DATA "DON''T YOU KNOW?"
DATA "ARE YOU SAYING NO JUST TO BE NEGATIVE?"
DATA "YOU ARE BEING A BIT NEGATIVE."
DATA "WHY NOT?"
DATA "ARE YOU SURE?"
DATA "WHY NO?"
DATA "WHY ARE YOU CONCERNED ABOUT MY*"
DATA "WHAT ABOUT YOUR OWN*"
DATA "CAN YOU THINK OF A SPECIFIC EXAMPLE?"
DATA "WHEN?"
DATA "WHAT ARE YOU THINKING OF?"
DATA "REALLY, ALWAYS?"
DATA "DO YOU REALLY THINK SO?"
DATA "BUT YOU ARE NOT SURE YOU*"
DATA "DO YOU DOUBT YOU*"
DATA "IN WHAT WAY?"
DATA "WHAT RESEMBLANCE DO YOU SEE?"
DATA "WHAT DOES THE SIMILARITY SUGGEST TO YOU?"
DATA "WHAT OTHER CONNECTIONS DO YOU SEE?"
DATA "COULD THERE REALLY BE SOME CONNECTION?"
DATA "HOW?"
DATA "YOU SEEM QUITE POSITIVE."
DATA "ARE YOU SURE?"
DATA "I SEE."
DATA "I UNDERSTAND."
DATA "WHY DO YOU BRING UP THE TOPIC OF FRIENDS?"
DATA "DO YOUR FRIENDS WORRY YOU?"
DATA "DO YOUR FRIENDS PICK ON YOU?"
DATA "ARE YOU SURE YOU HAVE ANY FRIENDS?"
DATA "DO YOU IMPOSE ON YOUR FRIENDS?"
DATA "PERHAPS YOUR LOVE FOR FRIENDS WORRIES YOU."
DATA "DO COMPUTERS WORRY YOU?"
DATA "ARE YOU TALKING ABOUT ME IN PARTICULAR?"
DATA "ARE YOU FRIGHTENED BY MACHINES?"
DATA "WHY DO YOU MENTION COMPUTERS?"
DATA "WHAT DO YOU THINK MACHINES HAVE TO DO WITH YOUR PROBLEM?"
DATA "DON''T YOU THINK COMPUTERS CAN HELP PEOPLE?"
DATA "WHAT IS IT ABOUT MACHINES THAT WORRIES YOU?"
DATA "SAY, DO YOU HAVE ANY PSYCHOLOGICAL PROBLEMS?"
DATA "WHAT DOES THAT SUGGEST TO YOU?"
DATA "I SEE."
DATA "I''M NOT SURE I UNDERSTAND YOU FULLY."
DATA "COME COME ELUCIDATE YOUR THOUGHTS."
DATA "CAN YOU ELABORATE ON THAT?"
DATA "THAT IS QUITE INTERESTING."

'' DATA FOR FINDING RIGHT REPLIES
DATA 1,3,4,2,6,4,6,4,10,4,14,3,17
DATA 3,20,2,22,3,25,3
DATA 28,4,28,4,32,3,35,5,40,9,40
DATA 9,40,9,40,9,40,9,40,9
DATA 49,2,51,4,55,4,59,4,63,1,63
DATA 1,64,5,69,5,74,2,76,4
DATA 80,3,83,7,90,3,93,6,99,7,106,6
'
