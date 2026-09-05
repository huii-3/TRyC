clear all, close all, clc

pkg load symbolic

syms R1 R2 R3 R4 L1 L2 C1 V1 V2 V3 real
syms I1 I2 I3 s

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

% 1. Valores de componentes
v_R1 = 10;
v_R2 = 20;
v_R3 = 15;
v_R4 = 5;
v_C1 = 100e-6;
v_L1 = 10e-3;
v_L2 = 20e-3;

% 2. Valores de fuentes
v_V1 = 12;
v_V2 = 24;

% 3. Frecuencia de trabajo (50 Hz)
f = 50;
w = 2 * pi * f;
v_s = 1i * w; % s = j*w para régimen permanente senoidal

%sustituimos los valores numericos

I_num = subs(I_sol, {R1,R2,R3,R4,C1,L1,L2,V1,V2,s}, {v_R1,v_R2,v_R3,v_R4,v_C1,v_L1,v_L2,v_V1,v_V2, v_s})

V_num = subs(V_sol, {R1,R2,R3,R4,C1,L1,L2,V1,V2,s}, {v_R1,v_R2,v_R3,v_R4,v_C1,v_L1,v_L2,v_V1,v_V2, v_s})

I_num = double(I_num)

V_num = double(V_num)




























