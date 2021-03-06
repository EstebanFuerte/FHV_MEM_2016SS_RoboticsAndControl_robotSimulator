% M4) Write a Matlab function returning the displacement x,y,z and the yaw (a), pitch (b) and roll (c)
% angles in degrees from the 4x4 transformation matrix T.

%pose=1 => positiver cos(b) / pose=2 => positiver cos(b)
%Funktionstest mit t_2_xyzabc(xyzabc_2_t(4,3,1,30,80,120),1)

function T = t_2_xyzabc(T, pose)

%T=xyzabc_2_t(4,3,1,30,80,120)

if pose==1
    b=atan2d(-T(3,1),sqrt(T(1,1)^2+T(2,1)^2));
elseif pose==2
    b=atan2d(-T(3,1),-sqrt(T(1,1)^2+T(2,1)^2));
end

if b==90
    a=0;
    c=atan2d(T(1,2),T(2,2));
elseif b==-90
    a=0;
    c=-atan2d(T(1,2),T(2,2));
else
    a=atan2d(T(2,1)/cosd(b), T(1,1)/cosd(b));
    c=atan2d(T(3,2)/cosd(b), T(3,3)/cosd(b));
end

x=T(1,4);
y=T(2,4); 
z=T(3,4);
T=[x,y,z,a,b,c];

% fprintf('\nTranslation: x = %d, y = %d, z = %d \n', T(1,4),T(2,4),T(3,4));
% fprintf('Rotation:    a = %d, b = %d, c = %d \n\n', a,b,c); 




