len = 0:.01:50-.01;
f = 30000;
fs = 1000000;
z = zeros(1,length(len));
s = sin(2*pi*f/fs*len);
%plot(len,s);
s1 = [s,z,s,z,s,z];
k = 100;
s2 = [zeros(1,k),s,z,s,z,s,z(1:length(z)-k)];
s1 = s1 + .1*rand(1,length(s1));
s2 = s2 + .1*rand(1,length(s2));
%theta_estimate = acos( 2*mean( s1.*s2) )*180/pi
subplot(1,2,1)
hold on
plot(s1);
%plot(s2,'r');
subplot(1,2,2)
sx = xcorr(s1,s2);
plot(sx);
length(s1) - find(sx == max(sx))
%plot(s2,'r');
% 
% t = 1/fs;
% v = 5.9055e+04;
% a = 20;
% theta = 5;
% a/(v*t*cos(theta*pi/180))
% 
% temp = [];
% fs = 1e7
% for i = 0:89
%      temp = [temp,10*fs/(v*cos(i*pi/180))];
% end
% temp(1:5:90)