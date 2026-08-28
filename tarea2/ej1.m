clear all, close all, clc

pkg load symbolic

syms I Vab Vin real

%definir las ecuaciones
eq1 = 12*I == Vin+2*I
eq2 = 6*I == Vab

S = solve(eq1, eq2, Vab, I);

fdt = simplify(S.Vab/Vin)

fdt = double(fdt)

