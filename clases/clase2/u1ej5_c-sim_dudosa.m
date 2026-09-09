%UNIDAD 1 EJERCICIO 5C

clear all, close all, clc

pkg load symbolic
pkg load control

%resolucion por mallas
syms R1 R2 C1 L1 Vin s real

%impedancias
Z1 = R1
Z2 = R2
Z3 = 1/(s*C1)
Z4 = s*L1

%Z equivalente entre nodo X y GND
Z234 = ((R2+ s*L1)*(1/(s*C1))) / (R2+ s*L1 +(1/(s*C1)))


Vx = Vin * Z234/(Z1+Z234)
Vout = Vx * Z4/(Z4+Z2) %Vout en funcion de Vin

fdt = simplify(Vout/Vin)

%sin usar solve

%simluacion, paso al paquete de control

%valores de elementos
vR1=10e3;
vR2=5e3;
vL1=10e-3;
vC1=25e-6;

%sustituyo variables simbolicas por valores numericos
fdt_num= subs(fdt, {R1,R2,C1,L1}, {vR1,vR2,vC1,vL1})
%con collect ordeno las potencias de s
fdt_num= simplify(collect(fdt_num,s))

%separo num y den
[num,den]=numden(fdt_num)

%transformo num y den a vectores de coeficientes
num=sym2poly(num)
den=sym2poly(den)

%hago la FdT
G = tf(num,den)

%veo la respuesta al escalon con amplitud 12
step(12*G)
%valor final:
dcgain(G)
p = pole(G)
z = zero(G)


%La respuesta al impulso es rara, capaz los valores de los componentes son el problema

