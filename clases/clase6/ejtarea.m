close all, clear all, clc

pkg load control
pkg load symbolic

syms s K real positive %para no tener problemas con el limite


G1 = (s-100)/(s+10)
G2 = (s+100)/((s-100)*(s+5))

%resolvemos la cascada G1-G2
Gt_la = simplify(G1*G2)

%Realimentacion no unitaria(no es valido aplicar la formula de G/1+G*H

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
disp('======') %hasta aca el ejercicio


disp('verificacion con paquete de control')
Gt_la_symb = eval(Gt_la_unit) %reemplaza el valor de K calculado
                              %sigue siendo simbolico(sigue estando s)
[num_s,den_s] = numden(Gt_la_symb)
num = sym2poly(num_s)
den = sym2poly(den_s)
Gt_la_unit_ctrl = tf(num,den)
step(feedback(Gt_la_unit_ctrl,1),1), hold on, grid, grid minor
step(tf(1),1)

