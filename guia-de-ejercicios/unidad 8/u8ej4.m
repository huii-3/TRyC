%UNIDAD 8 - EJERCICIO 4

## Dado el siguiente sistema se pide:
## a) Determinar las constantes de error de posición, velocidad y
##    aceleración: Kp, Kv, Ka.
## b) Determinar el error de estado estable para los distintos
##    tipos de entradas


%              +
%   R(s) ---> (Σ)---> [ G(s) ] ---+---> C(s)
%              ^-                 |
%              |                  |
%              +------------------+
%          (         H(s)=1)

%Ejercicio 4.1
%.................................................................

clear all, close all, clc;
pkg load control;

%Defino la funcion de transferencia
s = tf('s')
G1 = 50/((1+0.5*s)*(1+2*s))     % vemos que es tipo 0
H1 = 1; %suponemos r.unitaria

%Defino las constantes de error
Kp = dcgain(G1*H1)
Kv = dcgain(minreal(s*G1*H1))
Ka = dcgain(minreal((s^2)*G1*H1))

%Calculo los errores
R0 = 1;
Erp = (R0/(1+Kp))
Erv = (R0/Kv)
Era = ((2*R0)/Ka)

% Como uso paquete de control, puedo usar step para ver como responde
% la salida frente a cada entrada

step(feedback(G1,H1));grid;grid minor;
title('Respuesta al escalon')
figure()
%la salida se estabiliza en un valor menor a 1

ramp(feedback(G1,H1));grid;grid minor;
title('Respuesta a la rampa')


%defino la tf de una parabola
figure()
par = (2*R0)/(s^3)
impulse(par*feedback(G1,H1));grid;grid minor;
title('Respuesta a la parabola')



%Ejercicio 4.2
%.................................................................

clear all, close all, clc;
pkg load control;

s = tf('s');

%Defino la funcion de transferencia:
G2 = 2/(s*(1+0.1*s)*(1+0.5*s));
H2 = 1;

%calculo de constantes:
Kp = dcgain(G2*H2)
Kv = dcgain(minreal(s*G2*H2))
Ka = dcgain(minreal((s^2)*G2*H2))

%Calculo los errores
R0 = 1
Erp = (R0/(1+Kp))
Erv = (R0/Kv)
Era = ((2*R0)/Ka)

step(feedback(G2,H2));grid;grid minor;
title('Respuesta al escalon')
figure()
%la salida se estabiliza en un valor menor a 1

ramp(feedback(G2,H2));grid;grid minor;
title('Respuesta a la rampa')


%defino la tf de una parabola
figure()
par = (2*R0)/(s^3)
impulse(par*feedback(G2,H2));grid;grid minor;
title('Respuesta a la parabola')


%Ejercicio 4.3
%.................................................................

close all, clear all, clc;
pkg load control;


%cargamos la fdt (G3)
s = tf('s')
G3 = 1/(s*(s^2+4*s+200))
H3 = 1

%calculamos las constantes Kp, Kv y Ka
Kp = dcgain(H3*G3)
Kv = dcgain(minreal(s*H3*G3))
Ka = dcgain(minreal(s^2*G3*H3))
                                %usamos dcgain porque estamos usando el
                                %paquete de control(obtengo numeros)

%calculamos los errores
Ro = 1; %amplitud 1

Erp = Ro/(1+Kp)
Erv = Ro/Kv
Era = 2*Ro/Ka

%respuestas a las entradas
% step(G3) es a lazo abierto

step(feedback(G3,H3,-1)); grid, grid minor;
title('respuesta al escalon')
figure()

ramp(feedback(G3,H3,-1));grid;
title('respuesta a la rampa')

%defino como sistema a la TL  de la parabola
par = (2*Ro)/(s^3)
figure()
impulse(par*feedback(G3,H3,-1));
title('respuesta a la parabola')


%Ejercicio 4.6
%.................................................................

pkg load symbolic; %uso simbolico porque no conozco K
syms s K real positive;

G6 = K/((1+s)*(1+10*s)*(1+20*s)) %tipo 0

%constantes de error
Kp = (G6)
Kv = (s*G6)
Ka = (s^2)*G6

%errores
s = 0;
R0 = 1
Erp = eval(R0/(1+Kp))
Erv = eval(R0/Kv)
Era = eval((2*R0)/Ka)


%dado este sistema calcule el valor de K de tal forma q el
%error de posicion con realimentacion unitaria sea menor
%que 0,33 ante un escalon unitario


% Erp = 1/(1+Kp) < 0.33

K_val = solve(Erp < 0.33 ,K);

disp('El valor de K para que Erp sea menor a 0.33 es:')
(K_val)























