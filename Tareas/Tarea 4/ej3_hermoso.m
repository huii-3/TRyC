close all, clear all, clc;

pkg load control;
pkg load symbolic;

##defino variables
R = 1e3;
C = 1e-6;
s = tf('s');
Zc = 1/(s*C);
Zeq = (R*Zc)/(R+Zc); % Zeq de AO integrador

## G1 -- integrador
K_int = -(Zeq/R);
G1 = minreal(K_int)

## G3 = Div_V y Buffer
Z_div = R + 1/(s*C)
Div_V = Z_div/(Z_div+R); % divisor de tension entre R3 y (R4+C2)
K_buffer = 1;

G3 = minreal(K_buffer * Div_V)

## K2 -- inversor

K_inv = -R/R

## K3 --  sumador

K_sum = -1

% G de lazo abierto:

G_la = minreal((G1 + G3*K_inv) * K_sum)

## AO diferencial

K_dif = (R/(R+R))*(1+(R/R))

% cierro el lazo

G = minreal(K_dif*feedback(G_la,1))










