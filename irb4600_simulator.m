% M13) Write a main Matlab Function to incorporate all necessary functions to simulate the ABB
% IRB4600

function irb4600_simulator()
%IRB4600_SIMULATOR Summary of this function goes here
%   Detailed explanation goes here

%% Aufräumen
%clc, clear all, close all;

%% Roboter laden
robot = irb4600_robot;

%% Angabe für die Simulaion
ks_length = 100;

t_ipo=0.1;
amax=1500;
vc=500;
pose=2;
erase=1;

e(1)=[1040,0,1480,0,95,0,0];
e(2)=[500,-1000,1000,0,180,0,2*vc];
e(3)=[500,-1000,500,0,180,0,vc/2];
e(4)=[500,-1000,1000,0,180,0,vc];
e(5)=[500,-1100,1000,-90,90,0,vc];
e(6)=[500,-1500,1000,-90,90,0,vc/2];

%% Trajektorie
for i=1:length(e)-1
    [tx,ax]=create_lin_seg_list( e((i+1)*1:i*3,1), e((i+1)*1:i*3,1), vc, amax, t_ipo);
    [ t, a, v, s ] = create_lin_intvec( tx, ax, t_ipo );
    ec(i) = create_lin_path( e(i)(1:6), e(i+1)(1:6), s );
    if i == 1,
        ec_total = ec(i);
    else
        ec_total = [ec_total, ec(i)];
    end;
end
%% berechnet celly array q
for i=1:1:length(ec_total),
    tg(i) = xyzabc_2_t(ec_total(i)(1), ec_total(i)(2), ec_total(i)(3), ec_total(i)(4), ec_total(i)(5), ec_total(i)(6));
    q(i) = irb4600_rk( tg(i), robot.bas, robot.eff , pose)
    
    if isnan(q(i)) ~= 0,
        error('Robot can not move this path in the desired pose!');
    end;
end;

%% Roboter Zeichnen
draw_robot_path(q,0.5,robot,ks_length,1 );


end

