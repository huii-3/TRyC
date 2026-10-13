% TAREA 6
% -----------------------------------------------------------------------------
% tarea 1 :encontrar los parametros admitancia cuando m = 2/3

clear all, close all, clc;

pkg load control;
pkg load symbolic;

% definimos variables

Z1 = 4;
Z2 = 2;
Z3 = 3;

% 1) V2 = 0
V1 = 1; %valor arbitrario

% Y11
I1 = V1/(Z1+Z2);
Y11 = I1/V1;

% Y21
I2 = -I1;
Y21 = I2/V1;

% 2) V1 = 0
V2 = 1; % valor arbitrario

% Y12
syms Vx real;
eq1 = 0 == Vx/4 + (2/3)*V2 + Vx/2 - V2/2;   % planteo ec de nodos
sol_Vx = solve(eq1,Vx);                     % resuelvo para encontrar el valor de Vx

I1 = sol_Vx/Z1;
Y12 = I1/V2;

% Y22
I2 = V2/Z3 + (sol_Vx-V2)/Z2;
Y22 = I2/V2;

Y11, Y12, Y21, Y22


%------------------------------------------------------------------------------
% tarea 2: encontrar los parametros impedancia

clear all, close all, clc;

pkg load symbolic;

syms R1 R2 b real;


% 1) I2 = 0
V1 = 1; %valor arbitrario

%Z11

I1 = V1/R1;
Z11 = simplify(V1/I1)

%Z21

i = -I1;
V2 = V1 - b*i;
Z21 = simplify(V2/I1)

% 2) I1 = 0
V2 = 1; %valor arbitrario

% Z12
syms I2 real;
i = -I2;
V1 = I2*R1;
Z12 = V1/I2

% Z22

eq2 = V2 + b*i == I2*(R1+R2);

sol_I2 = solve(eq2, I2);

Z22 = V2/sol_I2























