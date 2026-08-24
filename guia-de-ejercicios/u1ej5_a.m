clear all, close all, clc

pkg load symbolic
pkg load control

syms R1 R2 R3 R4 real

%Req entre nodo X y masa
R234 = (R3*(R2+R4))/(R3+R2+R4)

%divisor de tension entre nodo X y Vout

Vout_Vx = (R4)/(R2+R4)

%divisor de tension entre Vin y nodo X

Vx_Vin = (R234)/(R1+R234)

%relacion entre Vin y Vout

V = simplify(Vout_Vx * Vx_Vin)

%simulacion, doy valores a R1,R2,R3,R4

R1_v = 100
R2_v = 100
R3_v = 200
R4_v = 100

%reemplazo valores en funcions simbolica
V_sust = subs(V, {R1, R2, R3, R4}, {R1_v, R2_v, R3_v, R4_v});

%convierto expresion simbolica a un nro real
V_num = double(V_sust)



