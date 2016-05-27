% M7) Write a Matlab function to calculate the forward kinematics T of a robot which is given by the
% structure of robot parameters (robot) and the column vector with the joint variables (q).

%% Input & Result:
%"q" is always a column vector and contains information about joint variables
%"robot" is roboter configuration defined in irb4600_robot

%T=Transformation matrix n in 0.

function [ T ] = fk_craig(q,robot)

[zz ss] = size(q);      %zz=number of axis / ss=number of columns (always 1)
dhp = robot.dhp;
bas = robot.bas;
eff = robot.eff;
   
% T initalisieren
T =bas;

for i = 1:zz
    if dhp(i,1) == 1
        T_help = dh_trafo_craig(dhp(i,3),dhp(i,4),dhp(i,5),dhp(i,6)+dhp(i,2)*q(i,1));
        T = T * T_help;
    elseif dhp(i,1) == 2
        T_help = dh_trafo_craig(dhp(i,3),dhp(i,4),dhp(i,5)+dhp(i,2)*q(i,1),dhp(i,6));
        T = T * T_help;
    else
        error('WRONG AXIS-TYPE DEFINED');
    end
end

T=T*eff;

end

