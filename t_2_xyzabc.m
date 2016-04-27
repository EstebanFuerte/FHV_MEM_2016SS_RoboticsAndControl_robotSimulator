function [ x,y,z,a,b,c ] = t_2_xyzabc( T,pose )
%T_2_XYZABC Summary of this function goes here
%   Detailed explanation goes here

a = T(1,4);
b = T(2,4);
c = T(3,4);

% Winkel zurück rechnen
if pose=pos
    b = atan2d(T(3,1),sqrt(T(1,1)^2+T(2,1)^2));
else
    b = atan2d(T(3,1),-sqrt(T(1,1)^2+T(2,1)^2));
end

a = atan2d(T(2,1)/cosd(b), T(1,1)/cosd(b));     % Skriptum Seite 14
c = atan2d(T(3,2)/cosd(b), T(3,3)/cosd(b));     % Skriptum Seite 14

end

