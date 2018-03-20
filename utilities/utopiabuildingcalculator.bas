
'cls
?"Utopia Building Calculator v1.0"
?"Programmed 28.09.2004"
?"by Carsten in SMALLBASIC (See Smallbasic HP for contact)"
?"Utopia Online Game http://www.swirve.com"
?"SmallBASIC : http://smallbasic.sourceforge.net/"
?
?"Just to calc your buildings for a given strategy ..."
?"You enter your actual acreage and it gives you"
?"just the number of buildings you should have"
?"regarding a break of strat at 800 acres ..."
?
?"You can easily adapt for your own strat ..."
?
input "Acres you own now : ",nacr
?
?"You should have "

if nacr>800 then restore OverData else restore LowData

repeat
 read txt,per
 if txt<>"NOP" then ?txt," : ",int(nacr*per/100)
until txt = "NOP"

END

label LowData
DATA "Homes      ",3.7
DATA "Farms      ",10
DATA "Mills      ",12.5
DATA "Banks      ",22.5
DATA "Guilds     ",12.5
DATA "Towers     ",3.8
DATA "Watchtowers",10
DATA "Libraries  ",25
DATA "NOP",0

label OverData
data "Farms      ",10
data "Barracks   ",10
data "Forts      ",10
data "Banks      ",15
data "Hospitals  ",12
data "Guilds     ",8
data "Towers     ",5
data "Watchtowers",10
data "Taverns    ",10
data "Stables    ",8
data "Dungeons   ",2
DATA "NOP",0
'
