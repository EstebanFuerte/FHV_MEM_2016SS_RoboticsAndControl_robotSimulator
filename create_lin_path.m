% M11) Using the output of function M10 write a Matlab Function to create a cell array containing the
% interpolated positions for a linear robot trajectory.

% Input parameters:
% e1 ... vector with euler coordinates for starting position
% e2 ... vector with euler coordinates for end position
% s ... interpolation vector for the trajectory
% Output parameters:
% ec ... cell array containing the vectors of euler coordinates for the interpolated path

function ec = create_lin_path(e1,e2,s)

s_tot=norm(e2(1:3)-e1(1:3));

x=length(s);

for i=1:1:x

ec{i}=e1+((e2-e1)*(1/s_tot)*s(i));

end

end
