close all, clear all, clc
pkg load control

%Defino funcion de transferencia
G1 = tf([1 1], [1 0 2])
G2 = tf (1,[1 1])
H = tf(50),
