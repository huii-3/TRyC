%UNIDAD 6 - EJERCICIO 6

close all, clear all, clc

pkg load symbolic
pkg load control

%ec diferencial:
% (5*d^2y(t))/dt + (2*dy(t))/dt + 3y(t) - 5dx(t)/dt - x(t) =0
% pasando a laplace:
% (5*Y(s)*s^2) + (2*Y(s)*s) + 3*Y(s) = 5X(s)*s + X(s)
% Y(s)*(5s^2 + 2*s + 3) = X(s)*(5s + 1)
% G(s) = Y(s) / X(s)

s = tf('s')

G = (5*s + 1)/(5*s^2 + 2*s + 3)

p = pole(G)
z = zero(G)

step(G)


if real(p)<0
  disp('Sistema Estable')
else
  disp('Sistema Inestable')
endif




