close all, clear all, clc;

pkg load symbolic;
pkg load control;

##G1(s) = (s+1)/(s^2+2)
##G2(s) = 1/(s+1)
##H(s) = 50
##Obtener la FdT de lazo cerrado para realimentacion negativa y positiva


##                                  ┌──────┐    ┌──────┐
##                  R(s) ──► (+) ──►│ G₁(s) │──► │ G₂(s)│------► Y(s)
##                            ▲     └──────┘    └──────┘
##                            │                            │
##                            │          ┌──────┐          │
##                            └── (+/−)  │ H(s) │◄─────────┘
##                                       └──────┘

%resuelvo con paquete de control

%Defino funcion de transferencia
G1 = tf([1 1], [1 0 2])
G2 = tf (1,[1 1])
H = tf(50)

%multiplico la cascada
G = G1*G2

%para la realimentacion hay 2 formas:

%1) con la formula

%realimentacion negativa
FdT_neg = minreal(G/(1+G*H))

%realimentacion positiva
FdT_pos = minreal(G/(1+G*(-H)))

%2) con feedback (SOLO SE PUEDE USAR EN EL PAQUETE DE CONTROL)

Gp = minreal(feedback(G,H)) %reconoce la formula de r.negativa

Gpp = minreal(feedback(G,-H)) %R.positiva

%resuelvo con paquete simbolico

syms G1 G2 H s real

G = G1 * G2

Gp = G/(1+G*H)
Gpp = G/(1-G*H)






























