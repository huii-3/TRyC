%UNIDAD 5 EJERCICIO 1, CIRCUITO 6

close all, clear all, clc

pkg load control

s = tf('s')

%valores de componentes

R= 1000;
C = 1e-6;

%fdt
Z1 = R+1/(s*C);
Z2 = R;
G = minreal(-Z2/Z1)

%vemos que tiene un cero y un polo, no es un derivador puro,

