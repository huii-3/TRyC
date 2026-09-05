close all, clear all, clc
pkg load symbolic

syms s K real

%cargamos las  fdt
G1= (s-100)/(s+10)
G2 = (s+100)/((s-100)*(s+5))

G12 = simplify(G1*G2)

%funciones del error

Kp = G12*K %H(s)=K en este caso
s=0
Erp = eval(1/(1+Kp))

%usamos solve para calcular el K para el error pedido
eq = Erp == 0.2
K = double(solve(eq,K))





