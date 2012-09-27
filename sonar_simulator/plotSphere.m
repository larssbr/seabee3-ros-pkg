function plotSphere(x_origin, y_origin, z_origin, radius, color)

num_points = 100;

% Angle by which to rotate cone about z axis
%z_rotation= pi/4;

% Elevation angle from positive x axis
phi = linspace(0, pi, num_points);


% Azimuth angle on yz plane
theta = linspace(0, 2*pi, num_points);

%radius
rho = radius;

[theta, phi] = meshgrid(theta, phi);

% Get cone in cartesian coordinates
z = rho.*sin(phi).*cos(theta);
y = rho.*sin(phi).*sin(theta);
x = rho.*cos(phi);

%mesh(x,y,z);
%hold on;

% Add offset
X = x + x_origin;
Y = y + y_origin;
Z = z + z_origin;


mesh(X,Y,Z, 'EdgeColor', color);

end