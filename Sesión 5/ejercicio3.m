clear
close
clc

Fs = 2000; % frecuencia de muestreo
% Frec. límites de bandas; no se especifica la inicial ni la final
f1 = [200 220 380 400 590 610 700 720];
a1 = [0 1 0 0.5 0]; % amplitudes deseadas en las bandas
f2 = [200 220 380 400 590 610 700 720];
a2 = [1 0 1 0 1]; % amplitudes deseadas en las bandas

% Ripple en las bandas 1
r11 = 30; r12 = 3; r13 = 50; r14 = 1; r15 = 60;
% Ripple en las bandas 2
r21 = 30; r22 = 3; r23 = 50; r24 = 1; r25 = 60;
% Desviaciones en las bandas 1
d11 = 10^(-r11/20);
d12 = (10^(r12/20)-1)/(10^(r12/20)+1);
d13 = 10^(-r13/20);
d14 = (10^(r14/20)-1)/(10^(r14/20)+1);
d15 = 10^(-r15/20);
dev1 = [d11 d12 d13 d14 d15];
% Desviaciones en las bandas 2
d21 = 10^(-r21/20);
d22 = (10^(r22/20)-1)/(10^(r22/20)+1);
d23 = 10^(-r23/20);
d24 = (10^(r24/20)-1)/(10^(r24/20)+1);
d25 = 10^(-r25/20);
dev2 = [d21 d22 d23 d24 d25];


% vector de desviaciones 1
[O1, fo1, ao1, w1] = remezord(f1, a1, dev1, Fs); % estima orden del filtro
% vector de desviaciones 2
[O2, fo2, ao2, w2] = remezord(f2, a2, dev2, Fs); % estima orden del filtro
O1 % despliega orden = (N-1)
O2 % despliega orden = (N-1)
b1 = remez(O1, fo1, ao1, w1); % diseña el filtro% Respuesta de frecuencia obtenida
b2 = remez(O2, fo2, ao2, w2); % diseña el filtro% Respuesta de frecuencia obtenida

[H1, f1] = freqz(b1, 1, 1024, Fs);
[H2, f2] = freqz(b2, 1, 1024, Fs);

plot(f1, 20*log10(abs(H1)),'g',f2, 20*log10(abs(H2)),'b'); xlabel('Hz'); ylabel('dB'); grid