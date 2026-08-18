clear all, close all, clc

pkg load symbolic
pkg load control

%resolucion por mallas

syms R1 R2 R3 R4 C1 L1 L2 s E1 E2 I1 I2 I3 real
syms amp_esc amp_seno w


%Supongamos que E1 es un escalon y E2 es una sinusoide

E1 = amp_ esc/s;
E2 (amp_seno*w)/(s^2 + w^2);

%cargamos las ecuaciones

eq1 = 0 == I1*(R1 +R3+1/(s*C1))+ R3*I2 - R1*I3;

eq2 = -E2 == -R3*I1+(R2+R3+s*L2)*I2 - R2*I3;

eq3 = E1 == -R1*I1 - R2*I2 +(R1+R2+R4+s*L1)*I3 ;

%resolvemos el sistema

S = solve(eq1,eq2,eq3,I1,I2,I3)

S_I1 = simplify(S.I1)
S_I2 = simplify(S.I2)
S_I3 = simplify(S.I3)

%darle valores a los elementos y pasarlos al pquete de control para simular

vR1=100;vR2=20;vR3=40;vR4=60;
vC1=10e-6;vL1=20e-3;vL2=50e-3;
v_amp_esc=12;v_amp_seno=5;v_w=100*pi;

I1v= subs(S_I1,{R1,R2,R3,R4,C1,L1,L2,v_amp_esc,v_amp_seno,v_w})
I2v= subs(S_I2,{R1,R2,R3,R4,C1,L1,L2,v_amp_esc,v_amp_seno,v_w})
I3v= subs(S_I3,{R1,R2,R3,R4,C1,L1,L2,v_amp_esc,v_amp_seno,v_w})
