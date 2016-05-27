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
t=eye(4); % *****

%Calculate the origin of Frame {4} in {0}
p4=[0,0,0,1]'; % *****

  
%Calculate theta1 (two solutions)
if pose<5
    q(1)=0; % ***** solution 1 for theta1
else
	q(1)=0; % ***** solution 2 for theta1
end 
   
   

%Calculate theta2

%check if a solution is possible
if % ***** no solution possible
    disp('no solution for theta2 and theta3');
    for j=1:6
       q(j)=NaN;
    end
else
%there are two solutions for theta2   
   	if (pose==1)|(pose==2)|(pose==5)|(pose==6)
			q(2)=0; % ***** solution 1 for theta2
		else
			q(2)=0; % ***** solution 2 for theta2
    end
    
%check if -180 < theta2 < 180
if q(2)>180 q(2)=q(2)-360;
elseif q(2)<-180 q(2)=q(2)+360;
end

% Calculate theta3
q(3)=0; % ***** there is only one solution for theta3

%check if -180 < theta3 < 180
if q(3)<-180
    q(3)=360+q(3);
elseif q(3)>180
   	q(3)=q(3)-360;
end
	

%Calculate forward kinematics t03
t03=eye(4); % *****

%Calculate t36
t36=eye(4); %*****
      
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
   	else
   		q(5)=0; % ***** solution 2 for theta 5
   	end
   	q(4)=0; % *****
   	q(6)=0; % *****
	end

end


   

