 close all, clear all, clc

 pkg loas symbolic
 pkg load control

 %s= tf('s')
 %g10 = 187500/(s^2 + 600*s + 62500)

 %step(G10)


%G = 625/(s^2)


syms psita

%veo que el valor final es 3 y q es un sist sde 2orden ubamortiguado
K = 3
tp = 0.015
Mp = 100*(3.25-3)/3


%aplico formulas  para calcular parametros del sist de segundo orden
psita = log(Mp)/(sqrt(pi^2)+ (log(Mp))^2)
wn=pi/(tp*sqrt(1-psita^2))

%armo la funcion de transferencia
s=tf('s')
G2 = ()


%eq = exp((-pi*psita)/(sqrt(1-psita^2))) == Mp
%psita = double(solve(eq,psita))


