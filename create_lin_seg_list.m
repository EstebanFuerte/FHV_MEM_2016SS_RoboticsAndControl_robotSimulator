% M9) Write a Matlab Function to generate the segment list for a linear trajectory.
% This function will create the segment list for a single leg of a linear trajectory. Movement will start
% with v=0 at e1 and accelerate with amax. Vc is the velocity in the linear portion of the trajectory.
% Movement will decelerate with amax and stop with v=0 at e2.
% Check for trapezoidal and triangular profile.
% Adjust segment times to match the interpolation clock t_ipo.

% Input parameters:
% e1 ... vector with euler coordinates of the start position (3x1 vector)
% e2 ... vector with euler coordinates of the end position (3x1 vector)
% vc ... speed in the linear segment of the trajectory
% amax ... maximum acceleration to be used
% t_ipo ... interpolation clock

% Output parameters:
% tx ... column vector with the duration of each segment
% ax ... column vector with the acceleration used for each segment

function [tx,ax] = create_lin_seg_list(e1,e2,vc,amax,t_ipo)

s_tot=norm(e2(1:3)-e1(1:3));  % absolute value of the trajectory length
s_crit = vc^2/amax; % minimum distance required to accelerate up to vc and decelerate down to 0.

trapezoidal=true;

if s_tot < s_crit
    disp('WARNING: velocity-profile is triangular-shaped => vc CANNOT be reached');
    trapezoidal=false;
else 
     disp('velocity-profile is trapezoidal-shaped => vc can be reached');
end

if trapezoidal==true
    t_a=vc/amax;
    t_d=t_a;
    t_c=(s_tot/vc)-(vc/amax);
else
    t_a=sqrt(s_tot/amax);
    t_c=0;
    t_d=t_a;    
end

%Adjust segment times to match the interpolation clock t_ipo

remainder1=mod(t_a,t_ipo);    %Check if t_a is multiple of t_ipo

if remainder1 ~= 0;
    t_adj1=t_ipo - remainder1;
    t_a_ipo=t_a+(t_adj1);
    t_d_ipo=t_a_ipo;
else
    t_a_ipo=t_a;
    t_d_ipo=t_a_ipo;
    %disp('t_a is a multiple of t_ipo');
end
    
remainder2=mod(t_c,t_ipo);    %Check if t_c is multiple of t_ipo  

if remainder2 ~= 0;
    t_adj2=t_ipo - remainder2;
    t_c_ipo=t_c+(t_adj2);
else
    t_c_ipo=t_c;
    %disp('t_c is a multiple of t_ipo');
end

%% Updated acceleration a_new and linear velocity v_c_new
    
a_new=s_tot/(t_a_ipo^2+t_a_ipo*t_c_ipo);

vc_new=a_new * t_a_ipo;

%% Output vectors

tx=[t_a_ipo; t_c_ipo; t_a_ipo;];
ax=[a_new; 0; -a_new;];

end
