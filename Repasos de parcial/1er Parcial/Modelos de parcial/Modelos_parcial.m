% ---------------- EJERCICIOS PARCIAL -------------------

% 1) Determinar la FdT del circuito

close all, clear all, clc;

pkg load control;

% Variables:

R1 = 10e3;
R2 = 22e3;
R3 = 220e3;
C1 = 100e-6;
C2 = 47e-6;
s = tf('s');

% El sistema es:
% AO diferencial - AO integrador - Pasa Altos - Buffer - AO inversor

% AO integrador
Zeq = (R1*(1/(s*C1)))/(R1+(1/(s*C1)))
G1 = minreal(-Zeq/R1)

% Pasa Altos
G2 = minreal((R3)/(R3+1/(s*C2)))

% Buffer
K1 = 1

% AO inversor
G3 = -(R3/R1) % luego agrego el (-)

% Ganancia a lazo abierto:
G_la = minreal(G1*G2*K1*G3)

% AO diferencial

K_div = (R1/(R1+R1))*(1 + R1/R1)

% cierro el lazo
G_lc = minreal(K_div*feedback(G_la,1))


step(G_lc,1000)



%----------------------------------------------------------
% 2) Un sistema caracterizado por la siguiente FdT es atacado
%    por una entrada escalon unitario.
%    Una vez pasado el transitorio, ¿en que valor se establece la salida?

close all, clear all, clc;

pkg load control;

s = tf('s');

G = minreal((17*(1*s^2 + 1462*s + 11788))/(s^3 + 67*s^2 + 484*s + 708))

p = pole(G)
z = zero(G)
step(G)
ylim([0 300])
dcgain(G)


%----------------------------------------------------------
% 3) Encontrar la FdT

close all, clear all, clc;

pkg load symbolic;
pkg load control;

R1 = 100;
L1 = 1;
L2 = 10;
syms s I real;


Zp = (R1*s*L2)/(R1 + s*L2);
Zo = Zp + s*L1; % impedancia en paralelo a la tension Vout
Zeq = Zo + R1; %Impedancia equivalente

Vout = Zo * I;
Vin = Zeq * I;

G = simplify(Vout / Vin)


%----------------------------------------------------------
% 4) Calcular la ganancia K para que el Erv = 0.01 (unitario)
%    En algun caso el sistema podria tener un e.permanente = 0?

close all, clear all, clc;

pkg load symbolic;

syms s K real

% G cuerpo
G1 = 20/(s*(s+1));

G_la = K*G1;

% calculo la constante de error:
Kv = (G_la*s)

% calculo el error:
Ro = 1;
s = 0;
Erv = eval(Ro/Kv)

disp('-----------------------------------')
disp('La ganancia para que Erv = 0.01 es:')
K_v = (solve(Erv == 0.01, K))

%----------------------------------------------------------
% 5) Encontrar la FdT del sistema:

close all, clear all, clc;

pkg load control;
pkg load symbolic;

% defino las variables y elementos:
syms D T V s real;

J = 0.0000050;
R = 0.01;
M = 0.250;
L = 0.450;
K = 36;
G = 9.81;


eq1 = (J/(R^2) + M)* D*s^2 == -((M*G)/L)* T
eq2 = V*s == ((R*J)/K)*T*s^2 + K*T*s


Sol = solve(eq1, eq2, D,V,T);

G = simplify(Sol.D / Sol.V)













































