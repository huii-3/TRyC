##  A partir de la  Respuesta Temporal al escalón con ganancia 0.5,
%    determinar la Función de Transferencia aproximada del sistema.
##  Determinar además el tiempo de establecimiento aproximado del sistema

clear all, close all, clc

pkg load control

% Del grafico vemos:
% - Sist de 2 orden
% - Suponemos que es criticamente amortiguado
%   (puede ser sobreamortiguado tambien)

% Usamos la formula de G de 1er orden, pero repartiendola en 2 polos iguales:
% G2 = K/(s*tau/2 + 1)^2 y tau=ts/4
% Si fuera de 1 orden podriamos usar el 63%
% K = Vfinal/Amp.esc = 3,5*2=7


% Retardo de 0.005s
% Esc de amplitud 0.5
% t establecimiento de 0.012s

s = tf('s')

Td = 0.005       % retardo
ts = 0.012 - Td  % sin retardo
K = 3.5/0.5      % valor final/amp esc
tau = ts/4


% Definimos la fdt

G1 = K/(s*(tau/2) + 1)^2
step(0.5*G1, 0.015)    % Respuesta al escalon de amplitud 0,5
                       % Graficamos hasta 0,015s

%En este grafico debo fijarme en 0.012-0.005, para comparar con la grafica de la tarea

