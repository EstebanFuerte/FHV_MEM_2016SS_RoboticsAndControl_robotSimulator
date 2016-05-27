function [coor_w] = coortraf_craig(q,robot)
%
% Calculates all frames of a robot in world
% coordinates into a {n+2}[4 4] Cellarray
% using CRAIG frame assignments
%
%************************************************
%   Prof.(FH) DI Dr. Robert Merz                *
%   2010                                        *
%                                               *
%   adapted from koortraf.m by                   *
%   Prof. Georg Stark, Fachhochschule Augsburg  *
%************************************************
%
%% Input Parameters:
% q:        column vector with joint values,[n 1] Array
%                                            n: number of axes
% robot:    structure with robot parameters
%           robot.dhp  DH parameter, [n 6] Array
%           colums:    type   sign  alpha  a    d    theta 
%                      (1/2) (1/-1)
%                       1...rotational axis
%                       2...translational axis
%
%           robot.eff:  tool frame (in flange coordinates)
%           [4 4] Array
%
%           robot.bas base frame (in world coordinates)
%           [4 4] Array
%
%   ALL ANGLES in DEG!!
%
% Return Parameters:
% coor_w:    all coordinate frames in world coordinates
%            {n+2}[4 4] Cellarray; 
%


dhp = robot.dhp;
bas = robot.bas;
eff = robot.eff;      % tool frame
eff_w=bas;            % base frame

[na s]=size(dhp);      % number of axes
[nq z]=size(q);        % number of joint values
if na~=nq
    error('number of joint values does not match number of robot axes')
    return
end

if z~=1  %Überprüfung q ein Spaltenvektor ist (if z ungleich 1?)
    error('vector of joint values is not a column vector')
    return
end

coor_w{1}=bas; % account for base frame

for ii=1:nq
    vorz=dhp(ii,2);
    if dhp(ii,1)==1     % rotational axis
        traf=dh_trafo_craig(dhp(ii,3), dhp(ii,4), dhp(ii,5),dhp(ii,6)+vorz*q(ii));
    elseif dhp(ii,1)==2 % translational axis
        traf=dh_trafo_craig(dhp(ii,3), dhp(ii,4), dhp(ii,5)+vorz*q(ii),dhp(ii,6));
    else
        error('only rotational axis (1) or translational axis (2) possible')
    end
    eff_w=eff_w*traf;
    coor_w{1+ii}=eff_w;
end

coor_w{1+ii+1}=eff_w*eff;

