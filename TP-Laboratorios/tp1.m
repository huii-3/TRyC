pkg load control
pkg load symbolic
close all; clear all; clc
s=tf('s')

%Valores del sistema
R5=1000
R7=1000
C1=1/(s*1e-6)
C2=1/(s*0.1e-6)

%Funciones de transferencia
G1=minreal(C1/(R5+C1))
G2=minreal(C2/(R7+C2))

%Funcion de transferencia total a lazo abierto
Gla=minreal(G1*G2)

#SISTEMA DE SEGUNDO ORDEN --> G= (K*wn^2)/(s^2 + 2*psita*wn*s + wn^2)
#Gla= (1e+7)/(s^2 + 1.1e+4 + 1e+7)

%Frecuencia natural del sistema (wn)
wn=sqrt(1e+7)

%Amortiguamiento
psita=1.1e+4/(2*wn)

%Ganancia
K=1e7/1e7

step(Gla)
polos=pole(Gla)
%ts=4/abs(Re(pd))
ts=4/abs(-1000)

%-----
%Funcion de transferencia total a lazo abierto
Gla=minreal(G1*G2)

%Grafico de LDR
rlocus(Gla)

s=-5500

%Calculo de la ganacia Kc
Kc=1/(abs((1e+7)/(s^2 + 1.1e+4*s + 1e+7)))

%Funcion de transferencia a lazo cerrado
Glc=feedback(Kc*Gla,1)

%Respuesta temporal del sistema
step(Glc)

%---
%Sobrepasamiento
mp=0.04

%Coeficiente de amortiguamiento
psita=0.707

%Funcion de transferencia total a lazo abierto
Gla=minreal(G1*G2)

%Grafico de LDR
rlocus(Gla)
sgrid(0.707,0.04)

s=-5500+5500i

%Calculo de la ganacia Kc
Kc=1/(abs((1e+7)/(s^2 + 1.1e+4*s + 1e+7)))

%Funcion de transferencia a lazo cerrado
Glc=feedback(Kc*Gla,1)

%Respuesta temporal del sistema
step(Glc)

%Frecuencia natural del sistema (wn)
wn=sqrt(6.05e7)

%Amortiguamiento
psita=1.1e+4/(2*wn)
