% UNIDAD 5 - EJERCICIO 1

% Encontrar las funciones de transferencia para los circuitos indicados.

%----------------------------------------------------------------------
% CIRCUITO 1
close all, clear all, clc;

pkg load symbolic;

%vemos que el sistema es un OPAMP en configuracion no inversor

% G = Vout/Vin = 1 + R2/R1

G1 = 1+(R2/R1)

%----------------------------------------------------------------------
% CIRCUITO 2
close all, clear all, clc;

pkg load control;

% Vemos que el sietema es:
% Pasa Bajos - Buffer (No Inversor) - Pasa Bajos - Buffer (No Inversor)

R = 10e3;
C = 1e-9;
s = tf('s');

Gp = 1/(R*C*s + 1)
Gb = 1

G = minreal(Gp*Gb*Gp*Gb)


%----------------------------------------------------------------------
% CIRCUITO 3
close all, clear all, clc;

pkg load control;

% vemos que el sistema es:
% pasa bajos - buffer no inversor - pasa bajos - no inversor

s= tf('s')
R = 10e3
C = 1e-9

%G de pasa bajos:
Gp = 1/(R*C*s + 1)

%G de AO buffer no inversor
Gb = 1

%G de AO no inversor: G = Vout/Vin = 1 + R3/R4
Gi = tf((1 + R/R),1)
                     % ya que 1+R/R = 2
                     % tf(2,1) = num 2, den 1

% G final
G = minreal(Gp*Gb*Gp*Gi)


%----------------------------------------------------------------------
% CIRCUITO 4

close all, clear all, clc;

pkg load control;

% vemos que el sistema es:
% AO diferencial - pasa bajos - buffer no inversor - pasa bajos - no inversor

s = tf('s');
R1 = 10e3;
R2 = 1e3;
C = 1e-9;

% G de pasa bajos
Gpb = 1/(R1*C*s + 1)

% G de buffer no inversor
Gb = 1

% G de AO no inversor

Gni = 1 + R1/R1 % ya que Gni = 1+R3/R4=2
                      % Gni = tf(2,1)

% Cascada desde el 1er pasabajos hasta AO no inversor
G_casc = minreal(Gpb*Gb*Gpb*Gni)

% El primer bloque (AO diferencial) cierra el lazo:

## 1) ponemos a 0 la entrada (-)
##     - Nos queda un AO no inversor: ganancia = (1+ Rf/Rin ) multiplicado
##       por lo que haya llegado al (+) (en este caso el divisor resistivo)
##     (1+ Rf/Rin) * R7/(R7+R8)

## 2) Ahora ponemos a 0 la entrada (+)
##    - Nos queda un AO inversor: ganancia = -Rf/Rin, aplicada a Vout

## 3) resultado: suma de 1) y 2)
##     Va = (K no inversor)*Vin + (K inversor)*Vout

% K1 = (divisor resistivo) * (ganancia AO no inversor)

  K1 = (R2/(R2+R1)) * (1 + R2/R2)

% Kr = K de realimentacion
  Kr = -R2/R2


%Cerramos el lazo:

G = minreal(K1*feedback(G_casc,Kr))
% El feedback calcula la relacion Vout/Va  ; Va: salida AO diferencial
% K1 es la ganancia de Vin - Va, por eso esta afuera

%SUPONIENDO QUE TODAS LAS RESISTENCIAS SON IGUALES

## K1 = (R/(R+R))*(1+R/R) = 1
## Kr = R/R = 1
##
## G = minreal(K1*feedback(Gc,Kr)) o sea:
## G = minreal(feedback(Gc,1))

%----------------------------------------------------------------------
% CIRCUITO 5

close all, clear all, clc

pkg load control

s = tf('s')

% este es un AO integrador inversor

%valores de componentes

R= 1000;
C = 1e-6;
Zf = 1/(s*C);
Zin = R;
% G = (-Zf/Zin)

G = minreal(-Zf/Zin)


%----------------------------------------------------------------------
% CIRCUITO 6

close all, clear all, clc

pkg load control

s = tf('s')

% este es un AO derivador inversor

%valores de componentes

R= 1000;
C = 1e-6;

%fdt
% R en serie con C (entrada)
Z1 = R + 1/(s*C);

% realimentacion
Z2 = R;

% G = Vout/Vin = -Zf/Zin
G = minreal(-Z2/Z1)

%vemos que tiene un cero y un polo, no es un derivador puro,


%----------------------------------------------------------------------
% CIRCUITO 7 (dejalo ahi nomas)
































