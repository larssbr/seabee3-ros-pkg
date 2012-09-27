function [ time, signal ] = generatePingerOutput( pinger_frequency, sample_frequency )
%GENERATEPINGEROUTPUT Generate one period of pinger output

% Pinger emits a pulse every 2 seconds - set .05 to avoid processing zeros
pinger_period = .05;

% Ping lasts for 1.3 ms
ping_duration = .0013;

% Sample rate of 1 MHz
sample_period = 1/sample_frequency;

% Generate 2 seconds of empty signal
time = 1:(pinger_period/sample_period);

%Arbitrarily begin ping at 1/2 pinger_period second mark
ping_time = (length(time)/2):(length(time)/2 + ping_duration/sample_period);

signal = zeros(1, length(time));

signal(ping_time) = sin(2*pi*pinger_frequency*ping_time*sample_period);



end

