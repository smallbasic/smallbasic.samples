
'************************************************************************ 
'* Autor: Luis A. Díaz * 
'* Programa para calcular el dia de una fecha * 
'************************************************************************ 

INPUT "Introduzca la fecha DD/MM/AAAA";fecha 
'extraer el dia, el mes y el año 
primero = instr(1, fecha, "/") 
segundo = instr(4, fecha, "/") 
dia = left(fecha, primero -1) 
año = right(fecha, 4) 
mes = mid(fecha, primero+1, segundo-primero-1) 

'calculo del digito 1 
digito1 = val(dia) 

'calculo del digito 1 
digito2 = val(right(fecha,2)) 

'calculo del digito3 
'comprobacion de si es bisiesto o no 

if ((año % 4 == 0 AND año % 100 != 0) OR año % 400 == 0) THEN 
bisiesto = 1 
else 
bisiesto = 0 
endif 


Select case mes 
case 1 
if bisiesto = 0 then 
digito3 = 0 
else 
digito3 = 6 
endif 

case 2 
if bisiesto = 0 then 
digito3 = 3 
else 
digito3 = 2 
endif 
case 3 
digito3 = 3 
case 4 
digito2 = 6 
case 5 
digito3 = 1 
case 6 
digito3 = 4 
case 7 
digito3 = 6 
case 8 
digito3 = 2 
case 9 
digito3 = 5 
case 10 
digito3 = 0 
case 11 
digito3 = "3" 
case 12 
digito3 = 5 
end select 

'digito 4 
digito4 = val(left(año,2)) 
digito4 %= 4 
digito4 -= 3 
digito4 *= -2 

'digito 5 
año5 = right(año,2) 
digito5 = año5 \ 4 

digito = val(digito1) + val(digito2) + val(digito3) + val(digito4) + val(digito5) 
print "digito=";digito 
digito %= 7 

if digito = 0 then dia2 = "Domingo" 
if digito = 1 then dia2 = "Lunes" 
if digito = 2 then dia2 = "Martes" 
if digito = 3 then dia2 = "Miércoles" 
if digito = 4 then dia2 = "Jueves" 
if digito = 5 then dia2 = "Viernes" 
if digito = 6 then dia2 = "Sabado" 


print "El "; fecha; " es ";dia2 

end 

