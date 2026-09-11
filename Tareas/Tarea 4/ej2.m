clear all, close all, clc

pkg load control

%suponemos q es criticamente amortiguado (puede ser sobreamortiguado tmb)
%G2 = K/(s*tau/2 + 1)^2 y tau=ts/4
%si fuera de 1 orden podriamos usar el 63%
%K=vfinal/Amp.esc = 3,5*2=7

%sist de 2 orden
%retardi de 0.005s
%esc de amplitud 0.5
%t establecimiento de 0.012s

s = tf('s')
Td = 0.005 %retardo
ts = 0.012-Td %sin retardo
K = 3.5/0.5 %valor final/amp esc
tau = ts/4



%definimos la fdt

G1 = K/(s*tau/2+1)^2
step(0.5*G1,0.015)

%en este grafico debo fijarme en 0.012-0.005, para comparar con la grafica de la tarea

