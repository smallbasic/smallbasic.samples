'rotating string test.bas 2015-06-04 B+
yes="yes ":no="no "
s="if mid(s+left(s,cut),cut+1)=mid(right(s,len(s)-cut)+s,1,len(s)) then print yes; else print no;"
print s
for cut=1 to len(s) 
   if mid(s+left(s,cut),cut+1)=mid(right(s,len(s)-cut)+s,1,len(s)) then print yes; else print no;
next