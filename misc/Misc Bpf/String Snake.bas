'String Snake.bas 2015-06-20 B+
Message="Basic programming Forum has it's ups and downs."
message=message +" What a roller coaster ride!"
message=message +" Wait...  what happened to the contents of my stomach?"
x=0:y=300
color 14,0:cls
for i=1 to len(message)
   c=i mod 4
   select case c
      case 0:color 14
      case 1:color 12
      case 2:color 11
      case 3:color 9
   end select
   at i*8,y+i*cos(rad(i*20)):print mid(message,i,1)
   x=x+10
next