function robot = irb4600_robot() 
% robot.dhp DH parameters, [n 6] Array
% colums:   type    sign alpha a d theta 
%           (1/2) (1/-1)
%           1...rotational axis
%           2...translational axis
%
% robot.eff: tool frame (in flange coordinates)
% [4 4] Array
%
% robot.bas: base frame (in world coordinates)
% [4 4] Array
% 
% ALL ANGLES IN DEG!!

field1 = 'dhp'; valueDHP = [1,1,0,0,495,0;
                            1,1,-90,175,0,0;
                            1,1,0,900,0,-90;
                            1,1,90,175,-960,0;
                            1,1,-90,0,0,0;
                            1,1,-90,0,135,180];
                        
field2 = 'eff'; valueEff = dh_trafo_craig(-90,0,135,180);
field3 = 'bas'; valueBas = dh_trafo_craig(0,0,495,0);

robot = struct(field1,valueDHP, field2, valueEff, field3, valueBas);

end

