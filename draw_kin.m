function draw_kin(koor,ks_length)
%
% draws the base and tool frame of a robot
% and connects the origin of all frames with black lines
%
% Input parameters:
%   koor: cellarray containing all coordinate frames
%   ks_length: length for drawing frame axes
%
%************************************************
%   Prof.(FH) DI Dr. Robert Merz                *
%   2010                                        *
%                                               *
%   adapted from zeichne_kin_kette.m by         *
%   Prof. Georg Stark, Fachhochschule Augsburg  *
%************************************************


% calculate starting frame
[zz nk]=size(koor);

draw_frame(koor{1},ks_length);
p_vor=koor{1}(1:3,4);
for ii=2:nk
    p_neu= koor{ii}(1:3,4);   
    % draw line between frames
    plot3([p_vor(1) p_neu(1)],[p_vor(2) p_neu(2)],[p_vor(3) p_neu(3)],'Color','k','LineWidth',0.5);
    if ii==nk
         draw_frame1(koor{ii},ks_length);
    end
    p_vor=p_neu;
end % for-loop

