%% EXERCISE SET 4 - CIRCULAR DISK
clc;
clear;

%% Constants
epsilon0 = 8.854e-12;      % permittivity of free space [F/m]
rho_s = 2.0e-6;             % surface charge density [C/m^2]
a = 1.0;                    % radius of disk [m]
P = [0, 0, 1.0];            % observation point [m]

%% Discretization parameters
Nx = 200;                   % number of divisions in x-direction
Ny = 200;                   % number of divisions in y-direction

%% Domain boundaries (square that contains the disk)
x_lower = -a;
x_upper = a;
y_lower = -a;
y_upper = a;

%% Grid spacing
dx = (x_upper - x_lower) / Nx;
dy = (y_upper - y_lower) / Ny;
dA = dx * dy;               % area of each cell

%% Initialize electric field
E = [0, 0, 0];

%% Loop over all cells

for j = 1:Ny
    for i = 1:Nx
        % Center coordinates of current cell
        xc = x_lower + dx/2 + (i-1)*dx;
        yc = y_lower + dy/2 + (j-1)*dy;
        
        % Check if cell center is within the disk
        rho = sqrt(xc^2 + yc^2);
        if rho < a
            % Charge on this cell
            dQ = rho_s * dA;
            
            % Vector from cell center to observation point
            R = P - [xc, yc, 0];
            Rmag = norm(R);
            
            % Contribution to electric field (point charge approximation)
            E = E + (dQ / (4*pi*epsilon0 * Rmag^3)) * R;
        end
    end
end

E