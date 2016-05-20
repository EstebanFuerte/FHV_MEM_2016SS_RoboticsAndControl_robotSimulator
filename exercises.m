clear all, close all, clc;

% E1a
%  A Vector  AP is rotated about Y_A  by 30 degrees and is subsequently 
% rotated about X_A  by 45 degrees. Give the rotation matrix which 
% accomplishes these rotations in the given order.
T_1 = roty(30);
T_2 = rotx(45);
T = T_1*T_2