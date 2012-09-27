function [ hydrophone_1 hydrophone_2 hydrophone_3 ] = addPropagationDelay( source_signal, sample_frequency, hydrophone_spacing, rho, phi, theta, water_temp)
%ADDPROPAGATIONDELAY Generate propagation delay based on hydrophone location
%and pinger location.

% Get pinger location in cartesian coordinates
pinger_x = rho*sin(phi)*cos(theta);
pinger_y = rho*sin(phi)*sin(theta);
pinger_z = rho*cos(phi);

% Get hydrophone coordinates
hydro1_x = hydrophone_spacing*sqrt(3)/3;
hydro1_y = 0;

hydro2_x = -hydrophone_spacing * sqrt(3)/6;
hydro2_y = -hydrophone_spacing/2;

hydro3_x = -hydrophone_spacing * sqrt(3)/6;
hydro3_y = hydrophone_spacing/2;

% Get distances from pinger to hydrophones
distance(1) = sqrt((pinger_x - hydro1_x)^2 + (pinger_y - hydro1_y)^2 + pinger_z^2);
distance(2) = sqrt((pinger_x - hydro2_x)^2 + (pinger_y - hydro2_y)^2 + pinger_z^2);
distance(3) = sqrt((pinger_x - hydro3_x)^2 + (pinger_y - hydro3_y)^2 + pinger_z^2);

% Get speed of sound in water
water_velocity = waterVelocityLookup(water_temp);

% Get propagation delays in seconds
delay = zeros(1,3);

for i = 1:3
    delay(i) = distance(i) / water_velocity;
end

% Convert delay to microseconds
delay  = delay .* sample_frequency;

delay = uint32(delay);

% Generate delayed signals
hydrophone_1 = [zeros(1, delay(1)), source_signal(1:(length(source_signal) - delay(1)))];
hydrophone_2 = [zeros(1, delay(2)), source_signal(1:(length(source_signal) - delay(2)))];
hydrophone_3 = [zeros(1, delay(3)), source_signal(1:(length(source_signal) - delay(3)))];



end

