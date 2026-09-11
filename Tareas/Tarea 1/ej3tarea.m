close all, clear all, clc

pkg load symbolic;
pkg load control;

syms R1 R2 R3 R4 L1 L2 C1 E1 E2 s real;
syms I1 I2 I3 amp_esc amp_sen w real;

%cargamos las ecuaciones

eq1 = 0 == I1*(1/(s*C1) + R3 + R1) + I2*(-R3)+ I3*(-R1) %malla 1
eq2 = -E2 == I1*(-R3) + I2*(R2+R3+s*L2) + I3*(-R2) %malla 2
eq3 = E1 == I1*(-R1) + I2*(-R2) + I3*(R4 + s*L1 + R1 + R2) %malla 3

%resolvemos el sistema
sol = solve(eq1, eq2, eq3, I1, I2, I3)
%creamos una estructura de datos de elementos simbolicos
%ahora tenemos las soluciones en simbolico

%invocamos cada elemento de la estructura de datos
sol_I1 = simplify(sol.I1)
sol_I2 = simplify(sol.I2)
sol_I3 = simplify(sol.I3)

%simulamos

%suponemos que E1 es un escalon de amplitud 12 y E2 es una sinusoide

%transformadas de E1 y E2
E1 = amp_esc / s
E2 = (amp_sen*w)/(s^2+w^2)


%le damos valores a los elementos
R1_v=100;
R2_v=20;
R3_v=40;
R4_v=60;
C1_v=10e-6;
L1_v=20e-3;
L2_v=50e-3;
amp_esc_v=12;
amp_sen_v=5;

%tomamos cada expresion de las soluciones y sustituimos

I1_num = simplify(subs(sol_I1, {R1, R2, R3, R4, L1, L2, C1, amp_esc, amp_sen}, {R1_v, R2_v, R3_v, R4_v, L1_v, L2_v, C1_v, amp_esc_v, amp_sen_v}))
I2_num = simplify(subs(sol_I2, {R1, R2, R3, R4, L1, L2, C1, amp_esc, amp_sen}, {R1_v, R2_v, R3_v, R4_v, L1_v, L2_v, C1_v, amp_esc_v, amp_sen_v}))
I3_num = simplify(subs(sol_I3, {R1, R2, R3, R4, L1, L2, C1, amp_esc, amp_sen}, {R1_v, R2_v, R3_v, R4_v, L1_v, L2_v, C1_v, amp_esc_v, amp_sen_v}))



