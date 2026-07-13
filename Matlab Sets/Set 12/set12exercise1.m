%% SET 12 EXERCISE 1

%% QUESTION INFO

% A very long coaxial capacitor has an inner and outer radius of 
% p_inner = 1.0*10^-3 m and p_outer = 5.0*10^-3 m. 
% It  is  filled with a nonuniform dielectric characterized by E_r = 10^3*p.  
% Find  the capacitance of a 0.01 m  long  capacitor  of  this  kind.    
% Write a MATLAB program that finds the energy stored in this capacitor 
% if the charge on the inner plate is Q = 5.0*10^-9 C
% Use the formula W_E = Q^2 / 2C to evaluate the capacitance again and compare your results.

%% SOLUTION

clc; % clear the command line
clear; % remove all previous variables

% initialize variables
eo = 1e-9/(36*pi);   % permittivity of free space (F/m)
Q = 5.0e-9;          % charge on inner plate (C)
L = 0.01;            % length of capacitor (m)
rho_inner = 1.0e-3;  % inner radius (m)
rho_outer = 5.0e-3;  % outer radius (m)

% discretization
Number_of_rho_steps = 200;   % number of steps in radial direction
Number_of_phi_steps = 100;   % number of steps in angular direction
Number_of_z_steps = 50;      % number of steps in z direction

drho = (rho_outer - rho_inner) / Number_of_rho_steps;
dphi = (2*pi) / Number_of_phi_steps;
dz = L / Number_of_z_steps;

% initialize energy storage
W = 0;

% calculate energy stored in the capacitor
for k = 1:Number_of_z_steps
    z = 0.5*dz + (k-1)*dz;  % z coord of current dV
    
    for j = 1:Number_of_phi_steps
        phi = 0.5*dphi + (j-1)*dphi;  % phi coord of current dV

        for i = 1:Number_of_rho_steps
            rho = rho_inner + 0.5*drho + (i-1)*drho;  % radial coord

            D = Q / (2 * pi * rho * L); % elec flux density
            er = 10^3 * rho; % relative permittivity at this radius
            E = D / (er * eo); % elec field magnitude
            dV = rho * drho * dphi * dz;
            dW = 0.5 * er * eo * E^2 * dV; % energy stored in this dV
            W = W + dW; % ddd to total energy

        end
    end
end

% calculate capacitance
C = Q^2 / (2 * W);

%% RESULT

C % prints 6.9447e-13 F
