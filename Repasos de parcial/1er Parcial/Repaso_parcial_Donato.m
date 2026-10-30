%UNIDAD 1

%Ejercicio 1
%............
clear all, close all, clc
pkg load control;
pkg load symbolic;

syms R1 R2 R3 R4 C1 L1 L2 AC1 AC2 E1 E2 s real;
syms I1 I2 I3 w real;
syms amp_esc amp_sen real;

%Cargo las ecuaciones
eq1= 0 == (1/(s*C1)+R3+R1)*I1 - R3*I2 - R1*I3
eq2= -E2 == -R3*I1 + (R3+s*L2+R2)*I2 - R2*I3
eq3= E1 == -R1*I1 -R2*I2 + (R1+R2+R4+s*L1)*I3

sol= solve(eq1,eq2,eq3,I1,I2,I3)

S_I1 = simplify(sol.I1)
S_I2 = simplify(sol.I2)
S_I3 = simplify(sol.I3)

%Simulacion ----> suponemos que E1 es un escalon de amplitud 12 y E2 es una sinusoide
%Transformadas deE1 y E2
E1_v = amp_esc / s                %Transformada de un escalon
E2_v = (amp_sen*w)/(s^2 + w^2)    %Transformada de una sinusoide

%Le doy valor a los elementos
R1_v = 100;
R2_v = 20;
R3_v = 40;
R4_v = 60;
C1_v = 10e-6;
L1_v = 20e-6;
L2_v = 50e-3;
amp_esc_v = 12;
amp_sen_v = 5;

%Tomo cada expresion de las soluciones simbolicas y sustituyo por valores numericos (usando subs)
I1_num = simplify(subs(S_I1, {R1, R2, R3, R4, L1, L2, C1, E1, amp_esc, amp_sen}, {R1_v, R2_v R3_v, R4_v, L1_v, L2_v, C1_v, E1_v, amp_esc_v, amp_sen_v}))
I2_num = simplify(subs(S_I2, {R1, R2, R3, R4, L1, L2, C1, E2, amp_esc, amp_sen}, {R1_v, R2_v R3_v, R4_v, L1_v, L2_v, C1_v, E2_v, amp_esc_v, amp_sen_v}))
I3_num = simplify(subs(S_I3, {R1, R2, R3, R4, L1, L2, C1, amp_esc, amp_sen}, {R1_v, R2_v R3_v, R4_v, L1_v, L2_v, C1_v, amp_esc_v, amp_sen_v}))

%----------------------------------------------------------------------------------------------------------------------------------------------------------------

%UNIDAD 7

%Ejercicio 1
%............
clear all, close all, clc

pkg load control
pkg load symbolic

%Defino funciones de transferencia

s = tf('s')
G1 = (53*s + 53) / ((s+10)*(s+100))
G2 = 1/s
Kd = 16
Kp = 31

%Realimentacion interna entre G1 y Kd
G3 = G1/(1+G1*Kd) %Otra forma (usando feedback): G3 = feedback(G1, Kd)

%Multiplico la cascada
G4 = Kp*G3*G2

%Cierro el lazo (realimetacion externa)
G = feedback(G4, 1)

step(G);  % ----> Respuesta al escalon unitario


%Ejercicio 2
%............

clear all, close all, clc
pkg load symbolic
pkg load control

%Defino funciones de transferencia
s = tf('s')
G1 = 27/(s+200)
G2 = 5/(s+0.1)
P = 12
P1 = (s+0.1)/s

%Multiplico la primera cascada
G3 = P*G1

%Realimentacion negativa
G4 = minreal(G3/(1+G3))
                       %-----> Uso minreal para cancelar ceros y polos
%Multiplico la cascada
G5 = P1*G4*G2

%Realimentacion negativa
G = minreal(G5/(1+G5))

step(G);  %Respuesta al escalon unitario



%Ejercicio 3 ----> Modelado matematico
%............

