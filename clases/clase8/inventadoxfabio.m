% ej inventado por fabio


close all, clear all, clc;

pkg load control;

G = zpk(-20, [1 -7 -12 -16], 0.5)
polos = pole(G)
ceros = zero(G)
n=4
m=1

%angulos de asintotas
Th0 = 180/abs(m-n)
Th1 = 3*180/abs(m-n)
Th2 = 5*180/abs(m-n)

%centroide
sig = (sum(real(polos))-sum(real(ceros)))/abs(n-m)


syms s;
% tengo q calcular los ptos de desprendimiento
f = factor(1/(s+20)-1/(s-1)-1/(s+7)-1/(s+12)-1/(s+16), 's')


despr = roots([3 148 2393 14120 20464])

expr = (s-1)*(s+7)*(s+12)*(s+16) + 0.5*K*


s = i*w
expr =expand(eval(expr))

eq1 = 10*x +



