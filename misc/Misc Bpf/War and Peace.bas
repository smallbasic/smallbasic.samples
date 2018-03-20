' War and Peace, 10/29/14 revised 10/31/14, mga1

' My first attempt to get a file up to GitHub 10/30/14, I already have it described with Readme
' 10/31/14 issue of possibility of drawing from empty deck is fixed here

' The function could prove handy for any BASIC Gamer
' You can add your own Timer and make it a game of speed and accuracy, blah, blah, blah
' I just want to prove you don't have to shuffle the cards

'For MS Small Basic, where you see Print or ? substitute TextWindow.(I forget the rest)
' FI is End IF, ELIF is ElseIF, I am not remembering the new terms that well
' RND is Math.(something)



func CardString(byref DeckNum, byref ValueNum)
  ' By the way, function assumes global array Deck()
  local cardx, direction, suitS, limit
  
  cardx=floor((52)*rnd)+1
  if deck(cardx)=1 then 'card already drawn deal with it!
    limit=0
    direction=rnd 'flip coin heads we go up, tails down
    if direction<.5 then direction=-1 else direction=1
    while deck(cardx)=1
      cardx=cardx+direction
      if cardx>52 then cardx=1
      if cardx<1 then cardx=52
      limit=limit +1
      if limit=53 then exit
    wend
  fi
  if limit>52 then 
    CardString="Deck is empty.":DeckNum=0:ValueNum=0
    Exit
  fi  
  deck(cardx)=1 : DeckNum=cardx 'now make card presentable
  if cardx<14 then 
    suitS=" of Hearts":ValueNum =cardx
  elif cardx<27
    suitS=" of Spades":ValueNum=cardx-13
  elif cardx<40
    suitS=" of Diamonds":ValueNum=Cardx-26
  else
    suitS=" of Clubs":ValueNum=Cardx-39
  fi
  if ValueNum=1 then 
    ValueNum=14 :CardString="Ace"+SuitS
  elif ValueNum=13  
    CardString="King"+suitS
  elif ValueNum=12 
    CardString="Queen"+suitS
  elif ValueNum=11 
    CardString="Jack"+suitS
  else
    CardString=Str(ValueNum)+suitS
  fi
end

'=======================main ** War and Peace.bas **
option base 1
Dim Deck(52)
randomize timer
DN=0:CV=0:player=0:miss=0:game=0

cls:?:? "In War: when there is a tie, Clubs > Diamonds > Spades > Hearts"
?:? "In Peace: when there is a tie, Hearts > Spades > Diamonds > Clubs"
?:Input "War = (w enter) or Peace = just (enter)";i
if ucase(i)="W" then war=1
for game = 1 to 26
  cls:?
  If war then 
    ? "War: Clubs > Diamonds > Spades > Hearts":? 
  Else 
    ? "Peace: Hearts > Spades > Diamonds > Clubs":? 
  Fi
  ?"Player = "+Player+"   Dealer = ";Game-1-player;"   Miss = ";miss:?
  Currentwinner="D"
  card1=cardstring(DN,CV):dn1=DN:cv1=CV
  card2=cardstring(DN,CV):dn2=DN:cv2=CV
  if cv1=cv2 then 
    if (dn1>dn2)
      if war=1 then player=player+1:CurrentWinner="P"
    else
      if war=0 then player=player+1:CurrentWinner="P"
    fi
  elif cv1>cv2
    player=player+1:CurrentWinner="P"
  end if        
  ?:?"p=Player has ";card1;"  d=Dealer has ";card2:?
  Input "Who won, p or d (or q=quit)";i
  if Ucase(i)="Q" then
    exit
  else
    If ucase(i)<>CurrentWinner then miss=miss+1
  fi   
next game
cls 
?:?"Player = "+Player+"   Dealer = ";Game-player-1:?
? "In saying who was the winner,":?
? "Player was incorrect ";miss;" times.":?
? "Do you think the dealer dealt honestly and randomly?":?
input;i
?
?"OK, thanks for playing!"
end


