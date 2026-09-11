%UNIDAD 8 EJERCICIO 4
##a) Determinar las constantes de error de posición, velocidad y aceleración
##b) Determinar el error de estado estable para los distintos tipos de entradas.

close all, clear all, clc;

pkg load symbolic;

syms s Ro real

%defino la fdt
G1 = 50/((1+0.5*s)*(1+2*s))

%es un sistema tipo 0, porque tiene 0 polos en el origen

%definimos las constantes de error
Kp = G1
Kv = s*G1
Ka = (s^2)*G1

%calcular los errores
s = 0
Erp = eval(Ro/(1+Kp))
Erv = eval(Ro/Kv)
Era = eval((2*Ro)/Ka)

%--------------------------------------------------------------------

close all, clear all, clc;

pkg load symbolic;

syms s Ro real

G2 = 2/(s*(1+0.1*s)*(1+0.5*s))

%sistema tipo 1, tiene 1 polo en el origen

%definimos las constantes de error
Kp = G2
Kv = s*G2
Ka = (s^2)*G2

%calcular los errores
s = 0
Erp = eval(Ro/(1+Kp))
Erv = eval(Ro/Kv)
Era = eval((2*Ro)/Ka)












