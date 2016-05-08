function draw_frame(P,L)
%
% draws the three axes of a coordinate frame
%    x = red, y = green, z = blue
%
%Input Parameters:
%   P: frame, [4 4] Array
%   L: length of axes
%
%************************************************
%   Prof.(FH) DI Dr. Robert Merz                *
%   2010                                        *
%                                               *
%   adapted from zeichne_ks.m by                *
%   Prof. Georg Stark, Fachhochschule Augsburg  *
%************************************************


B = P(1:3,1:3) .* L;
O = [P(1:3,4)'; P(1:3,4)'; P(1:3,4)']';
B = B + O;
hold on
plot3([P(1,4) B(1,1)],[P(2,4) B(2,1)],[P(3,4) B(3,1)],'Color','r','LineWidth',2);
plot3([P(1,4) B(1,2)],[P(2,4) B(2,2)],[P(3,4) B(3,2)],'Color','g','LineWidth',2);
plot3([P(1,4) B(1,3)],[P(2,4) B(2,3)],[P(3,4) B(3,3)],'Color','b','LineWidth',2);

