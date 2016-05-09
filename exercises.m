clear all, close all, clc;

% E1a
%  A Vector  AP is rotated about Y_A  by 30 degrees and is subsequently 
% rotated about X_A  by 45 degrees. Give the rotation matrix which 
% accomplishes these rotations in the given order.
T_1 = roty(30);
T_2 = rotx(45);
T_E1a = T_1*T_2


% E1b 
% A frame {B} is located as follows: Initially coincident with a frame 
% {A} we rotate {B} about ZB  by 30 degrees and then we rotate the 
% resulting frame about XB  by 45 degrees. Give the rotation matrix 
% which will change the description of vectors from  BP to  AP.

T_1 = rotz(30);
T_2 = rotx(45);
T = T_1*T_2;
R_E1b = T(1:3,1:3)

% E1c
% A frame {B} is conincident with frame {A}. {B} is first rotated around 
% the yA ?axis by 45°, then rotated around the zA ?axis by 15°, then 
% translated by 5 in the yA ?direction  and then rotated around the xA 
% ?axis by 30°. Calculate the resulting transformation matrix.
T_1 = roty(45);

%E6) A drilling machine is attached to the center of the flange of the 
%ABB IRB 4600?60 robot. The distances from the flange to the tip of the 
%drill bit are shown in the following drawing. 
robot = irb4600_robot;
robot.eff = dh_trafo_craig(0,-120,200,0);
q = [34.5923, -102.5683, 135.3996, 128.1724, 46.2335, 138.6557]';
koor = coortraf_craig(q,robot);
draw_kin(koor,2);
q = [34.5923, -81.8669, 145.8491, 142.4964, 68.8321, 164.5109]';
koor = coortraf_craig(q,robot);
draw_kin(koor,2);
q = [34.5923, -65.7966, 145.9423, 145.0086, 81.9008, 174.3678]';
koor = coortraf_craig(q,robot);
draw_kin(koor,2);
q = [34.5923, -48.5524, 142.4137, 145.3468, 93.1779, -177.8056]';
koor = coortraf_craig(q,robot);
draw_kin(koor,2);