clear all, close all, clc
pkg load control
pkg load symbolic

%Defino variables
syms K1 M1 K2 M2 B1 B2 X1 X2 s U real;

%Planteo ecuaciones
eq1 = -K1*X1 - B2*(s*X1-s*X2) == M1*s^2*X1
eq2 = -B2*(s*X2-s*X1) + U-K2*X2 - B1*s*X2 == M2*s^2*X2

%Resuelvo ecuaciones
sol = solve(eq1, eq2, X1, X2)   %Aca guardo las soluciones simbolicas de X1;X2
sol_1 = sol.X1
sol_2 = sol.X2

%Determino funciones de transferencia (fdt)
fdt1 = simplify(sol_1/U)
fdt2 = simplify(sol_2/U);

%-------------------------------------------------------------------------------

%UNIDAD 8

%Ejercicio 1.1
%............

clear all, close all, clc
pkg load control
pkg load symbolic

syms  s R0 real

%Defino la funcion de transferencia
G1 = 50/(1+0.5*s)*(1+2*s)


%Defino las constantes de error
Kp = G1
Kv = s*G1
Ka = (s^2)*G1

%Calculo los errores
s = 0  % ------> ya que en la formula del regimen permanente s tiende a 0
Erp = eval(R0/(1+Kp))
Erv = eval(R0/Kv)
Era = eval((2*R0)/Ka)  %Uso eval para evaluar la expresion simbolica luego de haber fijado s=0

%Ejercicio 1.2
%..............

clear all, close all, clc
pkg load control
pkg load symbolic

syms s R0 real
G2 = 2/(s*(1+0.1*s)*(1+0.5*s))

%Defino la funcion de transferencia
Kp = G2
Kv = s*G2
Ka = (s^2)*G2

%Calculo los errores
s = 0
Erp = eval(R0/(1+Kp))
Erv = eval(R0/Kv)      %Uso eval para todos porque todos tienen s
Era = eval((2*R0)/Ka)


%Ejercicio --> Tarea "a"

clear all, close all, clc
pkg load control
pkg load symbolic

syms K1 K2 R0 s real

G1 = 100/(0.2*s+1)
G2 = 1/(20*s)

%Realimentacion interna
G3 = G1/(1+G1*K2);

%Multiplico la cascada
G4 = K1*G3*G2          %Necesito la G de lazo abierto para calcular las constantes de error

%CALCULO DE ERRORES

%Constantes de error
Kp = G4
Kv = s*G4
Ka = (s^2)*G4
%Calculo de error
s = 0
Erp = simplify(eval(R0/(1+Kp)))
Erv = simplify(eval(R0/Kv))
Era = simplify(eval((2*R0)/Ka))

%-------> "b"
%Suponemos que la entrada rampa tiene amplitud 1, es decir R0=1
R0 = 1
K1 = 50
Erv_K1_50 = eval(Erv)
eq1 = Erv_K1_50 == 5.004
Sol = solve(eq1,K2);

disp('Para que Erp sea 5.004, K2 debe valer:')
double(Sol)


%-------------------------------------------------------------------------------

%UNIDAD 8

%Ejercicio 1 sistemas de 1er y 2do orden
%........................................

clear all, close all, clc
pkg load control
pkg load symbolic

%Defino valores y fdt

s = tf('s')
K = 0.75
Tau = 1.5e-6/4

G = K/((Tau/2)*s+1)^2
step(G,4e-6)

%Ejercicio 2 sistemas de 1er y 2do orden
%........................................

clear all, close all, clc
pkg load control
pkg load symbolic

%Defino valores y fdt

s = tf('s')
K = 1.7
Tau = 0.05

G = K/((Tau/2)*s+1)^2

step(G, 0.25)

%Ejercicio 3 sistemas de 1er y 2do orden
%........................................

clear all, close all, clc
pkg load control
pkg load symbolic

