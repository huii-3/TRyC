clear all, close all, clc

pkg load control
pkg load symbolic

syms G1 G2 K1 K2 real

%principio de superposicion

%1)
S1 = G1/(1+G1*G2*K1*K2)

%2)
S2 = (G1*G2*K2)/(1-G1*G2*K1*K2)

%sumo ambas contribuciones
St = S1+S2

%simplifico
ST = simplify(St)

%simulacion

%asigno valores

G1_v = 1
G2_v = 1
K1_v = 4
K2_v = 2

%sustituyo

ST_sust = subs(ST,{G1, G2, K1, K2},{G1_v, G2_v, K1_v, K2_v})

ST_sust = double(ST_sust)




