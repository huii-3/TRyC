%algebra de bloques
%resuelto con paquete de control

close all, clear all, clc
pkg load control

%definir fdT

G1=tf([1 1],[1 0 2])
G2=tf([1],[1 1])
H= tf(50)

%multiplicamos la cascada
%min real verifica q los ceros y polos se cancelen(en paquete simbolico es simplify)
G= minreal(G1*G2)

%cerramos el lazo
%opcion 1
%Gp=minreal(G/(1)+G*H)

%opcion 2,  feedback por defecto hace realimentcaion negativa

Gp=feedback(G,H) %real negativa
Gpp=feedback(G,-H) %real positiva



%resuelto con el paquete simbolico
%sin las FdT

%syms G1 G2 H real

%multiplico las cascadas

%G=G1*G2

%Gp=G/(1+G*H)
