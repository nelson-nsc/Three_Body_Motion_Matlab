# 3D Animation of the three-body Motion in MATLAB

I created a 3D visualisation of the [three-body problem](https://en.wikipedia.org/wiki/Three-body_problem) in MATLAB. It can be generalise to higher number of bodies by adding differential equations to the threebodyfun.m file.

## threebodyfun.m
The m file contains the differential equations (aka Netown's Laws)for the interacting three bodies. There are 18 equations in the 3-dimensional space, including the velocities and the acceleration of each massive object.

## threebody_script.m
This is a click-to-run m.file. It imports threebodyfun.m and use the provided initial conditions to simulate the three-body-motion in a 3D plot. A separate plot shows the change of kinetic and potential energy of the system over time. 

## Initial Conditions
The default initial conditions can be changed manually. User can experiment with the masses, positions and velocities of the objects, as well as the gravitational constant. You can also edit the duration of the simulation (i.e. ti,tf), and the time steps between the starting and finishing time by uncommenting

tspan = linspace(ti,tf,n)

where n is the number of steps needed to be specified. Next, replace [ti,tf] with tspan in the following line:

[t,r] = ode45(@(t,r)threebodyfun(t,r,G,m),[ti,tf],init)



## Warning Message
If there is warning after you run the script, it is very likely that at least two of the bodies collide, which leads to a singularity. You need to change the initial conditions to avoid this error. 