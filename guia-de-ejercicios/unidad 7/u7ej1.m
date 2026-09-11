close all, clear all, clc

pkg load symbolic
pkg load control

%sistema 1

G1 = zpk([-1],[-10 -100],[53])
s = tf('s')
G2 = 1/s
Kp = 31
Kd = 16

G3 = G1/(1+G1*Kd) %realimentacion interna

G4 = Kp*G3*G2 %podria haber hecho feedback(G1,Kd)

Gfinal = feedback(G4,1) %realimentacion externa

step(Gfinal)

%sistema 2
close all, clear all, clc
pkg load control

s = tf('s')
G1 = 27/(s+200)
G2 = 5/(s+0.1)
P1 = (s+0.1)/s
P = 12

%multiplico P y G1
G3= P*G1

%realimentacion interna

G4 = minreal(feedback(G3,1))

%multiplico la cascada
G5 = G4 * P1 * G2

%cierro el lazo
G = minreal(feedback(G5,1))

step(G)











