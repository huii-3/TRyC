close all, clear all, clc;

pkg load control;
pkg load symbolic;

syms i Va Vb real;

R1=28;
R2=8;
R3=4;

eq1 = 12 - 2*i == (1/R1 +1/R3)*Va + (-1/R3)*Vb
eq2 = 2*i == (-1/R3)*Va + (1/R3 + 1/R2)*Vb
eq3 = Va == i*R1


S = solve(eq1, eq2, eq3, i, Va, Vb);

disp('--------------------------------')
disp('El valor de la corriente i es:')

i_val = S.i
