%Limpio el entorno
clear all, close all, clc

pkg load control
pkg load symbolic

%Defino variables simbolicas
syms s X Y real

%Defino variables simbolicas
eq = 5*s^2*Y + 2*s*Y + 3*Y - 5*s*X - X

%Resolvemos: Despejamos Y=f(s,X)
Sol = solve(eq, Y)
G = simplify(Sol/X)


