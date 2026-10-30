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

%UNIDAD 5































































