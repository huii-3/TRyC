##   UNIDAD 7 - EJERCICIO 6
## a) determinar las funciones de transferencia entre la posición, velocidad y
##    aceleración de la masa con relación a la fuerza de entrada
##    sistema modulado por la ecuacion:
##    f(t) = M*a(t) + B*v(t) + K*x(t)

close all, clear all, clc;

pkg load symbolic;

syms M B K F X s real;

%planteo la ecuacion
eq = F == M*X*s^2 + B*X*s + K*X

%resuelvo para X(s)
Sol = solve(eq,X)

disp('Fdt de la posicion en relacion a la fuerza')
Gp = simplify(Sol/F)

%como V(s) = s*X(s):
disp('Fdt de la velocidad en relacion a la fuerza')
Gv = simplify((Sol)*s/F)

%como A(s) = s^2*X(s):
disp('Fdt de la aceleracion en relacion a la fuerza')
Ga = simplify((Sol*(s^2))/F)


disp('Todas comparten el mismo denominador porque es el mismo sistema fisico para todas las variables.')
