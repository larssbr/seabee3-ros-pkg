function [phi_error, theta_error] = simulateSonarError(rho, phi, theta, intersection_sigma, pool_size, pinger_frequency, max_frequency, sample_frequency, water_temp)
%SIMULATESONARERROR Run sonar simulation and measure error from
%on azimuth and zenith estimates

% Get velocity of the pinger signal
water_velocity = waterVelocityLookup(water_temp);

% Set hydrophone array side length to half wavelength of max pinger freq.
hydrophone_spacing = water_velocity/max_frequency/2;

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

% Generate the source signal
[time, signal] = generatePingerOutput(pinger_frequency, sample_frequency);

% Add propagation delay
[hydrophone_1 hydrophone_2 hydrophone_3] = addPropagationDelay(signal, sample_frequency, hydrophone_spacing, rho, phi, theta, water_temp);

% Take FFT and get phase differences
phase(1)= givepd(hydrophone_1, hydrophone_2);
phase(2)= givepd(hydrophone_1, hydrophone_3);
phase(3)= givepd(hydrophone_2, hydrophone_3);

% Normalize phase to +-pi/2, angle from inter-hydrophone normal
phase = phase./2;
phase = pi/2 - phase;

% Create cones of possible pinger locations
cone_a = createCone(cone1_x, cone1_y, cone1_z, pool_size, phase(1), phase_rotation(1));
cone_b = createCone(cone2_x, cone2_y, cone2_z, pool_size, phase(2), phase_rotation(2));
cone_c = createCone(cone3_x, cone3_y, cone3_z, pool_size, phase(3), phase_rotation(3));

% Set intersect cones
%intersection_cartesian= findPing(cone_a, cone_b, cone_c, intersection_sigma);

[Ai, Bi, Ci] = findPing3Way(cone_a, cone_b, cone_c, intersection_sigma);

intersection_cartesian = [Ai, Bi, Ci];

% Filter out points within 5 ft radius of hydrophone array
intersection_cartesian = intersection_cartesian(:, sqrt(intersection_cartesian(1,:).^2 + intersection_cartesian(2,:).^2 + intersection_cartesian(3,:).^2) > 5);

intersection_rho = sqrt(intersection_cartesian(1,:).^2 + intersection_cartesian(2,:).^2 + intersection_cartesian(3,:).^2);

intersection_spherical= [intersection_rho; acos(intersection_cartesian(3,:)./intersection_rho); atan2(intersection_cartesian(2,:),intersection_cartesian(1,:))];


% Stupid way of fixing singularity at theta = pi/-pi
%intersection_spherical(3, intersection_spherical(3,:) < -165*pi/180) = abs(intersection_spherical(3, intersection_spherical(3,:) < -165*pi/180));


% Makes it so that taking the mean of theta at the pi/-pi singularity works
if ~isempty(intersection_spherical(3, intersection_spherical(3,:) > 0)) && ~isempty(intersection_spherical(3, intersection_spherical(3,:) < 0))
   %intersection_spherical(3, intersection_spherical(3,:) < -170*pi/180) = abs(intersection_spherical(3, intersection_spherical(3,:) < -170*pi/180));

    intersection_spherical(3,:) = abs(intersection_spherical(3,:));
    %intersection_spherical(3,intersection_spherical(3,:)<0) = intersection_spherical(3,intersection_spherical(3,:)<0) + 2*pi;
end

% Get average pinger location
avg_intersect_spherical = [mean(intersection_spherical(1,:)); mean(intersection_spherical(2,:)); mean(intersection_spherical(3,:))];

phi_error = angleDifference(phi, avg_intersect_spherical(2));
theta_error = angleDifference(theta, avg_intersect_spherical(3));

fprintf('Found %d possible pinger points\n', length(intersection_spherical));

fprintf('Got average pinger angles: phi=%f deg, theta=%f deg\n', avg_intersect_spherical(2)*180/pi, avg_intersect_spherical(3)*180/pi);
fprintf('Truth values: phi=%f, theta=%f deg\n', phi*180/pi, theta*180/pi);
fprintf('Error: phi %f deg, theta %f deg\n', phi_error*180/pi, theta_error*180/pi);


end

