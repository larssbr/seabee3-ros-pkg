% Number of data points to spread sim over
sample_points = 100;

% Pinger location with respect to center of hydrophone array side on the
% bottom of the sub, in spherical coordinates
rho = 50;
phi = pi/4;
theta = linspace(0, 2*pi, sample_points);

% Hydrophone array side length
hydrophone_spacing = 5;


x_error   = zeros(1, sample_points);
y_error   = zeros(1, sample_points);
z_error = zeros(1, sample_points);
pos_cart = zeros(sample_points, 3);
pos_sph = zeros(sample_points, 3);


start_time = tic;

for i = 1:sample_points
    sim_struct   = simulateSonar(sph2cart(theta(i),phi,rho),hydrophone_spacing);
    
     x_error(i) = sim_struct.Error(1); 
     y_error(i) = sim_struct.Error(2);
     z_error(i) = sim_struct.Error(3);
     pos_cart(i,:) = [sim_struct.SolvedPingerPosition(1) sim_struct.SolvedPingerPosition(2) sim_struct.SolvedPingerPosition(3)];
     [th phi r] = cart2sph(sim_struct.SolvedPingerPosition(1), sim_struct.SolvedPingerPosition(2), sim_struct.SolvedPingerPosition(3));
     pos_sph(i,:) = [r phi th];
        
    % Timekeeping
    elapsed = toc(start_time);
    remaining = (elapsed)*(length(theta)/i - 1);
    
    %fprintf('Finished iteration %d at theta=%f deg with phi error %f theta error %f\n', i, theta(i)*180/pi, phi_error(i)*180/pi, theta_error(i)*180/pi);
    fprintf('%d minutes %f seconds remaining (%d minutes %f seconds elapsed)\n\n', uint32(remaining)/60, mod(remaining,60), uint32(elapsed)/60, mod(elapsed, 60));
   
    
end

% z_error = unwrap(z_error);
% 
% % Convert to degrees
% y_error = y_error * 180/pi;
% z_error = z_error * 180/pi;

%fprintf('\nSimulation finished.\n');
%fprintf('Average error: phi=%f, theta=%f\n', mean(phi_error), mean(theta_error));
figure;
hold on;
plot(theta, x_error, 'b');
figure;
hold on;
plot(theta, y_error, 'r');
plot(theta, z_error, 'g');



% Plot results
figure;
subplot(1,3,1);
polar(theta, y_error,'-b');
title('Azimuth Angle [degrees] vs. X Estimation Error [ft]');
hold on;
subplot(1,3,2);
polar(theta, z_error, '-r');
%legend('{\phi} error', '{\theta} error');
title('Azimuth Angle [degrees] vs. Y Estimation Error [ft]');
subplot(1,3,3);
polar(theta, x_error, '-r');
%legend('{\phi} error', '{\theta} error');
title('Azimuth Angle [degrees] vs. Z Estimation Error [ft]');

% Plot results
figure;
subplot(1,3,1);
polar(theta, pos_sph(:, 2)'.*180/pi,'-b');
title('Azimuth Angle [degrees] vs. Zenith Estimate [degrees]');
hold on;
subplot(1,3,2);
polar(theta, pos_sph(:,3)'.*180/pi, '-r');
%legend('{\phi} error', '{\theta} error');
title('Azimuth Angle [degrees] vs. Azimuth Estimate[degrees]');
subplot(1,3,3);
polar(theta, pos_sph(:,1)', '-r');
%legend('{\phi} error', '{\theta} error');
title('Azimuth Angle [degrees] vs. Radius Estimate [ft]');
