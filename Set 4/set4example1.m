%% SET 4 EXAMPLE 1

%% QUESTION INFO

% A  surface  charge  of  5.0μ C/m^2   is  located  in  the  x-z  plane  
% in  the  region -2.0 m < x < 2.0 m and -3.0 m < y < 3.0 m. 
% Find analytically the electric field at the point (0, 4.0, 0) m. 
% Verify your answer using a MATLAB program that applies the principle of superposition.


%% SOLUTION

clc; %clear the command line 
clear; %remove all previous variables 

Epsilono=8.854e-12; %use permittivity of air 
D=5e-6; %the surface charge density  
P=[0 0 4]; %the position of the observation point 
E=zeros(1,3); %initialize E=(0 ,0, 0) 

Number_of_x_Steps=100; %initialize discretization in the x direction          
Number_of_y_Steps=100; %initialize discretization in %the y direction 
 
 
x_lower=-2; %the lower boundary of x 
x_upper=2; %the upper boundary of x 
y_lower=-3; %the lower boundary of y 
y_upper=-2; %the upper boundary of y 
dx=(x_upper- x_lower)/Number_of_x_Steps; %the x increment or the width of a grid                   
dy=(y_upper- y_lower)/Number_of_y_Steps; %The y increment or the length of a grid 
ds=dx*dy; %the area of a single grid 
dQ=D*ds; % the charge on a single grid

for j=1: Number_of_y_Steps     
    for i=1: Number_of_x_Steps         
        x= x_lower +dx/2+(i-1)*dx; %the x component of the center of a grid      
        y= y_lower +dy/2+(j-1)*dy; %the y component of the center of a grid 
        R=P-[x y 0]; % vector R is the vector seen from the center of the grid to the observation point 
        RMag=norm(R); % magnitude of vector R 
        E=E+(dQ/(4*Epsilono*pi* RMag ^3))*R; % get contribution to the E field    
    end
end