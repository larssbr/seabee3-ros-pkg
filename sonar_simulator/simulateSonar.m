
% Possible pinger frequencies in hertz
available_pinger_frequency = [22000;23000;24000;25000;26000;27000;28000;29000;30000];

% Pinger frequency in use
pinger_frequency = available_pinger_frequency(1);

% Highest possible pinger frequency, used for hydrophone spacing
max_frequency = available_pinger_frequency(length(available_pinger_frequency));

% Sample rate
sample_frequency = 100000;

% Set arbitrary water temperature of 90F
water_temp = 90;

% Get velocity of the pinger signal
water_velocity = waterVelocityLookup(water_temp);

% Set hydrophone array side length to half wavelength of max pinger freq.
hydrophone_spacing = water_velocity/max_frequency/2;

% Allowable error in cone intersection
intersection_sigma = 2;

% Max distance to a point in the pool
pool_size = 10;

% Size of the pinger in ft
pinger_radius = 1;

% Arbitrary pinger location.
phi= pi/2;
theta = pi/2;
rho = 10;

% Generate the source signal
[time, signal] = generatePingerOutput(pinger_frequency, sample_frequency);

[hydrophone_1 hydrophone_2 hydrophone_3] = addPropagationDelay(signal, sample_frequency, hydrophone_spacing, rho, phi, theta, water_temp);

figure;
subplot(2,1,1);

plot(time, signal, 'k');
hold on;
plot(time, hydrophone_1, 'b');
plot(time, hydrophone_2, 'r');
plot(time, hydrophone_3, 'g');

% Plot the delayed signals
title('Hydrophone Signals');
xlabel('Time [{\mu}s]');
ylabel('Amplitude');
legend('Pinger Output', 'Hydrophone 1', 'Hydrophone 2', 'Hydrophone 3');

% Take FFT and get phase differences
phase(1)= givepd(hydrophone_1, hydrophone_2);
phase(2)= givepd(hydrophone_1, hydrophone_3);
phase(3)= givepd(hydrophone_2, hydrophone_3);

% Plot phase differences
subplot(2,1,2);
bar([1,2,3], [phase(1), phase(2), phase(3)].*180/pi);
title('Hydrophone phase differences');
xlabel('Hydrophone pair');
ylabel('Phase [degrees]');

% Normalize phase to +-pi/2, angle from inter-hydrophone normal
phase = phase./2;
phase = pi/2 - phase;




% Data for cone origins and direction
cone1_x = hydrophone_spacing*sqrt(3)/12;
cone1_y = -hydrophone_spacing/4;
cone1_z = 0;

cone2_x = hydrophone_spacing * sqrt(3)/12;
cone2_y = hydrophone_spacing/4;
cone2_z = 0;

cone3_x = -hydrophone_spacing * sqrt(3)/6;
cone3_y = 0;
cone3_z = 0;

phase_rotation = [pi/6, -pi/6, -pi/2];

%phase_rotation = zeros(1,3);
%phase_rotation(1) = pi/6;
%phase_rotation(2) = -pi/6;
%phase_rotation(3) = -pi/2;

% Create cones of possible pinger locations
cone_a = createCone(cone1_x, cone1_y, cone1_z, pool_size, phase(1), phase_rotation(1));
cone_b = createCone(cone2_x, cone2_y, cone2_z, pool_size, phase(2), phase_rotation(2));
cone_c = createCone(cone3_x, cone3_y, cone3_z, pool_size, phase(3), phase_rotation(3));

%figure;
%scatter(cone_c(1,:), cone_c(3,:));

% Set intersect cones
%intersection_cartesian= findPing(cone_a, cone_b, cone_c, intersection_sigma);

[Ai, Bi, Ci] = findPing3Way(cone_a, cone_b, cone_c, intersection_sigma);

intersection_cartesian = [Ai, Bi, Ci];

% Filter out points within 5 ft radius of hydrophone array
intersection_cartesian = intersection_cartesian(:, sqrt(intersection_cartesian(1,:).^2 + intersection_cartesian(2,:).^2 + intersection_cartesian(3,:).^2) > 5);

intersection_rho = sqrt(intersection_cartesian(1,:).^2 + intersection_cartesian(2,:).^2 + intersection_cartesian(3,:).^2);

intersection_spherical= [intersection_rho; acos(intersection_cartesian(3,:)./intersection_rho); atan2(intersection_cartesian(2,:),intersection_cartesian(1,:))];

