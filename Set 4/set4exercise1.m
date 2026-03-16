%% SET 4 EXERCISE 1

% Amaiam Ul Haque
% 400520641
% haquea24


%% QUESTION INFO

% Given the surface charge density, ρ_s  =  2.0 μ C/m^2, 
% existing in the region ρ<1.0 m, z  =  0, and zero elsewhere, 
% find E at P (ρ  =  0, z  =  1.0) and 
% write a MATLAB program to verify your answer.


%% SOLUTION

clc; %clear the command line 
clear; %remove all previous variables 

Epsilono = 8.854e-12; %use permittivity of air 
D = 2e-6; %the surface charge density  
P = [0 0 1]; %the position of the observation point 
E = zeros(1,3); %initialize E = (0 ,0, 0) 

Number_of_p_Steps = 100; %initialize discretization in the p direction          
Number_of_phi_Steps = 100; %initialize discretization in %the z direction 
 
p_lower = 0; %the lower boundary of p 
p_upper = 1; %the upper boundary of p 
phi_lower = 0; %the lower boundary of phi 
phi_upper = 2*pi; %the upper boundary of phi

dp = (p_upper- p_lower)/Number_of_p_Steps; %the p increment or the width of a grid                   
dphi = (phi_upper- phi_lower)/Number_of_phi_Steps; %The phi increment or the length of a grid 
ds = dp*dphi; %the area of a single grid 
dQ = D*ds; % the charge on a single grid

for j = 1: Number_of_phi_Steps
    for i = 1: Number_of_p_Steps         
        p = p_lower + dp/2+(i-1)*dp; %the p component of the center of a grid      
        phi = phi_lower + dphi/2+(j-1)*dphi; %the phi component of the center of a grid 
        R = P - [p phi 0]; % vector R is the vector seen from the center of the grid to the observation point 
        RMag = norm(R); % magnitude of vector R 
        E = E+(dQ/(4*Epsilono*pi*RMag^3))*R; % get contribution to the E field    
    end
end
