%% SET 12 EXAMPLE 1

%% QUESTION INFO

% A parallel-plate is filled with a nonuniform dielectric characterized by 
% E_r = 2 + 2*10^6*x^2, where x is the distance from the lower plate in meters. 
% If S = 0.02 m^2  and d = 1.0 mm, find the capacitance C. 
% Write a MATLAB program that finds the energy stored in this capacitor 
% if the charge on the positive plate is Q=4.0*10^-9 C.  
% Use the formula W_E =Q^2 / 2C to evaluate the capacitance and compare your results.

%% SOLUTION
clc; %clear the command line 
clear; %remove all previous variables 

% initialize variables 
eo=1e-9/(36*pi); % the permittivity in free space 
Q=4e-9;          % charges on the positive plate 
S=0.02;          % area of the capacitor 
d=1e-3;          % thickness of the capacitor 
Ds=Q/S;          % electric flux density 
Number_of_x_steps=100;  %number of steps in the x direction  
dx=d/Number_of_x_steps; %x increment 

% perform calculations 
W=0;  % initialize the total energy 
for k=1:Number_of_x_steps 
    x=0.5*dx+(k-1)*dx;  %current radius 
    er=2+2*x*x*1e6;     %current relative permittivity  
    dW=0.5*Ds*Ds*S*dx/(er*eo);  % energy stored in a thin layer  
    W=W+dW;                     % get contribution to the total energy 
end 

%% RESULT
C = Q^2/(2*W) % prints 4.5032e-10