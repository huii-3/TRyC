%----------------------------------------------------------------
% b)
close all, clear all, clc;

pkg load symbolic;

% cargamos datos

R1 = 3;
R2 = 3;
R3 = 2;

% 1°) I2 = 0
V1 = 1;         %valor arbitrario

% Z11
I1 = V1/(R1+R2);
Z11 = V1/I1

% Z21
V2 = I1*R2 + 7*I1;
Z21 = V2/I1

% 2°) I1 = 0
V2 = 1;         %valor arbitrario

% Z22
I2 = V2/(R2+R3);
Z22 = V2/I2

% Z12
V1 = I2*R2;
Z12 = V1/I2



%----------------------------------------------------------------
% c)
clear all, close all, clc
pkg load symbolic
%NO SE USA EL PAQUETE DE CONTROL PORQUE NO HAY ELEMENTOS ACTIVOS

R1=6; R2=3; R3=4; R4=1; R5=1;

%Calculo Z11
R345 = R3 + R4 + R5;
R2345= (R2*R345)/(R2+R345);
Z11= R1 + R2345             %es la Req

%Calculo Z21
V1 = 1;                        %LE DAMOS UN VALOR ARBRITARIO A V1
I1 = V1/Z11;
Vx = V1* (R2345/(R2345+R1));   % divisor de tension
Ix = Vx/R345;                  % corriente por las resistencias en serie
V2 = Ix*R5;
Z21 = V2/I1

%Calculo Z22
R234 = R2 + R3 + R4;
Z22 = (R234*R5)/(R234+R5)

%Calculo Z12
V2 = 1; %Valor arbritario a la tensión de salida
I2 = V2/Z22;
Ix = V2/R234;
V1 = Ix*R2;
Z12 = V1/I2
