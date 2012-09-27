function [S] = findPing( A,B,C, sigma)

% Note: This function currently only intersects two cone pairs
% All three need to be intersected to minimize error, but this is
% difficult because there are no guarantees about ordering of points

sigma = [sigma, sigma, sigma];

At=transpose(A);
Bt=transpose(B);
Ct=transpose(C);

V1=ismemberf(At,Bt,'rows','tol',sigma);
%V2=ismemberf(Bt,Ct,'rows','tol',sigma);
V3=ismemberf(At, Ct, 'rows', 'tol', sigma);

% Points in all 3 sets
%V4 = V1.*V2.*V3;
V4 = V1.*V3;

% Remove non-intersecting points
S = transpose(At(V4~=0,:));

% Remove all points above the sub
%S = S(:, S(3,:) > 0);

% Remove all points within 5 ft radius of the hydrophone array
S = S(:, sqrt(S(1,:).^2 + S(2,:).^2 + S(3,:).^2) > 5);


end

