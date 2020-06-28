%% PhysicsEngine
%% A very rudimentary attempt at a physics engine (3D rigid body dynamics)

S = 0;
V = 0;

q1 = input('Simulation or Energy Graph? [s/e] ','s');

if q1 == 's' || q1 == 'S'
    S = 1;
    
    q2 = input('Produce Animation? [y/n] ','s');
    
    if q2 == 'y' || q2 == 'Y'
        V = 1;
    end
end

     

%% 1 - Define the object

Obj.mu  = 0.2;  % Coefficient of friction (set to 'w' for energy vs. time plots!)
Obj.e = 0.6;    % Coefficient of restitution
Obj.m = 0.2;    % Mass (kg)

[x,y,z,Obj.I] = icosahedron(2,Obj);   % Change the function to plot a different platonic solid
shape = [x,y,z];    % Defines the shape of the object
v = length(x);
shape(v+1,:) = 0;   % Adds CoM
g = 9.81;   % Acceleration due to gravity (m/s^2)


% Note: Lengths are all in metres



%% 2 - Initialise values

    %% 2.1 - Initialise position, linear/angular velocities and acceleration
    
    Motion.uz1 = 0; % (m/s)
    Motion.ux1 = 5; % (m/s)
    Motion.uy1 = 0; % (m/s)
    
    Motion.omegax1 = 0; % (rad/s)
    Motion.omegay1 = 5; % (rad/s)
    Motion.omegaz1 = -5; % (rad/s)
    
    Motion.a = -g;  % (m/s^2)
    
    shape = translate(shape,-15,0,10);
    
    
    
    %% 2.2 - Set the start and end value of t
    tstart = 0; %(s)
    tend = 6;   %(s)
    
    %% 2.3 - Set the step size
    dt = 0.005; %(s)
    n = length(tstart:dt:tend);
    
    
    
    %% For plotting energy over time:
    
    if S == 0
    E = zeros(1,n);
    Ek = zeros(1,n);
    Er = zeros(1,n);
    Eg = zeros(1,n);
    T = zeros(1,n);
    end
    

%% 3 - Repeat for each time step
    for k = 1:1:n
    
    %% 3.1 - Plot shape for current conditions
    
    %% For simulating the object's motion:
    
    if S == 1
    h1 = alphaShape(shape);
    h1.Alpha = 5;   % If holes appear in the object, increase this number
    p1 = plot(h1);
    p1.FaceColor = 'y'; % Colour of object
    axis([-25 25 -10 10 0 12])  % Size of 'room' (Sides don't cause collision!)
    
    grid on
    lightangle(gca,-45,30)  % Adjusts lighting
    set(gca,'CameraViewAngle', 15)  % Zooms out to get around the shrinking and growing of the animation as the figure rotates
    
    view([-37.5+0.15*k 30-0.0167*k])    % Path that the camera follows over time
    end
    
    %% 3.2 - Find velocities for next iteration
    
    b = min(shape(:,3),[],'all');   % Finds lowest point of the object
    [f] = find(shape(:,3) == b);
    Obj.h = shape(v+1,3) - shape(f(1),3);   % Height from z = 0 to CoM
    Obj.lx = shape(f(1),1) - shape(v+1,1);  % Displacement between point of contact and CoM in x-direction
    Obj.ly = shape(f(1),2) - shape(v+1,2);  % Displacement between point of contact and CoM in y-direction
    
    Motion.ux1t = Motion.ux1 - Motion.omegaz1*Obj.ly - Motion.omegay1*Obj.h;    % Total linear velocity at point of contact in x-direction
    
    Motion.uy1t = Motion.uy1 + Motion.omegax1*Obj.h + Motion.omegaz1*Obj.lx;    % Total linear velocity at point of contact in y-direction
    
    Motion.uz1t = Motion.uz1 - Motion.omegay1*Obj.lx + Motion.omegax1*Obj.ly;    % Total linear velocity at point of contact in z-direction
    
    
    
    if b <= 0 && Motion.uz1t < 0    % Determines whether collision has occured
        
        [Motion.ux2,Motion.uy2,Motion.uz2,Motion.omegax2,Motion.omegay2,Motion.omegaz2] = getMotion(Obj,Motion);    % Finds motion after collision
        
        %Replace velocities with new ones:
        Motion.omegax1 = Motion.omegax2;
        Motion.omegay1 = Motion.omegay2;
        Motion.omegaz1 = Motion.omegaz2;
        
        Motion.ux1 = Motion.ux2;
        Motion.uy1 = Motion.uy2;
        
    else
        
        Motion.uz2 = Motion.uz1 + Motion.a*dt;  % Continues to accelerate object
        
    end
    
    Motion.uz1 = Motion.uz2;
    
    
    
    %% 3.3 - Find coordinates for next iteration
    
    shape = rotateabout(shape,Motion.omegax1*dt,Motion.omegay1*dt,Motion.omegaz1*dt,shape(v+1,1),shape(v+1,2),shape(v+1,3));
    
    shape = translate(shape,Motion.ux1*dt,Motion.uy1*dt,Motion.uz1*dt);
    
    %% For plotting energy over time:
    
    if S == 0
    %Find energies (All in J):
    
    Ek(k) = 1/2*(Obj.m*(Motion.ux1^2 + Motion.uy1^2 + Motion.uz1^2));
    Er(k) = 1/2*(Obj.I*(Motion.omegax1^2 + Motion.omegay1^2 + Motion.omegaz1^2));
    Eg(k) = Obj.m*g*shape(v+1,3);
    
    E(k) = Ek(k) + Er(k) + Eg(k);  % Total energy
    T(k) = dt*k;
    end
    
    %% For simulating the object's motion:
    
    if S == 1
    pause(dt*1e-10)   % Used to cause the current frame to display, though processing time makes the frame rate much lower then implied
    end
    
    
    %% For writing the animation (simulation only) to a video:
    if V == 1 && S == 1
    if rem((k-1),4) == 0
       movieVector((k-1)/4+1) = getframe(gcf);
    end

    % Note: The above 'if' statement is configured to only store frames
    % such that the animation is 50FPS with dt = 0.005 (as 0.02/0.005 = 4)
    end
    end

    
    
%% For plotting energy over time:

if S == 0
plot(T,E)
hold on
plot(T,Ek)
plot(T,Er)
plot(T,Eg)
xlabel('Time/s')
ylabel('Energy/J')
title('Total Energy Over Time')
txt = ['mu = ',num2str(Obj.mu)];
text(4.5,22,txt)
txt = ['e = ',num2str(Obj.e)];
text(4.5,20.5,txt)
axis([0 tend 0 30])
legend('Total','Linear Kinetic','Angular Kinetic','Potential')
hold off
pause(0.05)
end

%% For writing the animation to a video:

if V == 1
 myWriter = VideoWriter('Simulation','MPEG-4'); % Choose name and file type here
 myWriter.FrameRate = 50;
 myWriter.Quality = 90;  % Max = 100
 
 open(myWriter);
 writeVideo(myWriter,movieVector);
 close(myWriter);
end