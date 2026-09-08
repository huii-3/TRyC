close all, clear all, clc

pkg load control

%nos piden la fdt
%tengo los valores
%entonces uso paquete de control

s = tf('s')
%cargo los valores de los elementos
R = 1000;
C = 1e-6;

%defino cada bloque

%sumador de salida(no es una fdt como tal)
K3 = 1;

%sistema de primer orden de erama superior
Zp = (R*1/(s*C))/(R+1/(s*C));
G1 = minreal((-1)*Zp / R) %integrador inversos

%simplificador inversor rama inferiortoK2 = 1;
K2 = 1;

%sistema de primer orden rama inferiorto
Div_volt = (R+1/(s*C))/(R + R + 1/(s*C))
G3 = minreal(Div_volt)

%bloque total sin realimentacion externa
Gt_la = minreal((-K3)*(G1-K2*G3))

%realimentamos
Gt = minreal(feedback(Gt_la,1))
