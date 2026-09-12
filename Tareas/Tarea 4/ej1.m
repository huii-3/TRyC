%  A partir de la Respuesta Temporal al escalón con ganancia 5,
%  determinar la Función de Transferencia aproximada del sistema

close all, clear all, clc

pkg load control

%definimos s
s= tf('s')

% Vemos del grafico que:
%  - El sist es de primer orden
%  - Hay un retardo de 100ms
%  - Ante el escalon de amplitud 5, termina en 95
%  - El tiempo de establecimiento es de 500ms


tr = 100; % retardo
ts = 500 - tr % sin el retardo
K = 95/5 %(valor final)/(amplitud del escalon)
tau = ts/4

% Definimos la fdt

G1 = K/(tau*s+1)
step(5*G1,ts) %hasta 400

%error en la estimacion del tau

%q lo pario octave no soporta sist con retardo



