% M3) Write a Matlab function returning the 4x4 transformation matrix T if the displacement is given
% by the coordinates x,y,z and the orientation is given by the yaw (a), pitch (b) and roll (c) angles in
% degrees.

%x,y,z ist die Verschiebung vom Ursprung
%yaw = z-Rotation um Winkel a
%pitch = y-Rotation um Winkel b
%roll = x-Rotation um Winkel c

function T = xyzabc_2_t(x,y,z,a,b,c)
Rzyx=rotz(a)*roty(b)*rotx(c);     %Erstellung Rotationsmatrix um z-, y- und x-Achse
org=[x; y; z; 1];                 %Verschiebung um den Punkt (x,y,z)
Rzyx(:,4)= org;                   %Erstellung der Transformationsmatrix, in dem die Verschiebung "org" in die Rotationsmatrix eingefügt wird.
T=Rzyx;                           %Rückgabe Funktionswert