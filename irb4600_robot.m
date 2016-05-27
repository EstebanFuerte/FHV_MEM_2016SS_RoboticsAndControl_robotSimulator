% M6) Write a Matlab function which returns a structure (like shown below) containing the parameters
% of the IRB 4600-60 robot. Use a parameter set, that reaches the pose shown in Figure 2.17 if the joint
% angles are A1 = 0°, A2 = -90°, A3 = 90°, A4 = 0°, A5 = 0°, A6 = 0°.Initialize the base and tool frame with a
% unity matrix.

% Joint angles are q = [0; -90; 90; 0; 0; 0]

function robot = irb4600_robot()

            %type   sign    alpha   a       d       theta 
robot.dhp = [1       1      0       0       495     0;
             1       1      -90     175     0       0;
             1       1      0       900     0       -90;
             1       1      90      175     -960    0;
             1       1      -90     0       0       0;
             1       1      -90     0       135     180];
         
robot.eff = eye(4);         %initialization of tool frame with identity matrix
robot.bas = eye(4);         %initialization of base frame with identity matrix
end