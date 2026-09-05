close all, clear all, clc

pkg load control
pkg load symbolic


s = tf('s')
G6 = 625/(s^2+60*s+625)
disp('polos del sistema original')
pole(G6)
step(G6,0,4)

%Veo q el valor final es 1
%y que es un sistema de 2do orden subamortiguado


