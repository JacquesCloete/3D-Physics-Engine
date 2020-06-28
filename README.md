# 3D-Physics-Engine
A Rudimentary 3D Physics Engine in MATLAB, by Jacques Cloete (trin3445)

(Version 2 - now works for rough surfaces)


INTRODUCTION:

This program simulates the motion of a 3D object subject to gravitational acceleration and treats the z = 0 plane as a surface with which the object collides.
It can also be used to plot the energy of the object over time.

It uses an iterative method with a time-step to compute the motion, and the motion after a collision is found from a 3D rigid body analysis (provided with the program).

A few important approximations were necessary for the analysis;
	1) Collision happens for only one time-step (and so is effectively instantaneous)
	2) Coefficient of (dynamic) friction is constant
	3) Newton's law of restitution applies
	4) Collision occurs at the point of contact, which is always a vertex, rather than across part of the object's surface.

The analysis is driven entirely by Newton's laws of motion, and works in terms of impulse rather than forces.

The point of contact may or may not slip, depending on whether the required horizontal impulse to do so is greater or lesser than the maximum impulse that can be caused by friction.

Coefficients of friction and restitution, mass, time period, start conditions, etc. are all able to be changed, and while any object can theoretically be simulated, its moment of inertia and the set of coordinates that define its shape are required.
I have produced functions that find these for each of the platonic solids, attached with the program, and so you can simulate any of them, but feel free to create your own shapes and simulate those too!
(Note that other shapes may have non-isotropic moments of inertia, which the current version cannot support.)


HOW TO USE:

The program has been set up such that you can run it without any changes being needed. However, many parameters (including which platonic solid you want to simulate) can be changed, with guidance in the form of comments within the program.
You will require the functions that come alongside the program in order for it to work properly.

Some example simulations have also been provided, with e = 0, e = 0.2 and e = 0.6 (the rest of the settings are as set up in the program already). The corresponding energy vs. time graph for e = 0.2 is also provided.

Note that the simulation will be very slow whilst the motion is being computed, but the videos produced will be at the correct speed. Create these videos by choosing 'Y' when prompted with 'Produce Animation?'.

Once you are familiar with how the program works, you can start to alter it for different purposes.
For example, I have provided a video that shows how the energy vs. time plot changes with mu (which was achieved with a for-loop across almost the whole program, as well as the use of the video writer).


FUTURE DEVELOPMENTS:

While the simulation appears to work well with tetrahedrons, cubes, octahedrons and icosahedrons (the last of which was used most often to test the program), odd behaviour can sometimes occur for dodecahedrons, and so I may look into this.

Additional features, such as making the walls of the 'room' also cause collisions or tweaking the program to work with objects with non-isotropic moments of inertia, could also be implemented.
