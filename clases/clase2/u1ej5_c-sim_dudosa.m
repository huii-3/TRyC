% UNIDAD 1 EJERCICIO 5C
clear variables, close all, clc

pkg load symbolic
pkg load control

% --- Simbolico ---
% OJO: s es compleja, no va con 'real' / 'positive'
syms R1 R2 C1 L1 Vin positive
syms s

% Impedancias
Z1 = R1;
Z2 = R2;
Z3 = 1/(s*C1);
Z4 = s*L1;

% Z equivalente entre nodo X y GND:
% rama C1 en paralelo con rama (R2+L1)
Z234 = ((Z2 + Z4)*Z3) / (Z2 + Z4 + Z3);

Vx = Vin * Z234/(Z1+Z234);
Vout = Vx * Z4/(Z2+Z4); % Vout sobre L1

fdt = simplify(Vout/Vin);
disp("FDT simbolica:")
pretty(fdt)

% --- Sustitucion numerica ---
vR1 = 10e3;
vR2 = 5e3;
vL1 = 10e-3;
vC1 = 25e-6;

fdt_num = subs(fdt, {R1,R2,C1,L1}, {vR1,vR2,vC1,vL1});
fdt_num = collect(expand(fdt_num), s);

[num_sym, den_sym] = numden(fdt_num);

num = sym2poly(num_sym);
den = sym2poly(den_sym);

G = tf(num, den);
G = minreal(G);

disp("G = "), G
disp("dcgain = "), dcgain(G)
disp("polos = "), pole(G)
disp("ceros = "), zero(G)

% --- Respuestas ---
figure(1);
step(12*G);
grid on;
title("Respuesta al escalon 12V - Vout sobre L1");
xlabel("t [s]"); ylabel("Vout [V]");

figure(2);
pzmap(G);
grid on;
title("Polos y ceros");

figure(3);
bode(G);
grid on;
