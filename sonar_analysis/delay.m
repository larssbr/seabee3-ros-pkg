%% DFT Variables
N = 512;
n = 0:(N-1);
N1 = 16;
n1 = 0:(N1-1);

%% Function from part a
x1 = [cos(2*pi*3.*n1./N1), zeros(1, N - N1)];
x2 = [cos(2*pi*3.*n1./N1 + 2*pi), zeros(1, N - N1)];

figure; hold on;
plot(n, x1, 'b');
plot(n, x2, 'r');

X1 = fft(x1);
X2 = fft(x2);

figure; hold on;
stem(abs(fftshift(X1)), 'b');
stem(abs(fftshift(X2)), 'r');

figure; hold on;
X1a = unwrap(angle(X1));
X2a = unwrap(angle(X2));
plot(X1a, 'b');
plot(X2a, 'r');
plot(X1a - X2a, 'g');
