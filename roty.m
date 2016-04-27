function [ T ] = roty( a )
%Function gives back the tranformation matrix(4x4) T
%   Rotation about the y axis
T = [cosd(a) 0 sind(a) 0; 0 1 0 0; -sind(a) 0 cosd(a) 0; 0 0 0 1];
end

