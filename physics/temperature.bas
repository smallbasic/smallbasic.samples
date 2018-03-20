
rem Title: temperature
rem Description: 
rem Category: Applications
rem Copyright: Andrei Besleaga
rem Email: andbes@mailsurf.com
rem Created: 05 February 2003
rem Version: 1.0
rem Sbver: 
'#!/usr/bin/sbasic -g
'' SmallBASIC Temperature Converter

'' (c)2003 - Andrei Besleaga

''

'' to demonstrate menus selection with pen/mouse
10 cls
print cat(1);"*** Temperature Converter ***";cat(0)
print " (c)2003 - Andrei Besleaga"
print
input "Temperature: ";temp
cls
print "convert from: ";temp;" degrees"
at 20,30
print "Celsius"
at 20,60
print "Fahrenheit"
at 20,90
print "Kelvin"
at 20,120
print "Rankine"
print
rect 10,25,100,50
rect 10,55,100,80
rect 10,85,100,110
rect 10,115,100,140
tfrom=getmenu
print tfrom;" to:"
delay 500
tto=getmenu
cls
print temp;" deg ";tfrom;" = ";tempout(temp,tfrom,tto);" deg ";tto
beep
print
print "calculate another ?"
print "   yes     no"
rect 10,45,55,65
rect 60,45,105,65
pen on
repeat
	if pen(0)
		x=pen(4):y=pen(5)
		if (y>45 and y<65) and ((x>10 and x<55) or (x>60 and x<105)) then 
			if x<55 then 
				goto 10
			else
				exit loop
			endif
		endif
	endif
until
pen off

func tempout(temp,tfrom,tto)
	if tfrom="Celsius" then
		if tto="Celsius" then tempout=temp
		if tto="Fahrenheit" then tempout= 1.80 * temp + 32
		if tto="Kelvin" then tempout= temp + 273.15
		if tto="Rankine" then tempout= 1.80 * (temp + 273.15)
	endif
	if tfrom="Fahrenheit" then
		if tto="Celsius" then tempout= 5 / 9 * (temp - 32)
		if tto="Fahrenheit" then tempout=temp
		if tto="Kelvin" then tempout= 5 / 9 * (temp - 32) + 273.15
		if tto="Rankine" then tempout=temp + 459.67
	endif
	if tfrom="Kelvin" then
		if tto="Celsius" then tempout= temp - 273.15
		if tto="Fahrenheit" then tempout= 1.80 * (temp - 273.15) + 32
		if tto="Kelvin" then tempout=temp
		if tto="Rankine" then tempout=1.80 * temp 
	endif
	if tfrom="Rankine" then
		if tto="Celsius" then tempout=temp / 1.80 - 273.15
		if tto="Fahrenheit" then tempout= temp - 459.67
		if tto="Kelvin" then tempout= temp/1.80
		if tto="Rankine" then tempout=temp
	endif
end

func getmenu
pen on
repeat
	if pen(0)
		x=pen(4):y=pen(5)
		if (x>10 and x<100) and ((y>25 and y<50) or (y>55 and y<80) or (y>85 and y<110) or (y>115 and y<140)) then 
			if y<50 then : getmenu="Celsius"
			elseif y<80 then : getmenu="Fahrenheit"
			elseif y<110 then : getmenu="Kelvin"
			elseif y<140 then : getmenu="Rankine"
			endif
			exit loop
		endif
	endif
until
pen off
end'
