function shaperoa=rotateabout(shape,a,b,c,x,y,z)
% rotateabout.m
% Rotates a given shape about the point X,Y,Z (ACW)
% Rotation is A rad about x axis, B rad about y axis, and C rad about Z
% axis

s1=translate(shape,-x,-y,-z);    % Translate the shape by (-X,-Y,Z)
s2=rotate(s1,a,b,c);    % Rotate
shaperoa=translate(s2,x,y,z);    % Translate the shape back by (X,Y,Z)