% Makes it so that taking the mean of theta at the pi/-pi singularity works
if ~isempty(intersection_spherical(3, intersection_spherical(3,:) > 0)) && ~isempty(intersection_spherical(3, intersection_spherical(3,:) < 0))
    intersection_spherical(3,:) = abs(intersection_spherical(3,:));
end

% Get average pinger location
avg_intersect_cartesian = [mean(intersection_cartesian(1,:)); mean(intersection_cartesian(2,:)); mean(intersection_cartesian(3,:))];
avg_intersect_spherical = [mean(intersection_spherical(1,:)); mean(intersection_spherical(2,:)); mean(intersection_spherical(3,:))];

fprintf('Found %d possible pinger points\n', length(intersection_cartesian));
fprintf('Average pinger location (%f, %f, %f)\n', avg_intersect_cartesian(1), avg_intersect_cartesian(2), avg_intersect_cartesian(3));

fprintf('Got average pinger angles phi=%f deg, theta=%f deg\n', avg_intersect_spherical(2)*180/pi, avg_intersect_spherical(3)*180/pi);
fprintf('Truth values: phi=%f, theta=%f deg\n', phi*180/pi, theta*180/pi);
fprintf('Error: phi %f deg, theta %f deg\n', angleDifference(phi, avg_intersect_spherical(2))*180/pi, angleDifference(theta,avg_intersect_spherical(3))*180/pi);

plot_title = sprintf('Phase Cones with pinger at {\\rho}=%f {\\theta}=%f {\\phi}=%f',rho,theta,phi);
title(plot_title);

% Get pinger coordinates 
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


% Plot simulation with phase cones
figure;
hold on;

% Plot a sphere at pinger location
plotSphere(pinger_x, pinger_y, pinger_z, pinger_radius, [0 0 0]);

% Plot a sphere at estimated pinger location
plotSphere(avg_intersect_cartesian(1), avg_intersect_cartesian(2), avg_intersect_cartesian(3), pinger_radius, [1 0 0]);

% Plot spheres at hydrophone coordinates
plotSphere(hydro1_x, hydro1_y, 0, hydrophone_spacing/2,[1 0 0]);
plotSphere(hydro2_x, hydro2_y, 0, hydrophone_spacing/2,[0 1 0]);
plotSphere(hydro3_x, hydro3_y, 0, hydrophone_spacing/2,[0 0 1]);

% Plot phase cones
plotCone(cone1_x, cone1_y, cone1_z, pool_size, phase(1), phase_rotation(1));
plotCone(cone2_x, cone2_y, cone2_z, pool_size, phase(2), phase_rotation(2));
plotCone(cone3_x, cone3_y, cone3_z, pool_size, phase(3), phase_rotation(3));

% Plot results of cone intersection
%scatter3(intersection_cartesian(1,:), intersection_cartesian(2,:), intersection_cartesian(3,:));
%scatter3(Ai(1,:), Ai(2,:), Ai(3,:), 'b');
%scatter3(Bi(1,:), Bi(2,:), Bi(3,:), 'r');
%scatter3(Ci(1,:), Ci(2,:), Ci(3,:), 'g');

% Plot simulation with cone interection
figure;
hold on;

% Plot a sphere control pinger location
plotSphere(pinger_x, pinger_y, pinger_z, pinger_radius, [0 0 0]);

% Plot sphere at estimated pinger location
plotSphere(avg_intersect_cartesian(1), avg_intersect_cartesian(2), avg_intersect_cartesian(3), pinger_radius, [1 0 0]);

% Plot spheres at hydrophone coordinates
plotSphere(hydro1_x, hydro1_y, 0, hydrophone_spacing/2,[1 0 0]);
plotSphere(hydro2_x, hydro2_y, 0, hydrophone_spacing/2,[0 1 0]);
plotSphere(hydro3_x, hydro3_y, 0, hydrophone_spacing/2,[0 0 1]);

% Plot intersection results
%scatter3(intersection_cartesian(1,:), intersection_cartesian(2,:), intersection_cartesian(3,:));
scatter3(Ai(1,:), Ai(2,:), Ai(3,:), 'b');
scatter3(Bi(1,:), Bi(2,:), Bi(3,:), 'r');
scatter3(Ci(1,:), Ci(2,:), Ci(3,:), 'g');

plot_title = sprintf('Set Intersection with pinger at {\\rho}=%f {\\theta}=%f {\\phi}=%f',rho,theta,phi);
title(plot_title);



    