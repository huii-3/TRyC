clear all, close all, clc

pkg load symbolic
pkg load control

syms R1 R2 C1 L1 s real

%impedancias
Z1 = R1
Z2 = R2
Z3 = 1/(s*C1)
Z4 = s*L1

%impedancia eq entre nodo X y masa
Z234 = (Z3 * (Z2+Z4))/(Z3+Z2+Z4)

%relacion entre Vx y Vin
Vx_Vin = (Z234)/(Z1+Z234)

%relacion entre Vout y Vx
Vout_Vx = (Z4)/(Z2+Z4)

%relacion entre Vout y Vin

V_rel = (Vx_Vin*Vout_Vx)

%simulacion

%asigno valores a las impedancias
R1_v = 10
R2_v = 10
C1_v = 0.05
L1_v = 2

%sustituyo en funcion simbolica, simplifico y reordeno las potencias de s

V_rel_sust = collect(simplify(subs(V_rel, {R1,R2,C1,L1}, {R1_v,R2_v,C1_v,L1_v})),s)


%separo num y den

[num_V_rel_sust, den_V_rel_sust]=numden(V_rel_sust)

%convierto a vector de coeficientes

num_V=sym2poly(num_V_rel_sust)
den_V=sym2poly(den_V_rel_sust)

%hago la fdt

F_V_rel = minreal(tf(num_V, den_V))

%respuesta al escalon
figure()
step(F_V_rel)









