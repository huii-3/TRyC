clear all, close all, clc

pkg load symbolic %para la fdt
pkg load control %para simular

%parametros simbolicos
syms m1 m2 K1 K2 B s F X1 X2 real
%F = F(s) ; X1 = X1(s) ; X2 = X2(s)

%ecuaciones

eq1 = F == m1*s^2*X1 + (K1+K2)*X1 - K2*X2
eq2 = 0 == m2*s^2*X2 + B*s*X2 - K2*X1 + K2*X2
%tambien podria haberlo escrito de la forma eq = m*a == sum(F)

%resuelvo ([ecuaciones],[icognitas])

sol = solve(eq1,eq2,X1,X2)

%encuentro las funciones de transferencia SIMBOLICAS
%sol.X1 : solucion para X1 ; sol.X2 : solucion para X2

G1 = collect(simplify(sol.X1/F),s)
G2 = collect(simplify(sol.X2/F),s)

%collect reordena la funcion de la tf segun las potencias de s

%SIMULACION

% le damos valores a los elementos del sistema
m1_v = 7
m2_v = 20
K1_v = 5
K2_v = 2
B_v = 14
F_esc_v = 15	% amplitud del escalon de la fuerza externa f(t)


% obtengo las fdt simbolicas con valores numericos sustituidos
G1_sust = subs(G1, {m1, m2, K1, K2, B}, {m1_v, m2_v, K1_v, K2_v, B_v})
G2_sust = subs(G2, {m1, m2, K1, K2, B}, {m1_v, m2_v, K1_v, K2_v, B_v})

%Separamos numerador y denominador de cada una
[num_G1_symb,den_G1_symb] = numden(G1_sust);
[num_G2_symb,den_G2_symb] = numden(G2_sust);

%pasamos a vectores de coeficientes
num_G1 = sym2poly(num_G1_symb);
num_G2 = sym2poly(num_G2_symb);
den_G1 = sym2poly(den_G1_symb);
den_G2 = sym2poly(den_G2_symb);

%Armamos las fdt NUMERICAS en paquete de control
G1_F = minreal(tf(num_G1,den_G1))
G2_F = minreal(tf(num_G2,den_G2))
%minreal cancela polos en comun

%Respuesta al escalon. En este caso sí podemos usar "step", pero tenemos que multiplicar por la amplitud del mismo
figure()	%nueva figura
subplot(1,2,1);	%armamos una "grilla" de figuras, 1 fila, 2 columnas, y seleccionamos la figura izquierda

%grid: agrega una cuadricula ; gridminor: agrega lineas secundarias
step(F_esc_v * G1_F), grid, grid minor
title("Respuesta de la masa 1"), ylabel('Amplitud [mt]')
%ylabel: nombre eje y

subplot(1,2,2);	%seleccionamos la figura derecha
step(F_esc_v*G2_F), grid, grid minor
title("Respuesta de la masa 2"), ylabel('Amplitud [mt]')
















