clear
clc
close

load('ecg_orig.txt') 
load('ecg_rdo.txt')

n1 = 1400;  % n inicial
n2 = 1800;  % n final
n = (n1 : n2); 
t = n / 200;  % [seg]
t1 = n1 / 200;  % t inicial
t2 = n2 / 200;  % t final
subplot 411; plot(t, ecg_orig(n)); 
title('ECG original') 
axis([t1 t2 -1 1.5]); 
xlabel('seg.'); grid; 
subplot 412; plot(t, ecg_rdo(n)); 
title('Salida FIR') 
axis([t1 t2 -1 1.5]); 
xlabel('seg.'); grid; 

% Datos para el dise�o del filtro 
fp = 45;  % frecuencia l�mite de la banda de paso en [Hz]
fr = 50;  % frecuencia l�mite de la banda de rechazo en [Hz]
Fs = 200;  % frec. de muestreo en [Hz]
Rp = 1;  % ripple en dB en la banda de paso
Rs = 40;  % ripple en dB en la banda de rechazo 
% Estima el orden necesario para lograr las especificaciones 
Wp = 2 * fp / Fs; 
Wr = 2 * fr / Fs; 
[N, Wn] = ellipord(Wp, Wr, Rp, Rs); 
% Dise�a el filtro
[b, a] = ellip(N, Rp, Rs, Wn, 'low'); 
% Despliega N y coeficientes 
N 
b 
a 
% Calcula la respuesta de frecuencia obtenida 
f1 = 0; % frec. m�nima 
f2 = 100; % frec. m�xima 
f = [f1 : (f2-f1)/511 : f2]; 
H = freqz(b, a, f, Fs); 
% Grafica Mag[H(f)] 
subplot 413; semilogy(f, abs(H)); 
axis([f1 f2 1e-4 2]); grid 
xlabel('f[Hz]'); title('Salida IIR') 
% Lee la se�al, la filtra y graba la se�al filtrada 
load('ecg_rdo.txt') 
y = filter(b, a, ecg_rdo); 
save 'ecg_iir.txt' y -ascii 

%% FIR

% Datos para el diseño del filtro
Fs = 200;
% frecuencia de muestreo
f = [45 50];
% vector con frecuencias límites de bandas
% no se especifican los límites 0 y Fs/2
a = [1 0];
% amplitudes deseadas en las bandas
rp = 1;
% ripple en la banda de paso
rs = 40;
% ripple en la banda de rechazo% Desviaciones
dev = [(10^(rp/20)-1)/(10^(rp/20)+1)
10^(-rs/20)];
% Estima el orden necesario para lograr las especificaciones
[N, fo, ao, w] = remezord(f, a, dev, Fs);
% Despliega N
N
% Diseña el filtro
b = remez(N, fo, ao, w);
% Calcula la respuesta de frecuencia obtenida
f1 = 0;
% frec. mínima
f2 = 100;
% frec. máxima
f = [f1 : (f2-f1)/511 : f2];
H = freqz(b, a, f, Fs);
% Grafica Mag[H(f)]
subplot 414; semilogy(f, abs(H));
axis([f1 f2 1e-4 2]); grid
xlabel('f[Hz]'); title('Mag(H) de LPF FIR')
% Lee la señal, la filtra y graba la señal filtrada
load('ecg_rdo.txt')
y = conv(ecg_rdo, b);
save 'ecg_fir.txt' y -ascii

