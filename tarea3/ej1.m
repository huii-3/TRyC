close all, clear all, clc

pkg load symbolic

syms s K1 K2 R0 real

%cargamos las fdt
G1 = 100/(0.2*s + 1)
G2 = 1/(20*s)

G1p = simplify(G1/(1+G1*K2))
Gt_la = simplify(K1*G1p*G2)

%errores
%symbolic -- eval (o subs)
%control -- dcgain
Kp = Gt_la
Kv = s*Gt_la
Ka = (s^2)*Gt_la

s=0
Erp=simplify(R0/(1+Kp))
Erv=simplify(eval(eval(R0/Kv)))
Era=simplify(eval((2*R0)/Ka))

%K1=50 y calculamos el Erv
K1 = 50
Erv_K1_50 = eval(Erv)

%piden Erv = 5.004

%2*K2/5 + 1/250 = 5.004
%2*K2/5 = 5.004 - 1/250
%K2 = (5.004 - 1/250)*(5/2)

%con solve

eq= Erv_K1_50 == 5.004
K2_solve = double(solve(eq,K2))


