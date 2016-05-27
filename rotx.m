%%Rotation um x-Achse:
%%M1) Write three Matlab functions returning the 4x4 transformation matrix T for the three basic
%%rotations around the x, y, and z axes. a is the angle of rotation in degrees.


function Tx=rotx(phi)

%phi=input('Geben Sie den Rotationswinkel um die x-Achse an: ')

Tx=[1 0 0 0; 0 cosd(phi) -sind(phi) 0; 0 sind(phi) cosd(phi) 0; 0 0 0 1]; % Return 4x4 Matrix

%help function
%doc function
%help[]


