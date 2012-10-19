function [ hydrophone_signal] = addPropagationDelay( source_signal, hydrophones, sample_frequency, pinger, water_velocity)
%ADDPROPAGATIONDELAY Generate propagation delay based on hydrophone location
%and pinger location.

distance = zeros(1, length(hydrophones));
hydrophone_signal= cell(1, length(hydrophones));

% Get pinger location in cartesian coordinates
%pinger = [rho*sin(phi)*cos(theta),rho*sin(phi)*sin(theta),rho*cos(phi)];

% Get distances from pinger to hydrophones
for i = 1:length(hydrophones)
    distance(i) = norm(hydrophones{i} - pinger);
end

% Get propagation delays in seconds
delay = zeros(1,4);

for i = 1:length(hydrophones)
    delay(i) = distance(i) / water_velocity;
end

% Convert delay to sampled timescale
delay  = delay .* sample_frequency;

delay = uint32(delay);

assignin('base', 'delay', delay);

% Generate delayed signals

%source_signal = source_signal + (rand(1, length(source_signal)) - .5)*2;

for i = 1:length(hydrophones)
    hydrophone_signal{i} = [zeros(1, delay(i)), source_signal(1:(length(source_signal) - delay(i)))];
end

end

