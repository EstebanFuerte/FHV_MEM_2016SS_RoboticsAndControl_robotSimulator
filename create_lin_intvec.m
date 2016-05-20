% M10) Write a Matlab Function to generate the interpolation vector s(t) from the segment list (output
% of function M9) of one leg of a linear trajectory.
% This function generates the equations of motion for one leg of a linear trajectory specified by the
% segment list [tx ax].
% The output vectors [t,a,v,s] are supposed to have one entry for each tick of the interpolation
% clock.

% Input parameters:
% tx ... column vector with the duration of each segment
% ax ... column vector with the acceleration used for each segment
% t_ipo ... interpolation clock

% Output parameters:
% t ... vector containing time
% a ... vector containing the acceleration profile of the traj.
% v ... vector containing the velocity profile of the trajectory
% s ... interpolation vector for the trajectory

function [t,a,v,s] = create_lin_intvec(tx,ax,t_ipo)

t_start=0;
t_end=tx(1)+tx(2)+tx(3);
t=(t_start:t_ipo:t_end)';

vc=ax(1)*tx(1);

s0=(1/2)*ax(1)*tx(1)^2;
s1=s0+vc*tx(2);

korr1=length(t_start:t_ipo:tx(1))-1;
korr2=length(t_start:t_ipo:tx(2));

for i=1:1:length(t)

if t(i) < tx(1);                 
    a(i)=ax(1);
    v(i)=ax(1)*t(i);
    s(i)=(1/2)*ax(1)*t(i)^2;
    
elseif t(i) < (tx(1)+tx(2))      
        a(i)=ax(2);             %ax(2)=0;
        v(i)=vc;
        s(i)=s0+v(i)*t(i-korr1);
else 
    a(i)=ax(3);
    v(i)=vc+ax(3)*t(i-korr2);
    s(i)=s1+vc*t(i-korr2)+(1/2)*ax(3)*t(i-korr2)^2;
end
end
end