% Simulate sonar over a range of pinger positions and calculate error

% Number of points to increment over on each axis
sample_points = 100;

% Possible pinger frequencies in hertz
available_pinger_frequency = [22000;23000;24000;25000;26000;27000;28000;29000;30000];

% Pinger frequency in use
pinger_frequency = available_pinger_frequency(1);

% Highest possible pinger frequency, used for hydrophone spacing
max_frequency = available_pinger_frequency(length(available_pinger_frequency));

% Sample rate
sample_frequency = 1000000;

% Set arbitrary water temperature of 90F
water_temp = 90;

% Allowable error in cone intersection
intersection_sigma = 0.5;

% Max distance to a point in the pool
pool_size = 200;

% Place the pinger in the same plane as hydrophones
rho = 10;
phi = pi/2;
theta = linspace(0, 2*pi, sample_points);

phi_error = zeros(1, sample_points);
theta_error = zeros(1, sample_points);

start_time = tic;

for i = 1:length(theta)
    [phi_error(i) theta_error(i)] = simulateSonarError(rho,phi,theta(i),intersection_sigma,pool_size, pinger_frequency, max_frequency, sample_frequency, water_temp);
     
    % Timekeeping
    elapsed = toc(start_time);
    remaining = (elapsed)*(length(theta)/i - 1);
    
    fprintf('Finished iteration %d at theta=%f deg with phi error %f theta error %f\n', i, theta(i)*180/pi, phi_error(i)*180/pi, theta_error(i)*180/pi);
    fprintf('%d minutes %f seconds remaining (%d minutes %f seconds elapsed)\n\n', uint32(remaining)/60, mod(remaining,60), uint32(elapsed)/60, mod(elapsed, 60));
    
    
end

% Convert to degrees
phi_error = phi_error * 180/pi;
theta_error = theta_error * 180/pi;

fprintf('\nSimulation finished.\n');
fprintf('Average error: phi=%f, theta=%f\n', mean(phi_error), mean(theta_error));


% Plot results
figure;
subplot(1,2,1);
polar(theta, phi_error, '-b');
title('Azimuth Angle [degrees] vs. Zenith Estimation Error [degrees]');
hold on;
subplot(1,2,2);
polar(theta, theta_error, '-r');
%legend('{\phi} error', '{\theta} error');
title('Azimuth Angle [degrees] vs. Azimuth Estimation Error [degrees]');
