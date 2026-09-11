                            %EJERCICIOS GUIA TRyC
%EJERCICIO 1

%1.1
close all, clear all, clc
pkg load control

G1= tf ([5], [0 1 2])
z1=zero(G1)
p1=pole(G1)
vf1 = dcgain(G1) %para determinar el valor final
step(G1);

%1.2
G2 = tf([1], conv([1 2], [1 3]));
z2=zero(G2)
p2=pole(G2)
vf2 = dcgain(G2) %para determinar el valor final
figure
step(G2);

%1.3
G3= tf ([2], [1 2])
z3=zero(G3)
p3=pole(G3)
vf3 = dcgain(G3) %para determinar el valor final
figure
step (G3);

%1.4
G4= tf([5 5], [1 1 2])
z4=zero(G4)
p4=pole(G4)
G4vf4 = dcgain(G4) %para determinar el valor final
figure
step(G4);





