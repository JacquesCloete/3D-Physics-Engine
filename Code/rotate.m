function shapero=rotate(shape,a,b,c)
% rotate.m
% Rotates a given shape about the origin (ACW)
% Rotation is A rad about x axis, B rad about y axis, and C rad about Z
% axis

x = shape(:,1);    % Extract X-coordinates for each point
y = shape(:,2);    % Extract Y-coordinates for each point
z = shape(:,3);    % Extract Z-coordinates for each point
xro = cos(c)*cos(b)*x + (cos(c)*sin(b)*sin(a)-sin(c)*cos(a))*y + (cos(c)*sin(b)*cos(a)+sin(c)*sin(a))*z;
yro = sin(c)*cos(b)*x + (sin(c)*sin(b)*sin(a)+cos(c)*cos(a))*y + (sin(c)*sin(b)*cos(a)-cos(c)*sin(a))*z;
zro = -sin(b)*x +cos(b)*sin(a)*y + cos(b)*cos(a)*z;
shapero = [xro yro zro];    %Reform the new shape matrix