% UNIDAD 8 - EJERCICIO 9
%--------------------------------------------------------------------
%                   SISTEMAS SIN RETARDO

% Determinar la FdT de los sistemas cuyas respuestas temporales
%  al escalon unitario se muestran.

%--------------------------------------------------------------------
% SISTEMA 1

close all, clear all, clc;

pkg load control;

% vemos que es un sistema de 1er orden

s = tf('s');

K = 1
ts = 5e-4; % tiempo que tarda en alcanzar el 98% de su V. final
tau = ts / 4

G1 = K/(1+tau*s)

step(G1,8e-4); grid;


%--------------------------------------------------------------------
% SISTEMA 5

close all, clear all, clc;

pkg load control;

s = tf('s')

% vemos que es un sistema de 2 orden, subamortiguado

K = 1 %valor final
Vfinal = K;
Vmax = 1.3;
Mp = (Vmax - Vfinal)/Vfinal
Tp = 0.1 % tiempo donde alcanza el sobrepasamiento Mp
psita = (-log(Mp))/(sqrt(log(Mp)^2+pi^2))
wn = pi/(Tp*sqrt(1 - psita^2))

% calculamos la FdT
G5 = (K*wn^2)/(s^2+2*psita*wn*s+wn^2)

step(G5,0.45)


%--------------------------------------------------------------------
% SISTEMA 10

close all, clear all, clc;

pkg load control;

s = tf('s')

% vemos que es un sistema de 2 orden, sobreamortiguado
% lo podemos aproximar como un sistema de 1 orden,
% con 2 polos iguales

K = 1.2
ts = 3
tau = ts/4


G10 = K/(((tau/2)*s + 1)^2)

step(G10,4.5)


%--------------------------------------------------------------------
%                   SISTEMAS CON RETARDO

% SISTEMA 12

close all, clear all, clc;

pkg load control;

s = tf('s')

% vemos que se trata de un sistema de 1er orden

K = 95
tr = 100; % tiempo de retardo
ts = 500-tr % sin retardo
tau = ts/4

G12 = K/(tau*s + 1)

step(G12,500)


%--------------------------------------------------------------------

% SISTEMA 14

close all, clear all, clc;

pkg load control;

s = tf('s')

% vemos que es un sistema de 2do orden, subamortiguado

tr = 0.6
K = 2
Vfinal = K;
Vmax = 2.4
Mp = (Vmax-Vfinal)/(Vfinal)
Tp = 1.5 - tr

psita = (-log(Mp))/(sqrt(log(Mp)^2 + pi^2))
wn = pi/(Tp*sqrt(1-psita^2))

G14 = (K*wn^2)/(s^2+2*wn*psita*s + wn^2)

step(G14,4)


%--------------------------------------------------------------------

% SISTEMA 16

close all, clear all, clc;

pkg load control;

s = tf('s')

%vemos que es un sistema de 2 orden, sobreamortiguado
% lo podemos aproximar como un sistema de 1 orden, con 2 polos iguales

K = 3.5
tr = 0.005 % tiempo de retardo
ts = 0.012 - tr % tiempo que tarda en alcanzar el 98% de su vf - tiempo de retardo
tau = ts/4


G16 = K/(((tau/2)*s + 1)^2)

step(G16,0.02)



















