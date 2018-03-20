
'''19.09.2004
''Rotierende Linie - nur zum Spass
''Autor: Carsten
''Kontakt via SB-Homepage / Forum
''
cls
main
end

sub main()
randomize

init

ende=0
repeat
 linie
 if iy=0 then
  init
 fi
until ende

end


sub linie()
line x1+ix, y1+iy, x2-ix, y2-iy
if (x1+ix)<=(x2-ix) then iy = iy + 2
if (x1+ix)>(x2-ix) then iy = iy - 2
ix++:ix++
end

sub init()
ix=0
iy=0
x1=rnd*xmax
y1=rnd*(ymax/2)+(ymax/4)
l=rnd*(xmax/6)+(xmax/6)
x2=x1+l
y2=y1
color rnd*15+1
end'
