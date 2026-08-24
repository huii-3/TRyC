clear all, close all, clc

pkg load symbolic
pkg load control

syms R1 C1 s real

%defino las impedancias
Z1 = R1
Z2 = 1/(s*C1)

%realcion entre Vout y Vin
V_rel = (Z2)/(Z1+Z2)

%simulacion

R1_v = 20
C1_v = 10

%sustituyo valores, simplifico y reordeno los terminos de s

V_rel_sust = collect(simplify(subs(V_rel, {R1, C1}, {R1_v, C1_v})),s)

%separo num y den
[V_rel_sust_num, V_rel_sust_den]= numden(V_rel_sust)

%convierto a vectores de coeficientes
num_V_rel = sym2poly(V_rel_sust_num)
den_V_rel = sym2poly(V_rel_sust_den)

%hago la fdt, cancelo polos
fdt_V_rel = minreal(tf(num_V_rel, den_V_rel))

%respuesta al escalon
figure()
step(fdt_V_rel)
