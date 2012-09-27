function [A] = createCone(x_origin, y_origin, z_origin, rho, phi, z_rotation)

num_points = 50;

A = [];

%radius
rho = linspace(0, rho, num_points);

for i = 1:length(rho)

% Azimuth angle on yz plane
theta = linspace(0, 2*pi, num_points);

%[theta, rho] = meshgrid(theta, rho);

% Get cone in cartesian coordinates
z = rho(i).*sin(phi).*cos(theta);
y = rho(i).*sin(phi).*sin(theta);
x = rho(i).*cos(phi);

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

B = [X;Y;Z];
A = [A,B];

end

%mesh(X,Y,Z);
%A=[X;Y;Z];

end