%% Set 3 Exercise: Finite Line Charge and Point Charges
% Assumption: finite line lies along y=1, z=0, from x=-1 to x=1.
% Point charges at (0,1,1) and (0,-1,1). Observation point at (0,0,0).

clc; clear;

% Constants
epsilon0 = 8.854e-12;          % permittivity of free space (F/m)
rhoL = 4e-9;                   % line charge density (C/m)
Q = 8e-9;                      % point charge magnitude (C)

% Observation point
P = [0 0 0];

% Point charge positions
A = [0 1 1];
B = [0 -1 1];

% Electric field from point charges
R_A = P - A;
R_B = P - B;
Rmag_A = norm(R_A);
Rmag_B = norm(R_B);
E_A = Q/(4*pi*epsilon0*Rmag_A^3) * R_A;
E_B = Q/(4*pi*epsilon0*Rmag_B^3) * R_B;
E_points = E_A + E_B;

% Finite line charge: from x = -1 to 1, at y=1, z=0
x_min = -1;
x_max = 1;
N = 10000;                      % number of segments
dx = (x_max - x_min)/N;
E_line = [0 0 0];

for i = 1:N
    % Center of current segment
    xc = x_min + (i-0.5)*dx;
    % Position of segment
    seg_pos = [xc, 1, 0];
    % Vector from segment to P
    R = P - seg_pos;
    Rmag = norm(R);
    % Charge on segment
    dQ = rhoL * dx;
    % Contribution to E
    dE = dQ/(4*pi*epsilon0*Rmag^3) * R;
    E_line = E_line + dE;
end

% Total field
E_total = E_points + E_line;

% Display results
fprintf('Electric field from point charges: [%.4f %.4f %.4f] V/m\n', E_points);
fprintf('Electric field from line charge:   [%.4f %.4f %.4f] V/m\n', E_line);
fprintf('Total electric field:               [%.4f %.4f %.4f] V/m\n', E_total);