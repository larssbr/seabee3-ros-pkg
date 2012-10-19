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
intersection_sigma = 2;

% Max distance to a point in the pool
pool_size = 200;

% Place the pinger in the same plane as hydrophones
rho = 10;
phi = linspace(0, pi, sample_points);
theta = linspace(0, 2*pi, sample_points);

num_iterations = length(phi)*length(theta);

phi_error = zeros(1, num_iterations);
theta_error = zeros(1, num_iterations);

start_time = tic;

for j = 1:length(phi)
    for i = 1:length(theta)
        
        index = (j-1)*length(theta) + i;
        
        [phi_error(index) theta_error(index)] = simulateSonarError(rho,phi(j),theta(i),intersection_sigma,pool_size, pinger_frequency, max_frequency, sample_frequency, water_temp);
        
        % Timekeeping
        elapsed = toc(start_time);
        remaining = (elapsed)*(num_iterations/index - 1);
        
        fprintf('Finished iteration %d at theta=%f phi=%f deg with phi error %f theta error %f\n', index, theta(i)*180/pi, phi(j)*180/pi, phi_error(index)*180/pi, theta_error(index)*180/pi);
        fprintf('%d minutes %f seconds remaining (%d minutes %f seconds elapsed)\n\n', uint32(remaining/60), mod(remaining,60), uint32(elapsed/60), mod(elapsed, 60));
        
        
    end
end

figure;
RadialError3d(phi, theta, theta_error*180/pi);
title('Pinger Azimuth and Elevation vs. {\theta} Error [degrees]')
figure;
RadialError3d(phi, theta, phi_error*180/pi);
title('Pinger Azimuth and Elevation vs. {\phi} Error [degrees]')
figure;
RadialError3d(phi, theta, hypot(theta_error, phi_error)*180/pi);
title('Pinger Azimuth and Elevation vs. {\theta} and {\phi} LS Error [degrees]')
fprintf('\nSimulation finished.\n');
fprintf('Average error: phi=%f, theta=%f\n', mean(phi_error)*180/pi, mean(theta_error)*180/pi);

