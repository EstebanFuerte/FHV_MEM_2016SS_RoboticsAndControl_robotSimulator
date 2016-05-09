function [ T ] = dh_trafo_craig( alpha,a,d,theta )
%DH_TRAFO_CRAIG Summary of this function goes here
%   Returns the 4x4 transformation matrix for given DH parameters according
%   to Craig's interpretation

T = [ cosd(theta), -sind(theta), 0, a;
      sind(theta)*cosd(alpha), cosd(theta)*cosd(alpha), -sind(alpha), -sind(alpha)*d;
      sind(theta)*sind(alpha), cosd(theta)*sind(alpha), cosd(alpha), cosd(alpha)*d;
      0,0,0,1];

end

