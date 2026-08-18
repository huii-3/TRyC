clear all, close all, clc

pkg load symbolic
pkg load control

%resolucion por mallas
syms R1 R2 C1 L1 s Amp real

%si E1 es un escalon
E1= Amp/s;

%resolvemos la fdt
Z1 = ((R2+ s*L1)*(1/(s*C1))) / (R2+ s*L1 +(1/(s*C1)))
Vx_Vin = Z1/(R1+Z1)
Vout = Vx_Vin*s*L1/(R2+s*L1)

fdt = simplify(Vout/Vx_Vin)

%sin usar solve

%calculo la salida simbolica para simular
Vout_E1=simplify(fdt*E1)

%simluacion, paso al paquete de control
%sustituir variables simb por valores numericos

vR1=10e3;vR2=5e3;vL1=10e-3;vC1=25e-6;
vAmp=12;

v_Vout_E1= subs(Vout_E1, {R1,R2,C1,L1,Amp}, {vR1,vR2,vC1,vL1,vAmp})
v_Vout_E1= simplify(collect(v_Vout_E1,s))


%paso al paquete de control

[num,den]=numden(v_Vout_E1)

%vectores d coef
num=sym2poly(num)
den=sym2poly(den)

Vout_E1_c=tf(num,den)

%no sé si esta bien
impulse(Vout_E1_c)



