%%Rotation um y-Achse
%%M1) Write three Matlab functions returning the 4x4 transformation matrix T for the three basic
%%rotations around the x, y, and z axes. a is the angle of rotation in degrees.


function Ty=roty(phi)

%phi=input('Geben Sie den Rotationswinkel um die y-Achse an: ')

Ty=[cosd(phi) 0 sind(phi) 0; 0 1 0 0; -sind(phi) 0 cosd(phi) 0; 0 0 0 1];