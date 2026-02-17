%% QUESTION INFO
% The surfaces below define a closed surface:
% r = 0 and r = 2,
% phi = 45 deg and phi = 90 deg
% theta = 45 deg and theta = 90 deg
% Find the enclosed volume and the area of the closed surface S.
% Write a MATLAB program to verify your answer.

clear; clc;
fprintf('=============================================\n');
fprintf('SPHERICAL COORDINATES CLOSED SURFACE ANALYSIS\n');
fprintf('=============================================\n\n');

%% Initializations
V = 0;      % initialize volume of the closed surface to 0
S1 = 0;     % area at r = 2 (outer spherical surface)
S2 = 0;     % area at r = 0 (inner spherical surface) --> will be zero
S3 = 0;     % area at phi = 45 deg
S4 = 0;     % area at phi = 90 deg
S5 = 0;     % area at theta = 45 deg
S6 = 0;     % area at theta = 90 deg

% Boundary values
r1 = 0;               % lower boundary of r
r2 = 2;               % upper boundary of r
phi1 = 45 * pi/180;   % lower boundary of phi in rad
phi2 = 90 * pi/180;   % upper boundary of phi in rad
theta1 = 45 * pi/180; % lower boundary of theta in rad
theta2 = 90 * pi/180; % upper boundary of theta in rad

% Discretization steps
r_steps = 100;
phi_steps = 100;
theta_steps = 100;

% Increments
d_r = (r2 - r1) / r_steps;
d_phi = (phi2 - phi1) / phi_steps;
d_theta = (theta2 - theta1) / theta_steps;


%% Display the boundary values

fprintf('Discretization: %d r-steps, %d phi-steps, %d theta-steps\n', r_steps, phi_steps, theta_steps);
fprintf('Increments:     dr = %.4f, dφ = %.4f rad, dθ = %.4f rad\n\n', d_r, d_phi, d_theta);
fprintf('r boundary:     %d to %d meters\n', r1, r2);
fprintf('φ boundary:     %d° to %d° (%.4f to %.4f rad)\n', 45, 90, phi1, phi2);
fprintf('θ boundary:     %d° to %d° (%.4f to %.4f rad)\n\n', 45, 90, theta1, theta2);

%% Volume calculation
% In spherical coordinates: dV = r^2 * sin(θ) * dr * dθ * dφ

% reset variables
r = r1;
theta = theta1;
phi = phi1;

for k = 1:theta_steps
    for j = 1:phi_steps
        for i = 1:r_steps
            V = V + r^2 * sin(theta) * d_r * d_theta * d_phi;
            r = r + d_r;
        end
        phi = phi + d_phi;
        r = r1;
    end
    phi = phi1; %reset phi back to lower boundary
    theta = theta + d_theta; % theta increases each time phi has been traveled
end

%% Surface area calculation

% reset variables
r = r1;
theta = theta1;
phi = phi1;

% S1: Surface at r = r2 (outer spherical surface)
% dS = r^2 * sin(θ) * dθ * dφ  (with r constant = r2)
for k = 1:theta_steps
    theta = theta1 + (k - 0.5) * d_theta;
    for j = 1:phi_steps
        S1 = S1 + (r2^2) * sin(theta) * d_theta * d_phi;  % at r upper boundary
        S2 = S2 + (r1^2) * sin(theta) * d_theta * d_phi;  % at r lower boundary
    end
    theta = theta + d_theta;
end

% reset variables
r = r1;
theta = theta1;
phi = phi1;

% S3 and S4: Surfaces at constant φ
% dS = r * dr * dθ  (for constant φ)
for k = 1:theta_steps
    for i = 1:r_steps
        S3 = S3 + r * d_r * d_theta;  % at phi lower boundary
        S4 = S4 + r * d_r * d_theta;  % at phi upper boundary
    end
    r = r + d_r;
    theta = theta + d_theta;
end

% reset variables
r = r1;
theta = theta1;
phi = phi1;

% S5 and S6: Surfaces at constant θ
% dS = r * sin(θ) * dr * dφ  (for constant θ)
for j = 1:phi_steps
    for i = 1:r_steps
        r = r1 + (i - 0.5) * d_r;
        S5 = S5 + r * sin(theta1) * d_r * d_phi;  % at theta lower boundary
        S6 = S6 + r * sin(theta2) * d_r * d_phi;  % at theta upper boundary
    end
end

% Total surface area
S_total = S1 + S2 + S3 + S4 + S5 + S6;

%% Display results
fprintf('\nEnclosed volume: %.6f m^3\n\n', V);

fprintf('Surface areas:\n');
fprintf('  S1 (r = 2):      %.6f m^2\n', S1);
fprintf('  S2 (r = 0):      %.6f m^2\n', S2);
fprintf('  S3 (φ = 45°):    %.6f m^2\n', S3);
fprintf('  S4 (φ = 90°):    %.6f m^2\n', S4);
fprintf('  S5 (θ = 45°):    %.6f m^2\n', S5);
fprintf('  S6 (θ = 90°):    %.6f m^2\n', S6);
fprintf('  TOTAL AREA:      %.6f m^2\n\n', S_total);

