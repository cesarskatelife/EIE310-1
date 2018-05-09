clear all
close all
clc
%mi rut es 196035133
A = 1; B = 9; C = 6; D = 0; E = 3; F = 5; G = 1; H = 3; I = 3;

vi = (H*A);
a = (D+E)/10;
dt = 10e-3;
t(1) = 0;
vf(1) = 0;
for i = 2 : 41;
t(i)= (i-1) * dt;
vf(i) = (1-a) * vi + a * vf(i-1);
end

close; stem(t, vf);
xlabel('seg'); grid;