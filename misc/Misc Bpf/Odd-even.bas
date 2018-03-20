repeat
input "(0 <enter> to quit) Type a number (> 0) <enter> for odd-even report ";x
if x>0 then
   if int((x+1)/2)=int(x/2) then print x;" is even" else print x;" is odd"
endif
until x<=0