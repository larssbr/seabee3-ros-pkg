function plotCone(x_origin, y_origin, z_origin, rho, phi, z_rotation)

num_points = 100;

% Angle by which to rotate cone about z axis
%z_rotation= pi/4;

% Elevation angle from positive x axis
%phi = pi/16;


% Azimuth angle on yz plane
theta = linspace(0, 2*pi, num_points);

%radius
rho = linspace(0, rho, num_points);

[theta, rho] = meshgrid(theta, rho);

% Get cone in cartesian coordinates
z = rho.*sin(phi).*cos(theta);
y = rho.*sin(phi).*sin(theta);
x = rho.*cos(phi);

% rotate about z axis
X = x.*cos(z_rotation) - y.*sin(z_rotation);
Y = x.*sin(z_rotation) + y.*cos(z_rotation);
Z = z;

%mesh(x,y,z);
%hold on;

% Add offset
X = X + x_origin;
Y = Y + y_origin;
Z = Z + z_origin;


mesh(X,Y,Z);

end