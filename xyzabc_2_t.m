function [ T ] = xyzabc_2_t( x,y,z,a,b,c )
%XYZABC_2_T Summary of this function goes here
%   Detailed explanation goes here

%x-y-z rotation um das Referenzsystem
R = rotz(a)*roty(b)*rotz(c);    % Skript Seite 14

% displacement
P_Borg = trans(x,y,z);

% Transformation matrix
T = [zeros(4)];
T(1:3, 1:3)= R(1:3, 1:3);    %Zeile 1-3 und Spalte 1-3
T(:,4) = P_Borg(:,4)    ;    %Alle von spalte 4

end

