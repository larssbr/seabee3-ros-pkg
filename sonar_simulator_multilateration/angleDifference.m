function [difference] = angleDifference(A, B)
%ANGLEDISTANCE Calculate absolute difference betweeen two angles in range
% -2pi to 2pi

if A < 0
    A = A + 2*pi;
end

if B < 0
    B = B + 2*pi;
end

if A - B < pi
    difference = abs(A - B);
else
    difference = B + A - 2*pi;
end


end