%Defino valores y fdt

s = tf('s')
K = 1.2
Tau = 0.756

G = K/((Tau/2)*s+1)^2

step(G, 4.5)


%Ejercicio 4 sistemas de 1er y 2do orden
%........................................

clear all, close all, clc
pkg load control
pkg load symbolic

%Defino valores y fdt

s = tf('s')

K = 1 %------>  Representa el valor final
Vmax = 1.1
Mp = (Vmax-K)/K  %-----> Sobrepasamiento
Tp = 3e-3  %------> Tiempo pico
psita = (-log(Mp))/(sqrt(log(Mp)^2+pi^2))
wn = pi/(Tp*sqrt(1-psita^2))

%Calculo funcion de transferencia y simulo
G = (K*wn^2)/(s^2+2*psita*wn*s+wn^2)
step(G, 7e-3)


%Ejercicio 5 sistemas de 1er y 2do orden
%........................................

clear all, close all, clc
pkg load control
pkg load symbolic

%Defino valores y fdt
s = tf('s')
Vmax = 1.2
K = 1
Mp = (Vmax-K)/K
Tp =1
psita = (-log(Mp))/(sqrt(log(Mp)^2+pi^2))
wn = pi/(Tp*sqrt(1-psita^2))

%Calculo funcion de transferencia y simulo
G = (K*wn^2)/(s^2+2*psita*wn*s+wn^2)

step(G, 3.5)

%Ejercicio sistemas de 1er y 2do orden ---> tarea
%..................................................

clear all, close all, clc
pkg load control
pkg load symbolic

%Defino valores y fdt
s = tf('s')
K = 3.5
Tau = 0.0025
td = 0.004
ts = 0.012 - td


G = K/(1+Tau*s)

step(G, 0.02)

%-------------------------------------------------------------------------------

%UNIDAD 5 ---> SINTESIS DE REDES ACTIVAS

%Ejercicio 1 --> Guia de ejercicios

close all, clear all, clc
pkg load control
pkg load symbolic

%Declaro variables simbolicas
syms R1 R2 real

%El sistema es un amplificador no inversor:
G = 1+(R2/R1)

%Ejercicio 2 --> Guia de ejercicios
clear all, close all, clc;
pkg load control;
pkg load symbolic;

%Defino variables y fdt --> Pasa bajos, buffer, pasa bajos, buffer
s = tf('s')
R = 10e3
C = 1e-9

Gpb = 1/(R*C*s+1)

%Ganancia de un buffer:
K = 1

%fdt total:
G = minreal(Gpb*K*Gpb*K)


%Ejercicio 3 --> Guia de ejercicios

clear all, close all, clc;
pkg load control;
pkg load symbolic;

%Defino variables y fdt --> Pb - Buffer - Pb - Ao no inversor

s = tf('s')
R = 10e3
C = 1e-9

Gpb = 1/(R*C*s+1)

%Ganancia del buffer y del OpAmp
K1 = 1 %--> Buffer
K2  = 1+(R/R) %--> OpAmp

%fdt total --> multiplico la cascada
G = minreal(Gpb*K1*Gpb*K2)


%Ejercicio 4 --> Guia de ejercicios
%...................................
clear all, close all, clc;
pkg load control;
pkg load symbolic;

%Defino variables --> Diferencial - Pb - Buffer - Pb - C. No inversora

s = tf('s')
R1 = 1e3
R2 = 10e3
C = 1e-9

Gpb = 1/(R2*C*s+1)

%Ganancias del buffer y OpAmp (sin C.diferencial)
K2 = 1
K3 = 1+(R2/R2)

G_la = minreal(Gpb*K2*Gpb*K3) %Funcion del lazo abierto

%OpAmp diferencial:
K1 = (1+R1/R1)*(R1/(R1+R2)) %--> K del OpAmp no inversor * Divisor resistivo
Kr = -(R1/R1) %--> Ganancia de realimentacion

