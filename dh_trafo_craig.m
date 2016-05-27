% M5) Write a Matlab function returning the 4x4 transformation matrix T for given DH parameters
% according to Craig’s interpretation).

function T = dh_trafo_craig(alpha,a,d,theta)
Dx=[1 0 0 a; 0 1 0 0; 0 0 1 0; 0 0 0 1];
Dz=[1 0 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];

T=rotx(alpha)*Dx*rotz(theta)*Dz;
end

% Results in:
% 
% T = [cos(theta)             -sin(theta)            0            a
%      sin(theta)*cos(alpha)  cos(theta)*cos(alpha)  -sin(alpha)  -sin(alpha)*d
%      sin(theta)*sin(alpha)  cos(theta)*sin(alpha)  cos(alpha)   cos(alpha)*d
%      0                      0                      0            1];

