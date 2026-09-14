%-------------------------------------------------------------------------------
%----------------------- EJERCICIOS PRE PARCIAL --------------------------------

%1) Encontrar la FdT total del sistema mediante algebra de bloques:

close all, clear all, clc;

pkg load control;


s = tf('s');

% Defino las fdt:

G1 = 2/(s+3)
G2 = 3/(s+3)
G3 = 6/s
G4 = 7
G5 = 5/(s+2)
G6 = 10

% realimentacion entre G1 y G2

B1 = minreal(feedback(G1,-G2))

% paralelo de (G3/G2) con 1

B2 = minreal(1 - (G3/G2))

% paralelo de G4 y G5

B3 = minreal(G4 - G5)

% FdT final

G = minreal((B1*B2*B3 + G6))

%----------------------------------------------------------------------------
% 2) Modelar el sistema mecanico y encontrar X2(s)/F(s)

close all, clear all, clc;

pkg load symbolic;
pkg load control;

syms s K1 K2 B1 B2 X1 X2 M1 M2 F real;

% planteo las ecuaciones:
eq1 = M1*X1*s^2 == F - B2*X1*s - K2*(X1-X2);
eq2 = M2*X2*s^2 == -B1*X2*s - K2*(X2-X1) - K1*X2;

%resuelvo:

Sol = solve(eq1, eq2, X1, X2)

G_sym = simplify(Sol.X2/F)

% simulacion - paso al paquete de control:

% valores de componentes:

K_v = 7;
B1_v = 15;
B2_v = 25;
M1_v = 10;
M2_v =40;

% reemplazo valores:


G_num = subs(G_sym, {K1, K2, B1, B2, M1, M2}, {K_v, K_v, B1_v, B2_v, M1_v, M2_v});

% separo num y den

[num_G,den_G]= numden(G_num);

% paso a vectores de coeficientes:

num = sym2poly(num_G);
den = sym2poly(den_G);

% FdT final:

G = minreal(tf(num, den))

dcgain(G)
step(G)

%----------------------------------------------------------------------------

% 3) Comparar las FdT de los 2 circuitos, con los siguientes valoers:

% a): R1 = R2 = 5k ; C1=C2 = 1uF

close all, clear all, clc;

pkg load control;
pkg load symbolic;

% CIRCUITO 1:

% no puedo hacer G1 = minreal(Gpb*Gpb), ya que no hay
% un buffer entre los dos pasa bajos

% planteo nodos:

syms s Vin Va Vout R1 R2 C1 C2 real;

eq1 = (Vin-Va)/R1 == Va*s*C1 + (Va-Vout)/R2;
eq2 = (Va-Vout)/R2 == Vout*s*C2;

% resuelvo para Va y Vout
Sol = solve(eq1, eq2, Va, Vout)

% Hago G = Vout/Vin
G1_sym = simplify(Sol.Vout / Vin)

% le doy valores, paso a paquete de control
R1_v = 5e3;
C1_v = 1e-6;

% reemplazo valores
G1_num = subs(G1_sym, {R1, R2, C1, C2}, {R1_v, R1_v, C1_v, C1_v})
% sigue siendo una expresion simbolica (tengo s)

% separo num y den:
[num_G, den_G] = numden(G1_num);

% paso a vectores de coeficientes:
num = sym2poly(num_G);
den = sym2poly(den_G);

% hago la fdt final:
G1_fdt = minreal(tf(num,den))

% CIRCUITO 2:
s = tf('s');

% fdt de pasabajos:
Gpb = 1/(1+R1_v*C1_v*s);

% ganancia de Buffer:
K_b = 1;

% G total:
G2 = minreal(Gpb*G_b*Gpb)

% Grafico ambos sistemas:
step(G1_fdt); hold on;
step(G2)

%----------------------------------------------------------------------------

% b) R1= 5k R2=500k ; C1=1uF C2=10nF

close all, clear all, clc;

pkg load control;
pkg load symbolic;

% CIRCUITO 1:

% no puedo hacer G1 = minreal(Gpb*Gpb), ya que no hay
% un buffer entre los dos pasa bajos

% planteo nodos:

syms s Vin Va Vout R1 R2 C1 C2 real;

eq1 = (Vin-Va)/R1 == Va*s*C1 + (Va-Vout)/R2;
eq2 = (Va-Vout)/R2 == Vout*s*C2;

% resuelvo para Va y Vout
Sol = solve(eq1, eq2, Va, Vout)

% Hago G = Vout/Vin
G1_sym = simplify(Sol.Vout / Vin)

% le doy valores, paso a paquete de control
R1_v = 5e3;
R2_v = 500e3;
C1_v = 1e-6;
C2_v = 10e-9;

% reemplazo valores
G1_num = subs(G1_sym, {R1, R2, C1, C2}, {R1_v, R2_v, C1_v, C2_v})
% sigue siendo una expresion simbolica (tengo s)

% separo num y den:
[num_G, den_G] = numden(G1_num);

% paso a vectores de coeficientes:
num = sym2poly(num_G);
den = sym2poly(den_G);

% hago la fdt final:
G1_fdt = minreal(tf(num,den))

% CIRCUITO 2:
s = tf('s');

% fdt de pasabajos:
Gpb1 = 1/(1+R1_v*C1_v*s);
Gpb2 = 1/(1+R2_v*C2_v*s);

% ganancia de Buffer:
K_b = 1;

% G total:
G2 = minreal(Gpb1*K_b*Gpb2)

% Grafico ambos sistemas:
step(G1_fdt); hold on;
step(G2)


%----------------------------------------------------------------------------

% 4) Identificar los sitemas:

% SISTEMA 1


close all, clear all, clc;

pkg load control;
s= tf('s');

% veo que es un sistema subamortiguado:

Vmax = 0.89;
Vfinal = 0.6;

K = 0.6;
Tp = 3.2
Mp = (Vmax-Vfinal)/(Vfinal)

psita = (-log(Mp))/(sqrt(log(Mp)^2+pi^2))
wn = pi/(Tp*sqrt(1-psita^2))


G = (K*wn^2)/(s^2+2*psita*wn*s+wn^2)

step(G,30)

% SISTEMA 2

close all, clear all, clc;

pkg load control;
s = tf('s');
% Veo que es un sistema sobreamortiguado

% Lo aproximo como un sistema de primer orden, con 2 polos iguales

K = 5
ts = 8
tau = ts/4


G = (K)/(((tau/2)*s + 1)^2)

step(G,10)

























