function [ux2,uy2,uz2,omegax2,omegay2,omegaz2] = getMotion(Obj,Motion)

%% GetMotion
% Finds the motion of the object after a collision
% The underlying theory is presented in the corresponding rigid body analysis

% We begin by assuming that the point of contact does not slip

% A linear system of equations must be solved to find each impulse

A = [(-Obj.I/Obj.m - Obj.h^2 - Obj.ly^2) Obj.lx*Obj.ly Obj.h*Obj.lx
      Obj.lx*Obj.ly (-Obj.I/Obj.m - Obj.h^2 - Obj.lx^2) Obj.h*Obj.ly
      -Obj.h*Obj.lx -Obj.h*Obj.ly (Obj.I/Obj.m + Obj.lx^2 + Obj.ly^2)];
  
b = [-Motion.ux1t*Obj.I; -Motion.uy1t*Obj.I; -Motion.uz1t*(Obj.e+1)*Obj.I];

c = A\b;

impulsex = c(1);    % Impulse at point of contact in x-direction
impulsey = c(2);    % "" y-direction
Frdt = c(3);    % "" z-direction

% We must check to see whether our assumption was correct:

if (impulsex^2 + impulsey^2)^(1/2) > abs(Obj.mu*Frdt)   % If true, the assumption was incorrect
    
    % Find the direction of the impulse caused by friction:
    
    theta = atan(Motion.uy1t/Motion.ux1t);
    
    if Motion.uy1t > 0 && Motion.ux1t < 0
        theta = pi + theta;
    elseif Motion.uy1t < 0 && Motion.ux1t < 0
        theta = -pi + theta;
    end
    
    % Recalculate the values of each impulse:
    
    Frdt = (- Obj.I*(Obj.e+1)*Motion.uz1t)/(Obj.lx^2 + Obj.ly^2 +Obj.I/Obj.m - Obj.mu*Obj.h*(cos(theta)*Obj.lx + sin(theta)*Obj.ly));
    
    impulsex = Obj.mu*Frdt*cos(theta);

    impulsey = Obj.mu*Frdt*sin(theta);
    
end

% Determine the velocities after the collision:

ux2 = Motion.ux1 - impulsex/Obj.m;

uy2 = Motion.uy1 - impulsey/Obj.m;

uz2 = Motion.uz1 + Frdt/Obj.m;

omegax2 = Motion.omegax1 + Frdt/Obj.I*Obj.ly - impulsey/Obj.I*Obj.h;

omegay2 = Motion.omegay1 - Frdt/Obj.I*Obj.lx + impulsex/Obj.I*Obj.h;

omegaz2 = Motion.omegaz1 - impulsey*Obj.lx/Obj.I + impulsex*Obj.ly/Obj.I;