%% QUESTION INFO

% A finite uniform linear charge p_L= 4 nC/m  lies on the xy plane as shown in Figure 3.4, 
% the line charge lies on the xy plane beginning from (7,0,0) to (0,7,0),
% while point  charges of 8 nC each are located at (0, 1, 1) and (0, -1, 1).  
% Find E at (0, 0 ,0).  
% Write a MATLAB program to verify your answer.


%% SOLUTION

clc; %clear the command line
clear; %remove all previous variables

% Constants
Q = 8e-9; % charges on Q1 and Q2 (8 nC)
pL = 4e-9; % charge density of the line (4 nC/m)
epsilon0 = 8.854e-12; % Permittivity of free space

% Coordinates
P = [0 0 0]; % observation point
A = [0 1 1]; % coordinates of Q1
B = [0 -1 1]; % coordinates of Q2

% Coordinates of the finite line charge on xy plane
% From Figure 3.4, the line extends from (-2,2,0) to (2,2,0)
L_start = [-2 2 0]; % start point of line charge
L_end = [2 2 0]; % end point of line charge

% Discretization parameters
Number_of_L_Steps = 100000; % number of segments for line charge

%% Calculate electric field from point charges

% For Q1 at A
R1 = P - A; % vector from Q1 to observation point
R1Mag = norm(R1); % magnitude of R1
E1 = Q/(4*pi*epsilon0*R1Mag^3) * R1; % electric field from Q1

% For Q2 at B
R2 = P - B; % vector from Q2 to observation point
R2Mag = norm(R2); % magnitude of R2
E2 = Q/(4*pi*epsilon0*R2Mag^3) * R2; % electric field from Q2

%% Calculate electric field from finite line charge

% The line charge lies on the xy plane along x-direction at y=2, z=0
% Total length of line charge
length = norm(L_end - L_start); % 4 m (from -2 to 2)

% Vector for each segment (along x-direction)
dL_V = (L_end - L_start)/Number_of_L_Steps * [1 0 0]; % vector of a segment
dL = norm(dL_V); % length of a segment

% Initialize electric field from line charge
EL = [0 0 0];

% Position of the first segment center
C_segment = L_start + dL_V/2; % center of first segment

% Loop over all segments
for i = 1:Number_of_L_Steps
    % Vector from segment center to observation point
    R = P - C_segment;
    RMag = norm(R); % magnitude
    
    % Contribution from this segment (treated as point charge)
    EL = EL + dL * pL/(4*pi*epsilon0*RMag^3) * R;
    
    % Move to next segment
    C_segment = C_segment + dL_V;
end

%% Total electric field
E_total = E1 + E2 + EL;

%% Display results
fprintf('Electric Field at P(0,0,0):\n');
fprintf('E1 = (%.4e, %.4e, %.4e) V/m\n', E1(1), E1(2), E1(3));
fprintf('E2 = (%.4e, %.4e, %.4e) V/m\n', E2(1), E2(2), E2(3));
fprintf('EL = (%.4e, %.4e, %.4e) V/m\n', EL(1), EL(2), EL(3));
fprintf('E_total = (%.4e, %.4e, %.4e) V/m\n', E_total(1), E_total(2), E_total(3));
fprintf('Magnitude = %.4e V/m\n', norm(E_total));