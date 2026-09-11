clear all, close all, clc

pkg load symbolic

syms R1 R2 R3 R4 L1 L2 C1 V1 V2 V3 real
syms I1 I2 I3 s amp_esc amp_sen  w real

%MALLAS
%para tener la matriz de la forma A*I=B

A = [(1/(s*C1) + R3 + R1) (-R3) (-R1);
     (-R3) (R3+s*L2+R2) (-R2);
     (-R1) (-R2) (R4 + s*L1 + R1 + R2)]

B = [0;
    -V2;
    V1]

I = [I1;
     I2;
     I3]

%resolvemos simbolicamente

I_sol = A\B


%NODOS

%admitancias equivalentes luego de trans. fuentes

Y1 = 1/(R4+s*L1)
Y2 = 1/(s*L2)

%matriz de nodos

mat_A = [(1/R1 + s*C1 + 1/(R4+s*L1)) (-s*C1) (-1/(R4+s*L1));
         (-s*C1) (1/R3+s*C1+1/s*L2) (-1/s*L2);
         (-1/(R4+s*L1)) (-1/(s*L2)) (1/(R4+s*L1+1/R2+1/(s*L2)))]

mat_B = [(V1*Y1);
         (V2*Y2);
         (-V1*Y1-V2*Y2)]

mat_V = [V1;
         V2;
         V3]

%resolvemos nodos simbolicamente

V_sol = mat_A\mat_B


%SIMULACION

%suponemos que E1 es un escalon de amplitud 12 y E2 es una sinusoide

%transformadas de E1 y E2
V1_v = amp_esc / s
V2_v = (amp_sen*w)/(s^2+w^2)

% 1. Valores de componentes
v_R1 = 100;
v_R2 = 20;
v_R3 = 40;
v_R4 = 60;
v_C1 = 10e-6;
v_L1 = 20e-3;
v_L2 = 50e-3;

% 2. Valores de fuentes
v_amp_esc=12;
v_amp_sen=5;

%sustituimos los valores numericos

I_num = subs(I_sol, {R1,R2,R3,R4,C1,L1,L2,V1,V2}, {v_R1,v_R2,v_R3,v_R4,v_C1,v_L1,v_L2,V1_v,V2_v});
I_num = simplify(subs(I_num, {amp_esc, amp_sen}, {v_amp_esc, v_amp_sen}))

V_num = subs(V_sol, {R1,R2,R3,R4,C1,L1,L2,V1,V2}, {v_R1,v_R2,v_R3,v_R4,v_C1,v_L1,v_L2,V1_v,V2_v});
V_num = simplify(subs(V_num, {amp_esc, amp_sen}, {v_amp_esc, v_amp_sen}))



























