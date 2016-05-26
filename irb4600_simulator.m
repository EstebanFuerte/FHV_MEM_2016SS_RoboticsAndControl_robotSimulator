% M13) Write a main Matlab Function to incorporate all necessary functions to simulate the ABB
% IRB4600

function irb4600_simulator()
%IRB4600_SIMULATOR Summary of this function goes here
%   Detailed explanation goes here

%% Aufräumen
clc, clear all, close all;

%% Roboter laden
robot = irb4600_robot;

%% Angabe für die Simulaion
ks_length = 100;

% Angabe aus exercises a mfunction irb4600 - M13
t_ipo=0.1;
amax=1500;
vc=1000;
pose=1;

% Euler - Coordinates = (x,y,z,alpha,beta,gamma,?)
e{1}=[1000,-1000,1000,0,45,0,0];
e{2}=[500,0,200,0,90,0,vc];
e{3}=[-1000,1000,1000,0,135,0,vc];
e{4}=[1000,0,1500,0,135,0,vc];
e{5}=[-1000,-1000,1000,0,135,0,vc];
e{6}=[1000,-1000,1000,0,45,0,vc];

%% create trajekt.
for i=1:length(e)-1
    [tx,ax] = create_lin_seg_list(e{i},e{i+1},vc,amax,t_ipo);
    [t,a,v,s] = create_lin_intvec(tx,ax,t_ipo);
    ec{i} = create_lin_path(e{i},e{i+1},s);
end

celldisp(ec)
ec{1}{1}(1)


%% q berechnen
tg = xyzabc_2_t(ec{1}{i}(1),ec{1}{1}(2),ec{1}{1}(3),ec{1}{1}(4),ec{1}{1}(5),ec{1}{1}(6))
q= irb4600_rk(tg,robot.bas,robot.eff, pose)



%% Roboter Zeichnen
%draw_robot_path(q,t_ipo,robot,ks_length,1 );


end

