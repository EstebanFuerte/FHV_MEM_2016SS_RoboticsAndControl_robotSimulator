%% Verschiebung/Translation um x, y, z 
%%M2) Write a Matlab function returning the 4x4 transformation matrix T for a translation given by x, y,
%%and z.

function T=trans(x,y,z)
% x=input('Geben Sie die Verschiebung in x-Richtung an: ')
% y=input('Geben Sie die Verschiebung in y-Richtung an: ')
% z=input('Geben Sie die Verschiebung in z-Richtung an: ')
org=[x; y; z; 1];
def=[0 0 0 1];
rot=magic(4);      %magic(a) erstellt beliebige axa matrix
rot(4,1:4)=def;    %Hilfe unter "Access Data in Cell Array" / 4. Zeile von rot wird mit 1x4 Matrix "def" ersetzt
rot(:,4)= org;     %Befehl "vertcat" für mehr Information / 4. Spalte von rot-Matrix wird mit org-Matrix (Ortsvektor) ersetzt
T=rot;

% %function T=trans_x_y_z(rot,org)
% x=input('Geben Sie die Verschiebung in x-Richtung an: ')
% y=input('Geben Sie die Verschiebung in y-Richtung an: ')
% z=input('Geben Sie die Verschiebung in z-Richtung an: ')
% org=[x;y;z;1]
% def=[0 0 0 1];
% Drehung=input('Geben Sie die jeweilige Achsen-Rotationsfunktion (rotx, roty oder rotz): ')
% rot=Drehung;
% rot(4,1:4)=def;
% rot(:,4)= org;
% T=rot;






