function f = threebodyfun(t,r,G,m)
% The threebodyfun function uses to simulate the famous three-body problem 
% by Newtonian kinematics.
% Given the initial conditions, it returns the x,y,z coordinates and
% velocity of each body using ode45.

% The function f is a set of differential equations that needs to be
% solved. These equations come from the Newtonian mechanics F = ma =
% -G*m1*m2/r^2. 

f = [% r(10) to r(18) are the velocities of the three body. Specifically,
     % r(10)-r(12) are v1x, v1y and v1z respectively and so on.
    r(10);r(11);r(12);r(13);r(14);r(15);r(16);r(17);r(18); 
    
     % The following 9 equations are the accelerations of the bodies, i.e.
     % a = F/m = -Gm'/r^2. Again, we decompose the 3-vectors into x, y, z directions.
     % Here a is a vector, so technically a is in the form of -Gm'(r2-r1)/|r2-r1|^3.
     
     % acceleration for body 1
    -G*m(2)*(r(1)-r(4)) / ((r(1)-r(4))^2+(r(2)-r(5))^2+(r(3)-r(6))^2)^(3/2) - G*m(3)*(r(1)-r(7)) / ((r(1)-r(7))^2+(r(2)-r(8))^2+(r(3)-r(9))^2)^(3/2);
    -G*m(2)*(r(2)-r(5)) / ((r(1)-r(4))^2+(r(2)-r(5))^2+(r(3)-r(6))^2)^(3/2) - G*m(3)*(r(2)-r(8)) / ((r(1)-r(7))^2+(r(2)-r(8))^2+(r(3)-r(9))^2)^(3/2);
    -G*m(2)*(r(3)-r(6)) / ((r(1)-r(4))^2+(r(2)-r(5))^2+(r(3)-r(6))^2)^(3/2) - G*m(3)*(r(3)-r(9)) / ((r(1)-r(7))^2+(r(2)-r(8))^2+(r(3)-r(9))^2)^(3/2);
    
    % acceleration for body 2
    -G*m(3)*(r(4)-r(7)) / ((r(4)-r(7))^2+(r(5)-r(8))^2+(r(6)-r(9))^2)^(3/2) - G*m(1)*(r(4)-r(1)) / ((r(4)-r(1))^2+(r(5)-r(2))^2+(r(6)-r(3))^2)^(3/2);
    -G*m(3)*(r(5)-r(8)) / ((r(4)-r(7))^2+(r(5)-r(8))^2+(r(6)-r(9))^2)^(3/2) - G*m(1)*(r(5)-r(2)) / ((r(4)-r(1))^2+(r(5)-r(2))^2+(r(6)-r(3))^2)^(3/2);
    -G*m(3)*(r(6)-r(9)) / ((r(4)-r(7))^2+(r(5)-r(8))^2+(r(6)-r(9))^2)^(3/2) - G*m(1)*(r(6)-r(3)) / ((r(4)-r(1))^2+(r(5)-r(2))^2+(r(6)-r(3))^2)^(3/2);

    % accerleration for body 3
    -G*m(1)*(r(7)-r(1)) / ((r(7)-r(1))^2+(r(8)-r(2))^2+(r(9)-r(3))^2)^(3/2) - G*m(2)*(r(7)-r(4)) / ((r(7)-r(4))^2+(r(8)-r(5))^2+(r(9)-r(6))^2)^(3/2);
    -G*m(1)*(r(8)-r(2)) / ((r(7)-r(1))^2+(r(8)-r(2))^2+(r(9)-r(3))^2)^(3/2) - G*m(2)*(r(8)-r(5)) / ((r(7)-r(4))^2+(r(8)-r(5))^2+(r(9)-r(6))^2)^(3/2);
    -G*m(1)*(r(9)-r(3)) / ((r(7)-r(1))^2+(r(8)-r(2))^2+(r(9)-r(3))^2)^(3/2) - G*m(2)*(r(9)-r(6)) / ((r(7)-r(4))^2+(r(8)-r(5))^2+(r(9)-r(6))^2)^(3/2);];
        
end
