function [x,y,z,I] = cube(a,Obj)

%% cube
% Finds the coordinates and moment of inertia of a cube of circumradius a

x = [1;1;1;1;-1;-1;-1;-1]*a/3^(1/2);
y = [1;-1;1;-1;1;-1;1;-1]*a/3^(1/2);
z = [1;1;-1;-1;1;1;-1;-1]*a/3^(1/2);

shape = [x,y,z];
s = norm(shape(1,:)-shape(2,:));
I = Obj.m*s^2/6;