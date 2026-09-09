close all, clear all, clc;

pkg load symbolic;

% a) Encontrar las fnciones de error en estado estable, para un escalon, una rampa
%    y una parabola en funcion de K1 y K2

% b) Si K1 = 50, cuanto debe valer K2 para que Erv = 5.004?

syms s K1 K2 Ro real;


% a)
%cargamos las fdt
G1 = 100/(0.2*s + 1)
G2 = 1/(20*s)

% realimentacion interna:
G1p = simplify(G1/(1+G1*K2))

%cascada entre K1, Gr_int y G2 (lazo abierto)
Gt_la = simplify(K1*G1p*G2)

%calculamos los errores

%symbolic -- eval (o subs)
%control -- dcgain

%constantes
Kp = Gt_la
Kv = s*Gt_la
Ka = (s^2)*Gt_la


s=0
Erp = simplify(Ro/(1+Kp))
Erv = simplify(eval(Ro/Kv))
Era = simplify(eval((2*Ro)/Ka))

%con eval reemplazo los valores de s en las expresiones
%es mejor usar limit(Gt_la,s,0) porque eval tiraria error si
%hubiera divisiones por 0


% b)

%K1=50 y calculamos la expresion de Erv
%suponemos rampa unitaria, por lo que Ro=1
Ro=1;
K1 = 50;
Erv_K1_50 = eval(Erv) %con eval reemplazamos Ro y K1 en la expresion de Erv

%piden Erv = 5.004

% Erv = Ro/Kv
%     = (Ro*(1+100K2))/ 5K1
% K1 = 50, Erv = 5.004, Ro= 1

% 5.004 = (1+100K2)/5*50
% 5.004 = 1/250 + 2K2/5
% 5.004 - 1/250 = (2*K2)/5

% K2 = (5.004 - 1/250)*(5/2)

%con solve

eq = Erv_K1_50 == 5.004

disp('-----------------------------')
disp('El valor de K2 para que Erv = 5.004 es:')
K2_solve = double(solve(eq,K2))