%Cierro el lazo --> Resuelvo realimentacion
G_lc = minreal(G_la/(1+G_la*1))

G = minreal(K1*(G_lc))  %G_total

%Ejercicio 1 Tarea
%..................

clear all, close all, clc
pkg load control
pkg load symbolic

%Defino variables --> Diferencial - Buffer c/divisor - Integrador - Inversor - Sumador
s = tf('s')
R = 1e3
C = 1e-6
Z_eq = (R*(1/(s*C)))/(R+1/(s*C))

%G1 --> Integrador
K_I = -(Z_eq/R)
G1 = minreal(K_I)

%G3 --> Buffer + divisor
K_B = 1
Div_v = (R+(1/(s*C)))/(R+R+(1/(s*C)))
G3 = minreal(K_B*Div_v)

%K2 --> Inversor
K_Inv = -(R/R)
K2 = K_Inv

%K3 --> Sumador
K_S = -1

%K1 --> Diferencial
K_D = (R/(R+R))*(1+(R/R))

%Resolucion final del sistema
G_la = minreal((G1+K2*G3)*(K_S)) %--> lazo abiero

G_lc = minreal(G_la/(1+G_la)) %--> lazo cerrado

G = minreal(K_D*G_lc) %--> G final

%-------------------------------------------------------------------------------

%EJERCICIOS ANEXOS


%Ejercicio 1
%............
clear all, close all, clc
pkg load symbolic

syms s

G1 = 2/(s+3);
G2 = 3/(s+3);
G3 = 6/s;
G4 = 7;
G5 = 5/(s+2);
G6 = 10;

fdt = simplify((G1-G3)*(G4-G5)/(1-G1*G2) + G6)

[num, den] = numden(fdt);

num = collect(expand(num), s)
den = collect(expand(den), s)


%Ejercicio 2
%............

clear all, close all, clc
pkg load control;
pkg load symbolic;

%Defino variables --> apartado a
R1 = 5e3
C1 = 1e-6
s = tf('s')

%Resuelvo mi G
G1_a = minreal((1/(R1*C1*s+1))^2) %--> (Pb1)*(Pb2)
G1_b = minreal((1/(R1*C1*s+1))^2)
step(G1_a); hold on;
step(G1_b)

%Apartado b

s = tf('s')
R1_b = 5e3
R2_b = 500e3
C1_b = 1e-6
C2_b = 10e-9
K_buffer = 1

Pb_1 = 1/(R1_b*C1_b*s+1);
Pb_2 = 1/(R2_b*C2_b*s+1);

G2_a = Pb_1*Pb_2
G2_b = Pb_1*Pb_2*K_buffer

step(G2_a);hold on;
step(G2_b)

%-------------------------------------------------------------------------------

%Ejercicio 1 mallas y nodos
%.........................
clear all, close all, clc
pkg load control
pkg load symbolic

syms s

%Declaro las variables
R1 = 10
R2 = 100
L1 = 1*s        % s --> mult laplaciano
L2 = 100*s

%Planteo ecuaciones
B1 = R2 + L2 %----> Serie R1 y R2
B2 = simplify((B1*L1)/(B1+L1)) % ---> Vout
Vout = B2
Vin = simplify(B2+R1)

%Encuentro mi fdt
fdt = simplify(Vout/Vin)


%Ejercicio 2 mallas y nodos
%...........................
clear all, close all, clc;
pkg load control;
pkg load symbolic;

syms s

%Defino mis variables
R1 = 100
R2 = 100
L1 = 1*s
L2 = 10*s

%Planteo ecuaciones
B1 = simplify((L2*R2)/(L2+R2))  % --> Paralelo L2 y R2
B2 = simplify(L1+B1)
Vout = B2
Vin = simplify(B2+R1)

%Encuentro mi fdt
fdt = simplify(Vout/Vin)













































