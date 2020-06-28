function [x,y,z,I] = icosahedron(a,Obj)

%% icosahedron
% Finds the coordinates and moment of inertia of an icosahedron of circumradius a

phi = (1+5^(1/2))/2;  % Golden ratio

x = [0;0;0;0;1;1;-1;-1;phi;phi;-phi;-phi]*a/(1+phi^2)^(1/2);
y = [1;1;-1;-1;phi;-phi;-phi;phi;0;0;0;0]*a/(1+phi^2)^(1/2);
z = [phi;-phi;-phi;phi;0;0;0;0;1;-1;-1;1]*a/(1+phi^2)^(1/2);

shape = [x,y,z];
s = norm(shape(1,:)-shape(4,:));
I = Obj.m*phi^2*s^2/10;