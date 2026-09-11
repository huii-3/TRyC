clear all, close all, clc

pkg load symbolic
pkg load control


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

%simulacion

%valroes
G1_v = 2
G2_v = 3
G3_v = 4
G4_v = 5
H1_v = 1
H2_v = 1
H3_v = 1

%sustituyo valores

G7_sust = subs(G7final, {G1, G2, G3, G4, H1, H2, H3}, {G1_v, G2_v, G3_v, G4_v, H1_v, H2_v, H3_v})

%obtener G7_sust como numero
G7_sust = double(G7_sust)











