clc, clear all, close all

pkg load control;

%1.1

G1= tf([5],[1 2])
z1=zero(G1)
p1=pole(G1)

tvF1 = dcgain(G1);

step(G1)

%1.2

s = tf('s')
G2 = (1)/((s+2)*(s+3))
z2=zero(G2)
p2=pole(G2)
tfF2=dcgain(G2)
figure()
step(G2)

%1.3

G3=tf([2],[1 2])
z2=zero(G3)
p2=pole(G3)
tfF2=dcgain(G3)
figure()
step(G3)

%1.4

s=tf('s')
G4=(5*(s+1))/(s^2+s+2)
z2=zero(G4)
p2=pole(G4)
tfF2=dcgain(G4)
figure()
step(G4)

%1.5

G5 = tf(conv([5],[1 2]) , conv([1 3],[1 4]))
z5 = zero(G5)
p5 = pole(G5)
tvF5 = dcgain(G5)
figure()
step(G5)

%1.6

G6 = tf(5,[1 0])
z6 = zero(G6)
p5 = pole(G6)
tvF6 = dcgain(G6)
figure()
step(G6)

%1.7

s = tf('s')
G7 = (12*(s+2))/(s*(s+4))
z7 = zero(G7)
p5 = pole(G7)
tvF7 = dcgain(G7)
figure()
step(G7)

%1.8

G8 = tf([1 0],[1 40])
z8 = zero(G8)
p8 = pole(G8)
tvF8 = dcgain(G8)
figure()
step(G8)
grid







