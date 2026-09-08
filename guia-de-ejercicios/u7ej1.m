close all, clear all, clc

pkg load symbolic
pkg load control

G1 = zpk([-1],[-10 -100],[53])
s = tf('s')
G2 = 1/s
Kp = 31
Kd = 16

G3 = G1/(1+G1*Kd) %realimentacion interna

G4 = Kp*G3*G2 %podria haber hecho feedback(G1,Kd)

Gfinal = feedback(G4,1) %realimentacion externa

step(Gfinal)





