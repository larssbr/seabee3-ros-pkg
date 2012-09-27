x = z5;
n = 10; Wn = [2.23e4 2.32e4]/4.8e4;
ftype = 'bandpass';

% Transfer Function design
[b,a] = butter(n,Wn,ftype);
x = filter(b,a,x);
zf5 = x;
% x = x(3:length(x)) + 2*x(2:length(x)-1) + x(1:length(x)-2); 
% x = x(3:length(x)) - 2*x(2:length(x)-1) + x(1:length(x)-2); 
% x = x/2; 
% z5f = x;
% d = .4e5;
% thresh = .5e4;
% k = 1000;
% zdep = [];
% for i = 1:55
%     t = x(i*d:(i+1)*d);
%     p = find(t == max(t),1);
%     if(((p-k) > 0) && ((p+k) < length(t)) && max(t) > .5e4)
%         zp = [zp t(p-k:p+k)];
%     end
% end
% delay = [];
% for i = 1:12
%     yzp = xcorr(yp(:,i),zp(:,i));
%     m = find(yzp == max(yzp));
%     delay = [delay, length(yp(:,i)) - m];
% end
N=length(x); % Total Number of Samples
fs=96000; % Sampling frequency set at 1000Hz
n=0:N-1;
% Now generate the sinusoidal signal
% Estimate its spectrum using fft command
X=fft(x);
% Build up an appropriate frequency axis
fx=0:(N/2)-1; 
fx=(fx*fs)/N; % Now scale it so that it represents
figure(1);

magX=abs(X);
plot(fx,20*log10(magX(1:N/2)),'r');
grid;
title('Pinger test audio');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');