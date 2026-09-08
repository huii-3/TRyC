close all, clear all, clc;

pkg load symbolic;

syms K1 K2 B1 B2 X1 X2 M1 M2 U s real;

%planteo ecuaciones de cada m1 y m2 respectivamente
eq1 = M1*X1*s^2 == -K1*X1 - B2*X1*s + B2*X2*s
eq2 = M2*X2*s^2 == -B2*X2*s + B2*X1*s + U - K2*X2 - B1*X2*s

%de las ecuaciones 1 y 2 necesito la solucion para X1 y para X2
S = solve(eq1, eq2, X1, X2)

%fdt que relaciona la entrada U(s) con X1(s)
fdt1 = simplify(S.X1/U)
%fdt que relaciona la entrada U(s) con X2(s)
fdt2 = simplify(S.X1/U)




