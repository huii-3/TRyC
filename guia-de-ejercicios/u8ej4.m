close all, clear all, clc
pkg load symbolic
pkg load control


%cargamos la fdt (G3)
s = tf('s')
G3 = tf(1, [1 4 200 0])
H3 = 1
%calculamos las constantes Kp, Kv y Ka

Kp = dcgain(H3*G3)
Kv = dcgain(minreal(s*H3*G3))
Ka = dcgain(minreal(s^2*G3*H3))

%calculamos los errores

Ro = 1
Erp = Ro/(1+Kp)
Erv = Ro/Kv
Era = 2*Ro/Ka

%respuestas a las entradas
% step(G3) es a lazo abierto

step(feedback(G3,H3,1500)); grid, grid minor
title('respuesta al escalon')
figure()
ramp(feedback(G3,H3));grid
title('respuesta a la rampa')


%defino como sistema a la TL  de la parabola
par = 2/(s^3)
figure()
impulse(par*feedback(G3,H3))
title('respuesta a la parabola')


syms s K real

G6 = K/((1+s)*(1+10*s)*(1+20*s))

%H6=1
s = 0;

%ctess y error de posicion
Kp = eval(G6)
Erp = 1/(1+Kp)

%cctes y error de velocidad
Kv = eval(s*G6)
Erv = 1/Kv

%ctes y error de aceleracion
Ka = eval((s^2)*G6)
Era = 2/Ka

%dado este sistema calcule el valor de K de tal forma q el error de posicion
%con realimentacion unitaria sea menor
%que 0,33 ante un escalon unitario





















