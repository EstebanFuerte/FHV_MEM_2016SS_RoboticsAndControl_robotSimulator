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
T_1 = roty(45)

