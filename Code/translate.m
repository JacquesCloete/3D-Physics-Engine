function shapet=translate(shape,a,b,c)
% translate.m
% Translates a given shape by (a,b,c)

x=shape(:,1);    % Extract X-coordinates for each point
xt=x+a;          % Add A to each X-coordinate
y=shape(:,2);    % Extract Y-coordinates for each point
yt=y+b;          % Add B to each Y-coordinate
z=shape(:,3);    % Extract Z-coordinates for each point
zt=z+c;          % Add C to each Z-coordinate

shapet=[xt yt zt];    %Reform the new shape matrix