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
clc;
clear;

Epsilono = 8.854e-12;      % permittivity of air [F/m]
D = 2e-6;                  % surface charge density [C/m^2]
P = [0 0 1];               % observation point [m]
E = zeros(1,3);            % initialize electric field

Number_of_p_Steps = 100;      % radial divisions
Number_of_phi_Steps = 100;    % angular divisions

p_lower = 0;
p_upper = 1;
phi_lower = 0;
phi_upper = 2*pi;

dp = (p_upper - p_lower)/Number_of_p_Steps;
dphi = (phi_upper - phi_lower)/Number_of_phi_Steps;


for j = 1:Number_of_phi_Steps
    for i = 1:Number_of_p_Steps

        % center coords in cylindrical system
        p = p_lower + dp/2 + (i-1)*dp;
        phi = phi_lower + dphi/2 + (j-1)*dphi;
        
        % convert to cartesian coords
        x = p * cos(phi);
        y = p * sin(phi);
        
        % vector from cell center to observation pt
        R = P - [x y 0];
        RMag = norm(R);
        
        % cylindrical coordinates: dS = ρ dρ dφ
        ds = p * dp * dphi;
        dQ = D * ds;
        
        % contribution to E field
        E = E + (dQ/(4*Epsilono*pi*RMag^3)) * R;
    end
end

E % prints resulting E field

