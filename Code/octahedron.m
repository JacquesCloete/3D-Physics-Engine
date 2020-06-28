function [x,y,z,I] = octahedron(a,Obj)

%% octahedron
% Finds the coordinates and moment of inertia of an octahedron of circumradius a

x = [1;0;0;-1;0;0]*a;
y = [0;1;0;0;-1;0]*a;
z = [0;0;1;0;0;-1]*a;

shape = [x,y,z];
s = norm(shape(1,:)-shape(2,:));
I = Obj.m*s^2/10;