clear all, close all, clc

pkg load symbolic

syms G1 G2 G3 G4 H1 H2 H3 real

%realimentación G1-H1
G1eq = G1/(1+G1*H1)

%realimentación G3-H2
G3eq = G3/(1+G3*H2)

%camino G1eq, G4, 1/G1
G2eq = G1eq*G4*(1/G1)

%camino G1eq,G2
G4eq= G1eq*G2

%sumo los dos caminos
G5eq = G2eq + G4eq

%multiplico
G6eq = G5eq * G3eq

%realimentacion final
G7eq = G6eq/(1+G6eq*H3)

%simplifico la funcion de transferencia

G7final = simplify(G7eq)

