%% This script applies the threebodyfun to plot the 3D motion of the system. 
%  To check it is a good approximation we also plot the total kinetic and
%  potential energy of the system because the total energy should remain
%  constant.

clear all

% Initial Conditions
G = 1;               % for illustraion purpose the gravitational constant is sat to 1.
m = [100 100 100];   % masses of the three bodies.


% mass 1
r1 = [0 0 0];
v1 = [0 -1/20 0];

% mass 2
r2 = [10 0 0]; 
v2 = [0 1 0]; 

% mass 3
r3 = [10 4 0]; 
v3 = [-0.5 0 -0.5];

% combine all initial conditions
init = [r1, r2 ,r3, v1, v2, v3];

% set starting and finishing time
ti = 0;
tf = 10;
%tspan = linspace(ti,tf,n) % <- you can customise the time step by relacing n with number of steps 
                           %    (integer) you would like to perform 

%% Call the function

[t,r] = ode45(@(t,r)threebodyfun(t,r,G,m),[ti,tf],init);

%% Plotting the motions

figure(1)

% These are the traces of the motions
curve1 = animatedline('LineWidth',0.5,'Color','y');
curve2 = animatedline('LineWidth',0.5,'Color','c');
curve3 = animatedline('LineWidth',0.5,'Color','m');

% Setting the range for the x,y,z axes
xmin = min(reshape(r(:,[1 4 7]),[],1));
xmax = max(reshape(r(:,[1 4 7]),[],1));
ymin = min(reshape(r(:,[2 5 8]),[],1));
ymax = max(reshape(r(:,[2 5 8]),[],1));
zmin = min(reshape(r(:,[3 6 9]),[],1));
zmax = max(reshape(r(:,[3 6 9]),[],1));
set(gca, 'XLim',[xmin,xmax],'YLim',[ymin,ymax],'ZLim',[zmin,zmax],'Color','k');

view(-10,25); % viewing angle

xlabel('x'); 
ylabel('y');
zlabel('z');

grid on
ax = gca;
ax.GridColor = 'white'; 
hold on;

% Plotting the motion in a for loop
for i = 1:length(r(:,1))
    % Add the tails of the motions
    addpoints(curve1,r(i,1),r(i,2),r(i,3));
    addpoints(curve2,r(i,4),r(i,5),r(i,6));
    addpoints(curve3,r(i,7),r(i,8),r(i,9));
    
    % Plotting the three masses
    head1 = scatter3(r(i,1),r(i,2),r(i,3),200,'filled','MarkerFaceColor','y','MarkerEdgeColor','w');
    head2 = scatter3(r(i,4),r(i,5),r(i,6),200,'filled','MarkerFaceColor','c','MarkerEdgeColor','w');
    head3 = scatter3(r(i,7),r(i,8),r(i,9),200,'filled','MarkerFaceColor','m','MarkerEdgeColor','w');
    drawnow
    pause(0.0001) % animation speed
    
    delete(head1);
    delete(head2);
    delete(head3);
    
    title({'Three-body motion',sprintf('t=%f',t(i))}); %show time lapse on the title 
end

%% Energy graph
%  Let's see how the total kinetic and potential energy change over time.
%  If the simulation is correct, the total energy should remain constant.

% First calculate velocity squared for all bodies.
v1 = [r(:,10).^2 + r(:,11).^2 + r(:,12).^2].';
v2 = [r(:,13).^2 + r(:,14).^2 + r(:,15).^2].';
v3 = [r(:,16).^2 + r(:,17).^2 + r(:,18).^2].';
v = [v1; v2; v3];


% Plotting the energy graph  
figure(2)
hold on;

% Kinetic energy = 1/2*m*v^2 
KE = 0.5*(m(1)*v(1,:)+m(2)*v(2,:)+m(3)*v(3,:));


% For potential energy, we need to work out the magnitude 
% of the distances between the three bodies first.
% Suppose there are two vectors r1 and r2.
% The distance is |r1-r2| = ((r1x-r2x)^2+(r1y-r2y)^2+(r1z-r2z)^2)^0.5.

dist = [(((r(:,1)-r(:,4)).^2+(r(:,2)-r(:,5)).^2+(r(:,3)-r(:,6)).^2).^(1/2)).';      % |r1-r2|
       (((r(:,4)-r(:,7)).^2+(r(:,5)-r(:,8)).^2+(r(:,6)-r(:,9)).^2).^(1/2)).';       % |r2-r3|
        (((r(:,7)-r(:,1)).^2+(r(:,8)-r(:,2)).^2+(r(:,9)-r(:,3)).^2).^(1/2)).'].';   % |r3-r1|

% Potential energy = - G*m1*m2/|r1-r2|.
PE = -G*m(1)*m(2)./dist(:,1) - G*m(2)*m(3)./dist(:,2) - G*m(1)*m(3)./dist(:,3);

% Finally plot KE and PE on the same figure.
plot(t,KE,t,PE)
xlabel('Time')
ylabel('Energy')
title('Total Energy of the system')
legend('Kinetic Energy','Potential Energy')

