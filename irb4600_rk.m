% M8) Write a Matlab function to calculate the backward Kinematics of the 
% IRB 4600?60. The function shall return the column vector of the joint 
% variables (q) for a given pose of the robot if the end?effector reaches 
% a goal TG.

function q = irb4600_rk(tg,bas,eff,pose)
%IRB4600	Backwards Kinematics of the ABB IRB4600-60 Manipulator
%
%	Q = IRB4600_RK(TG,BAS,EFF,POSE)  calculates the joint angles Q of the Backward Kinematic Solution
%	of the ABB IRB4600-60 manipulator for a given goal transformation T and
%	desired configuration POSE
%   Limits of axis angles are currently not taken into account
%	
%	tg: goal frame
%   bas: base frame
%   eff: tool frame
%   pose: is the desired robot configuration
% 
%   pose    q1      Elbow   wrist
%    1      s1      s1      s1
%    2      s1      s1      s2
%    3      s1      s2      s1
%    4      s1      s2      s2
%    5      s2      s2      s1
%    6      s2      s2      s2
%    7      s2      s1      s1
%    8      s2      s1      s2
%
%
%   ALL ANGLES IN DEGREES !!
%
%	Copyright (c) 2010, 2016 by Robert Merz

error(nargchk(4,4,nargin));

[m,n] = size(bas);
if (n ~= 4)|(m ~= 4)
	error('Base Frame must be 4 by 4');
end

[m,n] = size(eff);
if (n ~= 4)|(m ~= 4)
	error('Tool Frame must be 4 by 4');
end

[m,n] = size(tg);
if (n ~= 4)|(m ~= 4)
	error('Goal Frame must be 4 by 4');
end

if (pose<1)|(pose>8)
	error('Configuration must be between 1 and 8');
end

% DH-parameters for ABB IRB4600-60
d1=495;
a1=175;
a2=900;
a3=175;
d4=960;
d6=135;

%Calculate the coordinate frame of the flange {6} in {0}
t=eye(4);% *****

%Calculate the origin of Frame {4} in {0}
p4=[0,0,0,1]'; % *****
p4 = inv(bas)*tg*inv(eff)*[0;0;-d6;1];
%p4 =	[(a1+a2*cosd(theta2)+a3*(sind(theta2+theta3))+d4*cosd(theta2+theta3))*cosd(theta1);...
%        (a1+a2*cosd(theta2)+a3*(sind(theta2+theta3))+d4*cosd(theta2+theta3))*sind(theta1);...
%        -a2*sind(theta2)+d1+a3*cosd(theta2+theta3)-d4*sind(theta2+theta3);...
%        1];
  
%Calculate theta1 (two solutions)
if pose<5
    q(1)=0; % ***** solution 1 for theta1
    q(1)= atan2(p4(2),p4(1));
else
	q(1)=0; % ***** solution 2 for theta1
    q(1)= atan2(-p4(2),-p4(1));
end 
theta1=q(1);   
   

%Calculate theta2
r=p4(x)*cosd(theta1)+p4(2)*sind(theta1)

%check if a solution is possible
if (k3^2>(k1^2+k2^2))% ***** no solution possible
    disp('no solution for theta2 and theta3');
    for j=1:6
       q(j)=NaN;
    end
else
%there are two solutions for theta2   
   	if (pose==1)|(pose==2)|(pose==5)|(pose==6)
			q(2)=0; % ***** solution 1 for theta2
            q(2) = atan2(k2,k1)+atan2(sqrt(k1^2+k2^2-k3^2),k3);
		else
			q(2)=0; % ***** solution 2 for theta2
            q(2) = atan2(k2,k1)-atan2(sqrt(k1^2+k2^2-k3^2),k3);
    end
    
%check if -180 < theta2 < 180
if q(2)>180 q(2)=q(2)-360;
elseif q(2)<-180 q(2)=q(2)+360;
end
theta2=q(2);

% Calculate theta3
q(3)=0; % ***** there is only one solution for theta3
k4 = -a1-a2*cosd(theta2)+r;
k5 = -a2*sind(theta2)+d1-p4(3);
q(3)=-q(2)+atan2(d4*k5+a3*k4,d4*k4-a3*k5);

%check if -180 < theta3 < 180
if q(3)<-180
    q(3)=360+q(3);
elseif q(3)>180
   	q(3)=q(3)-360;
end
theta3=q(3);
	

%Calculate forward kinematics t03
t03=eye(4); % *****
t01 = [cosd(theta1), -sind(theta1),0,0;...
        sind(theta1),cosd(theta1),0,0;...
        0,0,1,d1;...
        0,0,0,1];
t12 = [cosd(theta2),-sind(theta2),0,a1;...
        0,0,1,0;
        -sind(theta2),-cosd(theta2),0,0;
        0,0,0,1];
t23 = [sind(theta3), cosd(theta3),0,a2;...
        -cosd(theta3),sind(theta3),0,0;...
        0,0,1,0;...
        0,0,0,1];
t03 = t01*t12*t23;

%Calculate t36
t36=eye(4); %*****
t36 = inv(t03)*inv(bas)*tg*eff;
      
%Calculate theta4-6 - they are the zyz-Euler Angles of t36
if abs(t36(2,3))>0.999
	disp('sherical wrist in singularity');
	q(6)=0;
	if t36(2,3)>0
   		q(5)=0;
   		q(4)=atan2d(-t36(3,1),t36(3,2));
    else
        q(5)=180;
      	q(4)=atan2d(-t36(3,1),t36(1,1));
    end   
    
    
else % Calculate theta5, theta4, theta6 when sperhical wrist not in singularity
   	if mod(pose,2)==1
      	q(5)=0; % ***** solution 1 for theta 5
        q(5)=atan2(sqrt(t36(2,1)^2+t36(2,2)^2),t36(2,3));
   	else
   		q(5)=0; % ***** solution 2 for theta 5
        q(5)=atan2(-sqrt(t36(2,1)^2+t36(2,2)^2),t36(2,3));
    end
    theta5=q(5);
    
   	q(4)=0; % *****
    q(4)=atan2(-t36(3,3)/sind(theta5),-t36(1,3)/sind(theta5));
   	q(6)=0; % *****
    q(6)=atan2(t36(2,2)/sind(theta5),-t36(2,1)/sind(theta5));
    %end

end


   

