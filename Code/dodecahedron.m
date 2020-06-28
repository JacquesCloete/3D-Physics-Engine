function [x,y,z,I] = dodecahedron(a,Obj)

%% dodecahedron
% Finds the coordinates and moment of inertia of a dodecahedron of circumradius a

phi = (1+5^(1/2))/2;  % Golden ratio

x = [1;1;1;1;-1;-1;-1;-1;0;0;0;0;1/phi;1/phi;-1/phi;-1/phi;phi;phi;-phi;-phi]*a/3^(1/2);
y = [1;-1;1;-1;1;-1;1;-1;1/phi;1/phi;-1/phi;-1/phi;phi;-phi;-phi;phi;0;0;0;0]*a/3^(1/2);
z = [1;1;-1;-1;1;1;-1;-1;phi;-phi;-phi;phi;0;0;0;0;1/phi;-1/phi;-1/phi;1/phi]*a/3^(1/2);

shape = [x,y,z];
s = norm(shape(1,:)-shape(4,:));
I = Obj.m*s^2*(39*phi + 28)/150;