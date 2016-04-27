function [ T ] = rotz( a )
%Function gives back the tranformation matrix(4x4) T
%   Rotation about the x axis
T = [cosd(a) -sind(a) 0 0; sind(a) cosd(a) 0 0; 0 0 1 0; 0 0 0 1];
end

