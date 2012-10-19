function RadialError3d(phi, theta, error)
%RADIALERROR3D Plots error in 3d as a function of zenith and azimuth angles

[theta, phi] = meshgrid(theta, phi);

error = transpose(reshape(error, length(phi), length(theta)));

x = error.*sin(phi)*cos(theta);
y = error.*sin(phi)*sin(theta);
z = error.*cos(phi);

%[X, Y,] = meshgrid(x,y,z);

mesh(x,y,z);

end

