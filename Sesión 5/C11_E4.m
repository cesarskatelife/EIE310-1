b = [2.5 0.1 0.38 0.9 0.1]; % nuevo de h(n)
b = b / (sum(b)); % para que H(0) sea = 1
[H, w] = freqz(b, 1);
Mag = abs(H);
Ang = unwrap(angle(H));
subplot 221; plot(w, Mag); title('Mag[H(w)]');
xlabel('w'); grid
subplot 223; plot(w, Ang); title('Ang[H(w)] [rad]');
xlabel('w'); grid
n = [0 : 0.1 : 3.9] * pi; x = square(n); % genera onda cuadrada
y = conv(x, b); % filtra la onda cuadrada
subplot 222; stem(x); title('x (entrada)');
axis([0 45 -1.5 1.5]); xlabel('n'); grid
subplot 224; stem(y); title('y (salida)');
axis([0 45 -1.5 1.5]); xlabel('n'); grid