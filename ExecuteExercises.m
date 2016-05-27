%% M6) Visualize robot
clear all;

axis([-2800 2800 -2800 2800 -0.2 2800]);
view([102,20]);
grid on; xlabel('X'); ylabel('Y'); zlabel('Z');
robot=irb4600_robot();
q=[0 -90 90 0 0 0]';
koor=coortraf_craig(q,robot);
ks_length=100;
draw_kin(koor,ks_length);

%% M8) Test ABB IRB4600-60 Backward-Kinematic Routine
clear all;

q=[0 0 0 0 0 0]';
robot = irb4600_robot();
tg=fk_craig(q,robot);
eff=eye(4);
bas= eye(4);
irb4600_rk(tg,bas,eff,3)

%% M9) Test Function to generate the segment list for a linear trajectory
clc;

e1=[100 0 0];
e2=[500 0 0];
vc=100;
amax=250;
t_ipo=0.5;
create_lin_seg_list(e1,e2,vc,amax,t_ipo)

%% M10 Test Function to generate the interpolation vector s(t) from the segment list (output of function M9)
clc;

e1=[100 0 0];
e2=[500 0 0];
vc=100;
amax=250;
t_ipo=0.5;
[tx, ax]=create_lin_seg_list(e1,e2,vc,amax,t_ipo);
create_lin_intvec(tx,ax,t_ipo)

%% M11 cell array containing the interpolated positions for a linear robot trajectory.
clc;

e1=[100 0 0];
e2=[500 0 0];
vc=100;
amax=250;
t_ipo=0.5;
[tx, ax]=create_lin_seg_list(e1,e2,vc,amax,t_ipo);
[t,a,v,s]=create_lin_intvec(tx,ax,t_ipo);
create_lin_path(e1,e2,s)
