 %limpieza entorno
 close all, clear all, clc

 pkg load symbolic
 pkg load control

 %defino variables simbolicas
 syms s X Y real

 eq = 5*s^2*Y + 2*s*Y + 3*Y - 5*s*X - X == 0

 Sol = solve(eq, Y)
 G_sym = simplify(Sol/X)

 %separamos numerador y denominador
 [num_sym, den_sym] = numden(G_sym)

 %obtener los vectores de coeficientes
 num = sym2poly(num_sym)
 den = sym2poly(den_sym)

 %cargamos G con el paquete de control
 s=tf('s')
 G = tf(num,den)
 p=pole(G)
 %aplicamos el TVF a la rspuesta al escalon
step(G)
 dcgain(G)

