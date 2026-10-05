clear all, close all, clc;

pkg load control;

R1=10;
R2=20;

%calculo de A
V1 = 1
V2 = V1 * (1+9/R1)
A =V1/V2

%Calculo de C

I1 = V1/R1
C=I1/V2



%Ahora hago I1=0, debo recalcular todo
%Calculo de B

V1 = 1; %fuente de prueba
I2 = -(V1+9*(V1/R1))/R2
B = -V1/I2

% Calculo de D
i = -V1/R1
I1 = -i-I2
D = -I1/I2
