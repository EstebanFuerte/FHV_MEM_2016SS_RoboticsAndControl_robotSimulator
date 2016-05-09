function [ T ] = fk_craig( q, robot )
%FK_CRAIG calculate the forward kinematics T of a robot which is given by
%the structure of robot parameters (robot) and the column vecotr with the
%joint variables q
%   robot = structure; dh parameter (6x6), base (4x4) and eff (4x4)

% add q to the dh parameters

for i=1:length(robot.dhp)
    robot.dhp(i,6) = robot.dhp(i,6)+q(i);
end


T_1 = dh_trafo_craig(robot.dhp(1,3),robot.dhp(1,4),robot.dhp(1,5), robot.dhp(1,6));
T_2 = dh_trafo_craig(robot.dhp(2,3),robot.dhp(2,4),robot.dhp(2,5), robot.dhp(2,6));
T_3 = dh_trafo_craig(robot.dhp(3,3),robot.dhp(3,4),robot.dhp(3,5), robot.dhp(3,6));
T_4 = dh_trafo_craig(robot.dhp(4,3),robot.dhp(4,4),robot.dhp(4,5), robot.dhp(4,6));
T_5 = dh_trafo_craig(robot.dhp(5,3),robot.dhp(5,4),robot.dhp(5,5), robot.dhp(5,6));
T_6 = dh_trafo_craig(robot.dhp(6,3),robot.dhp(6,4),robot.dhp(6,5), robot.dhp(6,6));

T = T_1*T_2*T_3*T_4*T_5*T_6;

end



