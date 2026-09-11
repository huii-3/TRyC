% UNIDAD 8 - EJERCICIO 8

% Esbozar la respuesta temporal de los sistemas caracterizados
% por las siguientes funciones de transferencia.

%.....................................................................
% Ejercicio 8.1

close all, clear all, clc;

pkg load control;

%defino la fdt

s = tf('s');
G1 = 15/(5*s+1)

disp('polos del sistema original')
pole(G1)
step(G1)

%.....................................................................
% Ejercicio 8.6

close all, clear all, clc;

pkg load control;
pkg load symbolic;


s = tf('s');
G6 = 625/(s^2+60*s+625)
disp('polos del sistema original')
pole(G6)
step(G6);

%Veo q el valor final es 1
%y que es un sistema de 2do orden sobreamortiguado


%.....................................................................
% Ejercicio 8.12

close all, clear all, clc

pkg load symbolic
pkg load control

s= tf('s')
G12 = 0.1875/(s^2 + 0.35*s + 0.0625)

disp('polos del sistema original')
pole(G12)
step(G12)

%veo que es un sistema subamortiguado, ya que tiene un sobrepasamiento
% se amortigua y llega a un valor final cte

%.....................................................................
% Ejercicio 8.16

close all, clear all, clc

pkg load symbolic
pkg load control

s= tf('s')
G16 = 0.0625/(s^2 + 0.0625)

disp('polos del sistema original')
pole(G16)
step(G16)

% veo que es un sistema no amortiguado, ya que oscila
% sin amortiguarse nunca (amplitud constante)

%.....................................................................
% Ejercicio 8.19

close all, clear all, clc

pkg load symbolic
pkg load control

s= tf('s')
G19 = 2/((3*s+1)^2)

disp('polos del sistema original')
pole(G19)
step(G19)

%veo que es un sistema sobreamortiguado ya que tiene un punto
%de inflexion (cambia la concavidad), y no hay sobrepasamiento.









