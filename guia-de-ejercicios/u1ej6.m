%EJERCICIO 6 APARTADO B

close all, clear all, clc

pkg load symbolic
pkg load control

syms R1 R2 R3 R4 R5 C1 C2 L1 AC1 AC2 AC3 s real
syms I1 I2 I3 real

%planteo matriz simbolica con mallas

A = [(R1 + 1/(s*C1) + s*L1 + R2) (-s*L1) (-R2);
     (-s*L1) (s*L1 + R4 + 1/(s*C2) + R3) (-R3 - 1/(s*C2));
     (-R2) (-R3 - 1/(s*C2)) (R2 + R3 + 1/(s*C2) + R5)]

B = [(AC1);
     (AC2);
     (AC3)]

I = A\B %si hago A/B se hace A^-1 sobre B


%simulacion
%valores componentes
R1_v = 100
R2_v = 150
R3_v = 220
R4_v = 100
R5_v = 180
C1_v = 22e-6
C2_v = 47e-6
L1_v = 0.1

%Valores fuentes
AC1_v = 12
AC2_v = 24
AC3_v = 10

% Frecuencia de trabajo (50 Hz)
f = 50;
w = 2 * pi * f;
s_v = i * w; % s = j*w para régimen permanente senoidal

% Pasaje del dominio de Laplace (variable "s") al dominio fasorial (regimen
% permanente senoidal). La matriz A fue armada con impedancias genéricas
% en "s" (1/(s*C) para capacitores, s*L para inductores). Para poder
% resolver el circuito con las fuentes AC dadas, hay que particularizar
% "s" al caso de una senoidal pura, que en fasores equivale a evaluar
% en s = j*w (j = unidad imaginaria, w = pulsación de las fuentes)

%calculo matrices numericas

A_num = double(subs(A, {R1, R2, R3, R4, R5, C1, C2, L1, s}, {R1_v, R2_v, R3_v, R4_v, R5_v, C1_v, C2_v, L1_v, s_v}))
B_num = double(subs(B, {AC1, AC2, AC3}, {AC1_v, AC2_v, AC3_v}))

% 4. Resolvemos el sistema fasorial directo
I_num = A_num \ B_num
