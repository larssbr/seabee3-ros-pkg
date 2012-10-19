function simulateSonarGui(handles)
%SIMULATESONARERROR Run sonar simulation and measure error from
%on azimuth and zenith estimates

% Get velocity of the pinger signal
water_velocity = handles.water_velocity;

% Set hydrophone array side length
hydrophone_spacing = handles.hydrophone_spacing;

% Pinger frequency in use
pinger_frequency = str2double(strtok(get(handles.waterTempEdit, 'String')))*1000;

% Sample rate in Hz
sample_frequency = str2double(get(handles.sampleRateEdit, 'String'))*1000;

% Allowable error in cone intersection
intersection_sigma = str2double(get(handles.intersectionSigmaEdit, 'String'));

% Max distance to a point in the pool
pool_size = str2double(get(handles.poolSizeEdit, 'String'));

% Temperature of water in F
water_temp = str2double(get(handles.waterTempEdit, 'String'));

% Size of the pinger in ft (used for plotting)
pinger_radius = 1;

% Arbitrary pinger location.
phi= str2double(get(handles.pingerPhiEdit, 'String'))*pi/180;
theta = str2double(get(handles.pingerThetaEdit, 'String'))*pi/180;
rho = str2double(get(handles.pingerRhoEdit, 'String'));

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
avg_intersect_cartesian = [mean(intersection_cartesian(1,:)); mean(intersection_cartesian(2,:)); mean(intersection_cartesian(3,:))];
avg_intersect_spherical = [mean(intersection_spherical(1,:)); mean(intersection_spherical(2,:)); mean(intersection_spherical(3,:))];

phi_error = angleDifference(phi, avg_intersect_spherical(2));
theta_error = angleDifference(theta, avg_intersect_spherical(3));

fprintf('Found %d possible pinger points\n', length(intersection_spherical));

fprintf('Got average pinger angles: phi=%f deg, theta=%f deg\n', avg_intersect_spherical(2)*180/pi, avg_intersect_spherical(3)*180/pi);
fprintf('Truth values: phi=%f, theta=%f deg\n', phi*180/pi, theta*180/pi);
fprintf('Error: phi %f deg, theta %f deg\n', phi_error*180/pi, theta_error*180/pi);

% Plot hydrophone signal
axes(handles.signalPlotAxes)
plot(time, signal, 'k');
hold on;
plot(time, hydrophone_1, 'b');
plot(time, hydrophone_2, 'r');
plot(time, hydrophone_3, 'g');

% Plot phase
axes(handles.phasePlotAxes);
bar([1,2,3], [phase(1), phase(2), phase(3)].*180/pi);

% Plot phase cones and pool
axes(handles.conePlotAxes);
hold on;

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


% Plot a sphere at pinger location
%plotSphere(pinger_x, pinger_y, pinger_z, pinger_radius, [0 0 0]);

% Plot a sphere at estimated pinger location
%plotSphere(avg_intersect_cartesian(1), avg_intersect_cartesian(2), avg_intersect_cartesian(3), pinger_radius, [1 0 0]);

% Plot spheres at hydrophone coordinates
%plotSphere(hydro1_x, hydro1_y, 0, hydrophone_spacing/2,[1 0 0]);
%plotSphere(hydro2_x, hydro2_y, 0, hydrophone_spacing/2,[0 1 0]);
%plotSphere(hydro3_x, hydro3_y, 0, hydrophone_spacing/2,[0 0 1]);

% Plot phase cones
plotCone(cone1_x, cone1_y, cone1_z, pool_size, phase(1), phase_rotation(1));
%plotCone(cone2_x, cone2_y, cone2_z, pool_size, phase(2), phase_rotation(2));
%plotCone(cone3_x, cone3_y, cone3_z, pool_size, phase(3), phase_rotation(3));




end

