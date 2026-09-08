close all, clear all, clc

%cargamos valores
R1 = 28; R2 = 8; R3 = 4;

A = [(1/R1+1/R3)*R1+2 -(1/R3); -(R1/R3)-2 (1/R2)+(1/R3)]
B = [12;0]

S=A\B
%matriz de 1 col y 2 filas
%S(1) es el valor de i
%S(2) es el valor de Vb

%la corriente i vale:
disp('la corriente i vale, en [A]')
S(1)


