clear all, close all, clc

pkg load symbolic

syms R1 R2 R3 R4 L1 L2 C1 V1 V2 s real
syms I1 I2 I3

%MALLAS
%para tener la matriz de la forma A*I=B

A = [(1/(s*C1) + R3 + R1) (-R3) (-R1);
     (-R3 + s*L2) (R3+R2) (-R2);
     (-R1) (-R2) (R4 + s*L1 + R1 + R2)]

B = [0;
    -V2;
    V1]

I = [I1;
     I2;
     I3]
%NODOS

