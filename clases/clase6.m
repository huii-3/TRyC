close all clear all, clc

pkg load control
pkg load symbolic

syms s K real positive %para no tener problemas con el limite


G1 = (s-100)/(s-+10)
G2 = (s+100)/((s-100)*(s+5))

%resolvemos la cascada G1-G2
Gt_la = simplify(G1*G2)

%Realimentacion no unitaria

Gt_la_unit = simplify(Gt_la/(1+Gt_la*K-Gt_la))

%constante y error de posicion

Kp = limit(Gt_la_unit,s,0,'right');
Erp = 1/(1+Kp)

%calculamos K para q el error sea 0.2
eq = Erp == sym(1)/sym(5)
K = solve(eq,K)
disp('======')
disp('valor de K para q el error a escalon unitario sea 0.2')
K = double(K)
disp('======')

