close all, clear all, clc

pkg load control

%definimos s
s= tf('s')

%vemos del grafico que:
%el sist es de primer orden
%hay un retardo de 100s
%ante el escalon de amplitud 5, termina en 95
%el tiempo de establecimiento es de 500s

ts = 400 %sin el retardo
K = 95/5 %(valor final)/(amplitud del escalon)
tau = ts/4
Td = 100 %retardo

%definimos la fdt

G1 = K/(tau*s+1)
step(5*G1,ts) %hasta 400

%error en la estimacion del tau

%q lo pario octave no soporta sist con retardo



