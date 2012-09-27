function [ theta ] = PhaseDetection(sonar1,sonar2)

y1=fft(sonar1);
y2=fft(sonar2);


zy2=conj(y2);

theta= mean(angle(zy2.*y1));








end