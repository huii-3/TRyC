%--------------------------------------------------------------------------
% a)
clear all, close all, clc;
pkg load symbolic;

syms s real;

%cargamos los valores numericos
R1=2; R2=5; R3=3; L1=5/3; L2=5/2; C=1/6;

%impedancias
Z1 = R1 + s*L1;
Z2 = R2 + 1/(s*C);
Z3 = R3 + s*L2;


% 1°) V2=0 --> cortocircuito el puerto 2:

V1 = 1; %Valor arbritario

% calculo Y11
Z12 = (Z1*Z2)/(Z1+Z2);     % Zeq entre Z1 y Z2
I1 = V1/Z12;
Y11 = simplify(I1/V1)

% calculo Y21
I2 = (-V1)/Z2;
Y21 = simplify(I2/V1)


% 1°) V1=0 --> cortocircuito el puerto 1:

V2 = 1; %Valor arbritario

%Calculo Y22
Z23 = (Z2*Z3)/(Z2+Z3);     % Zeq entre Z2 y Z3
I2 = V2/Z23;
Y22 = simplify(I2/V2)

%Calculo Y12
I1 = (-V2)/Z2;
Y12 = simplify(I1/V2)

% En Z11 y Z22, calculo las Zeq, porque la corriente medida
% está en el mismo puerto de la fuente de prueba.

% En Z12 y Z21, calculo la corriente en el puerto
% cortocircuitado, por eso uso solo esa rama.


%-----------------------------------------------------------------------------
% b)
clear all, close all, clc;
pkg load symbolic;

syms s real;

% cargamos datos:
R1 = 12;
R2 = 12;
R3 = 3;

% 1°) V2 = 0 --> cortocircuito puerto 2

V1 = 1;         % valor arbitrario

%Calculo Y11
Z12 = (R1*R2)/(R1+R2);       % Zeq entre R1 y R2
I1 = V1/Z12;
Y11 = I1/V1

% calculo Y21
I2 = -V1/R2;
Y21 = I2/V1

% 2°) V1 = 0 --> cortocircuito puerto 1

V2 = 1;         % valor arbitrario

%Calculo Y22
Z23 = R2 + R3;       % Zeq entre R2 y R3
I2 = V2/R2 + V2/R3;
Y11 = I2/V2

% calculo Y12
I1 = V2/4 - V2/R2;
Y21 = I1/V2
