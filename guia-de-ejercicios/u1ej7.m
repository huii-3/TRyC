%EJERCICIO 7 APARTADO B

close all, clear all, clc

pkg load symbolic
pkg load control

syms R1 R2 R3 R4 R5 C1 C2 L1 AC1 AC2 AC3 s real
syms V1 V2 V3 real

%Transformacion de fuentes

I1 = V1/(R1 + 1/(s*C1))
I2 = V2/(R4)
I3 = V3/(R5)

%planteo matrices mediante nodos


mat_A =  [(1/(R1 + 1/(s*C1)) + 1/R2 + 1/R5) (-1/(R1 + 1/(s*C1))) (-1/R5);
          (-1/(R1 + 1/(s*C1))) (1/(R1 + 1/(s*C1)) + 1/(s*L1) +1/R4) (-1/R4);
          (-1/R5) (-1/R4) (1/R5 +1/R4 + 1/(R3+1/(s*C2)))] % siempre Aij = Aji

mat_B = [(I3);
         (I1);
         (I2)]

V_simb = (mat_A \ mat_B);

%simulacion

% valores componentes
R1_v = 100;
R2_v = 220;
R3_v = 150;
R4_v = 100;
R5_v = 180;
C1_v = 22e-6;
C2_v = 47e-6;
L1_v = 0.1;

% valores fuentes
V1_v = 12;
V2_v = 24;
V3_v = 10;

% Frecuencia de trabajo (50 Hz)
f = 50;
w = 2*pi*f;
s_v = i*w;

%sustituyo valores numericos

A_num = double(subs(mat_A, {R1, R2, R3, R4, R5, C1, C2, L1, s}, {R1_v, R2_v, R3_v, R4_v, R5_v, C1_v, C2_v, L1_v, s_v}))
B_num = double(subs(mat_B, {V1, V2, V3, R1, R4, R5, C1, s}, {V1_v, V2_v, V3_v, R1_v, R4_v, R5_v, C1_v, s_v}))
%B depende de I1, I2, I3, pero a su vez esas variables dependen de R1,R4,R5,C1,s

%calculo valores de V
V_num = A_num \ B_num


























