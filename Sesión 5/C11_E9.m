% Especificaciones
Fs = 1; % frecuencia de muestreo
f = [0.2 0.25]; % vector con frecuencias límites de bandas
a = [1 0]; % vector con amplitudes ideales en las bandas
rp = 3; % ripple [dB] en la banda de paso
rs = 40; % ripple [dB] en la banda de rechazo
% Calcula las desviaciones
ep = 10^(rp/20); dp = (ep-1)/(ep+1); % desv. banda de paso
dr = 10^(-rs/20); % desv. banda de rechazo
dev = [dp dr]; % vector de desviaciones
% Estima orden O requerido para el filtro, y los parámetros
% fo, ao y w, los cuales se requieren para el diseño
[O, fo, ao, w] = remezord(f, a, dev, Fs);
% Diseña el filtro
b = remez(O, fo, ao, w); % respuesta impulso
% Grafica respuesta de frecuencia obtenida
[h, f] = freqz(b, 1, 1024, Fs);
plot(f, 20*log10(abs(h)));
axis ([0 0.5 -60 10])
xlabel('c/m'); title('Magnitud [dB]'); grid