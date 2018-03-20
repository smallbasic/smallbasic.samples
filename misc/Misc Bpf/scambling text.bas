m = ucase("This Message Shows You, That The Capabilities Of BASIC Are Great!")
split "A4,B8,E3,G6,I1,O0,S5",",",words
for w in words:m=translate(m,left(w,1),right(w,1)):next:? m
