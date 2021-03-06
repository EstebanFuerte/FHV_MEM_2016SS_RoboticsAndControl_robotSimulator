function q = irb4600_rk(tg,bas,eff,pose)
%   IRB4600	  Backwards Kinematics of the ABB IRB4600-60 Manipulator
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
T6_0 = inv(bas)*tg*inv(eff);
R6_0 = T6_0(1:3,1:3);

%Calculate the origin of Frame {4} in {0}
P4org_4 = [0 0 0 1]';        % Origin of frame {4} in {4}
P4org_6 = [0 0 -d6 1]';      % Origin of frame {4} in {6}
P4org_0 = T6_0 * P4org_6;    % Origin of frame {4} in {0}
  
%Calculate theta1 (two solutions)
if pose<5
    q(1)=atan2d(P4org_0(2,1),P4org_0(1,1)); % solution 1 for theta1
else
	q(1)=atan2d(-P4org_0(2,1),-P4org_0(1,1)); % solution 2 for theta1
end 

%Calculate theta2
r=P4org_0(1,1)*cosd(q(1))+P4org_0(2,1)*sind(q(1));
k1=r-a1;
k2=d1-P4org_0(3,1);
k3=((r-a1)^2+(d1-P4org_0(3,1))^2+a2^2-a3^2-d4^2)/(2*a2);

%check if a solution is possible
if (k1^2+k2^2-k3^2) < 0   % no solution possible
    disp('no solution for theta2 and theta3');
    for j=1:6
       q(j)=NaN;
    end
else
    
%there are two solutions for theta2   
   	if (pose==1)||(pose==2)||(pose==5)||(pose==6)
			q(2)=atan2d(k2,k1)+atan2d(sqrt(k1^2+k2^2-k3^2),k3); % solution 1 for theta2
		else
			q(2)=atan2d(k2,k1)-atan2d(sqrt(k1^2+k2^2-k3^2),k3); % solution 2 for theta2
    end
    
%check if -180 < theta2 < 180
if q(2)>180 
    q(2)=q(2)-360;
elseif q(2)<-180 
    q(2)=q(2)+360;
end

% Calculate theta3
k4=-a1-a2*cosd(q(2))+r;
k5=-a2*sind(q(2))+d1-P4org_0(3,1);

q(3)=-q(2)+atan2d((d4*k5+a3*k4),(d4*k4-a3*k5)); % there is only one solution for theta3

%check if -180 < theta3 < 180
if q(3)<-180
    q(3)=360+q(3);
elseif q(3)>180
   	q(3)=q(3)-360;
end

%Calculate forward kinematics T3_0 & R3_0
T1_0=dh_trafo_craig(0,0,d1,q(1));
T2_1=dh_trafo_craig(-90,a1,0,q(2));
T3_2=dh_trafo_craig(0,a2,0,q(3)-90); 
T3_0=T1_0*T2_1*T3_2;
R3_0=T3_0(1:3,1:3);

%Calculate R6_3 which is R {6} in {3}

%R6_3=inv(R3_0)*inv(bas(1:3,1:3))*tg(1:3,1:3)*inv(eff(1:3,1:3));
R6_3=inv(R3_0)*R6_0;

%Calculate theta4-6 - they are the zyz-Euler Angles of T6_3
if abs(R6_3(2,3))>0.999
	disp('sherical wrist in singularity');
	q(6)=0;
	if R6_3(2,3)>0
   		q(5)=0;
   		q(4)=atan2d(-R6_3(3,1),R6_3(3,2));
    else
        q(5)=180;
      	q(4)=atan2d(-R6_3(3,1),R6_3(1,1));
    end   
    
    
else % Calculate theta5, theta4, theta6 when sperhical wrist not in singularity
   	if mod(pose,2)==1
      	q(5)=atan2d(sqrt(R6_3(2,1)^2+R6_3(2,2)^2),R6_3(2,3));     % solution 1 for theta 5
   	else
   		q(5)=atan2d(-sqrt(R6_3(2,1)^2+R6_3(2,2)^2),R6_3(2,3));    % solution 2 for theta 5
   	end
   	q(4)=atan2d(-R6_3(3,3)/sind(q(5)),-R6_3(1,3)/sind(q(5)));   % solution for theta 4
   	q(6)=atan2d(R6_3(2,2)/sind(q(5)),-R6_3(2,1)/sind(q(5)));    % solution for theta 6
end
end
end

