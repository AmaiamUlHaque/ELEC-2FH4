%% SET 8 EXERCISE 1

%% QUESTION INFO
% Given the surface charge density p_s= 2.0x10^6 C/mm^2 existing in the region 
% r = 1.0 m 
% 0 < phi < 2pi
% 0 < theta < pi 
% and  is  zero  elsewhere  (See  Figure  8.2).  
% 
% Find  analytically  the  energy  stored  in  the  region bounded  by 
% 2.0 m < r < 3.0 m 
% 0 < phi < 2pi and
% 0 < theta < pi. 
% Write  a  MATLAB  program  to  verify  your answer.

%% SOLUTION

clc;        % clear the command line
clear;      % remove all previous variables

% constants
epsilon0 = 1e-9/(36*pi);   % permittivity of free space (F/m)
rho_s = 2.0e-6;            % surface charge density (C/m^2)
r_sphere = 1.0;            % radius of the charged spherical shell (m)

% region boundaries
r_lower = 2.0;             % lower bound of r (m)
r_upper = 3.0;             % upper bound of r (m)
theta_lower = 0;           % lower bound of theta (rad)
theta_upper = pi;          % upper bound of theta (rad)
phi_lower = 0;             % lower bound of phi (rad)
phi_upper = 2*pi;          % upper bound of phi (rad)

% discretization
Number_of_r_Steps = 50;     % number of steps in the r direction
Number_of_theta_Steps = 50; % number of steps in the theta direction
Number_of_phi_Steps = 50;   % number of steps in the phi direction

dr = (r_upper - r_lower) / Number_of_r_Steps;
dtheta = (theta_upper - theta_lower) / Number_of_theta_Steps;
dphi = (phi_upper - phi_lower) / Number_of_phi_Steps;

% total charge on the spherical shell at r = 1.0 m
% surface area of sphere: 4*pi*r^2
Q_total = rho_s * (4 * pi * r_sphere^2);   % total charge


% E field outside is radial and depends only on r. compute energy by summing over dV's

% initialize total energy
WE = 0;   

for i = 1:Number_of_r_Steps

    % r coord of the current volume element (center of cell)
    r = r_lower + 0.5*dr + (i-1)*dr;
    % Electric field magnitude at this radius (outside the charged shell)
    E_mag = Q_total / (4 * pi * epsilon0 * r^2);
    
    % For each r, the contribution from theta and phi integration is constant.
    % We can precompute the volume factor for this r.
    
    for j = 1:Number_of_theta_Steps
        theta = theta_lower + 0.5*dtheta + (j-1)*dtheta; % theta coord of the current dV (center of cell)
        for k = 1:Number_of_phi_Steps 
            phi = phi_lower + 0.5*dphi + (k-1)*dphi; % phi coord
            dV = r^2 * sin(theta) * dr * dtheta * dphi; % volume element in spherical coords
            dWE = 0.5 * epsilon0 * E_mag^2 * dV; % energy stored in this volume element
            WE = WE + dWE; % add to total energy
        end
    end
end

%% RESULT
WE % prints 0.4738
