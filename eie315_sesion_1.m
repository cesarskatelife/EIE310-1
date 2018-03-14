clear all
clc

%mi rut es 196035133
A = 1; B = 9; C = 6; D = 0; E = 3; F = 5; G = 1; H = 3; I = 3;
 
t = 0:0.3:30; v = exp(-((B+A)/(2*C*(D+E)))*t).*sin(t);
subplot 121; plot(t,v); title('PLOT');
xlabel('Tiempo [seg]'); ylabel('Volts'); grid;
subplot 122; stem(t,v); title('STEM');
xlabel('Tiempo [seg]'); ylabel('volts'); grid;