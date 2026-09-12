close all, clear all, clc

pkg load control

% Nos piden la fdt
% Tengo los valores
% Entonces uso paquete de control

s = tf('s')
% Cargo los valores de los elementos
R = 1000;
C = 1e-6;

% Defino cada bloque

%sumador de salida(no es una fdt como tal)
% U2:A
K3 = 1;

% Sistema de primer orden de rama superior
% U1:A
Zeq = (R * 1/(s*C))/(R + 1/(s*C));
G1 = minreal((-1)* Zp/R) % Integrador inverso:
                         %    G = -Zf/Zin

% Inversor rama inferior: K2 = 1 ; no pongo el signo aun
K2 = 1;

%Sistema de primer orden rama inferior
% U1:B:
Div_V = (R+1/(s*C))/(R + R + 1/(s*C))
G3 = minreal(Div_V)

% G3 es un buffer de tension, pero como antes tengo el divisor
% de tension, queda G3 = Div_V


% Bloque total sin realimentacion externa:
% Gt_la = -(VA+VC) Con: VA = G1
%                       VC = -K2*G3
Gt_la = minreal((-K3)*(G1-K2*G3))

%Cerramos el lazo:
Gt = minreal(feedback(Gt_la,1))
