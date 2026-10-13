close all, clear all, clc;

pkg load control

s=tf('s');

G5 = 26*(s+60)/((s+10)*(s+20))
polos = pole(G5)

% calculo del 0 del Pi
Ti = abs(1/polos(2))

% defino el  PI

PI_= (s+1/Ti)/s

rlocus(PI_*G5)

s=-11
Kp = 1/(abs(20*(s+60)/(s*(s+20))))



s=tf('s')

G5_PI = minreal(G5*PI_)
polos= pole(feedback(G5_PI*Kp,1))

