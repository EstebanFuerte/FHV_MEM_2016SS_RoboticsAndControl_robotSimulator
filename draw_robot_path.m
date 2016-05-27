% M12) Write a Matlab Function to draw the robot moving along a given path.

% Cell array q contains a series of column vectors. Each column vector is one set of joint variables which
% were derived by the interpolation routines. Cell array q is calculated by applying the backward
% kinematics function M8 to each entry of the cell array ec from M11.

% The function will then use coortraf_craig and draw_kin to display the robot on the screen
% for each set of joint variables.

% The impression of a moving robot will be generated by waiting before plotting the next robot
% position for a duration of t_ipo. Use the command pause(t_ipo) to create this delay.

% If erase = 1, the display shall be cleared after each interpolation.
% If erase = 0, the screen shall not be cleared and all interpolations shall be plotted on top of each
% other

function draw_robot_path( q,t_ipo,robot,ks_length,erase )
%
% Input parameters:
% q ... cell array of column vectors of all interpolated joint variables for the whole trajectory
% t_ipo ... interpolation clock
% robot: robot parameters
% ks_length: length for drawing frame axes
% erase: flag to clear screen for each interpolation

%ks = coortraf_craig(q,robot);

% find out how many entries q has:
[rows, cols] = size(q);
for i=1:length(q)
    koor{i} = coortraf_craig(q{i},robot);
    if erase == 1
        clf('reset');
    end
    
	%view([0 0]);
    view([102,20]);
	draw_kin(koor{i},ks_length);
    pause(t_ipo);
    %pause;
end



end
