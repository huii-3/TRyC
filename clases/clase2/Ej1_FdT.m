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

%la fdt simbolica sera:
G_sym = simplify(Sol/X)

%separo num y den
[num_sym, den_sym] = numden(G_sym) %siguen siendo expresiones simbolicas

%convierto a vectores de coeficientes
num = sym2poly(num_sym)
den= sym2poly(den_sym)

%fdt
G = tf(num,den)

%G_sym y G en la cw se ven identicas pero no son lo mismo
%Gsym es la FdT simbolica
%G es la FdT para usar en el paquete de control (step, pole, zero, dcgain)
%(no puedo hacer step(G_sym)

step(G)
p = pole(G)
z = zero(G)
dcgain(G)


