'Balls in 3D cube galileo.bas bpf 2015-05-16
pozx = 0
pozy = 0

while asc(inkey)<>27
	t = ticks
	cls
	rysuj()
	pozx = pozx + 2
	pozy = pozy + 2
	'showpage
	delay 10
wend
	

sub rysuj()
	a = pozx / 99
	b = pozy / 99
	for x = -1 to 1
		for y = -1 to 1		
			for z = -1 to 1
				y2 = y
				x2 = x * cos(a) - y2 * sin(a)
				y3 = x * sin(a) + y2 * cos(a)
				y2 = y3
				y3 = y2 * cos(b) - z * sin(b)
				z2 = y2 * sin(b) + z * cos(b)
				sx = 250 + x2 * (z2 + 2) * 35
				sy = 250 + y3 * (z2 + 2) * 35
				circle sx, sy, (z2 + 2) * 5 color rgb(200, 200, 0) filled
			next z		
		next y		
	next x
end sub