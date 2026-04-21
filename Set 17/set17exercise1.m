%% Set 17 - Mutual Inductance of Two Coaxial Coils
% Exercise: Two coils with radii a1=0.01 m, a2=0.04 m, separated by d=0.1 m.
% Find mutual inductance.

clc;
clear;
close all;

% Constants
mu0 = 4*pi*1e-7;    % permeability of free space (H/m)

% Given parameters
a1 = 0.01;          % radius of first coil (m)
a2 = 0.04;          % radius of second coil (m)
d = 0.1;            % separation distance between coils (m)
N1 = 1;             % number of turns in first coil (assuming 1 turn)
N2 = 1;             % number of turns in second coil (assuming 1 turn)

% Method 1: Using the exact formula with elliptic integrals
k = sqrt(4*a1*a2 / ((a1 + a2)^2 + d^2));

% Complete elliptic integrals using MATLAB's built-in functions
[K, E] = ellipke(k^2);

% Neumann's formula for mutual inductance of two coaxial circular loops
M_exact = mu0 * sqrt(a1*a2) * ((2/k - k)*K - (2/k)*E);

% Multiply by number of turns if more than 1
M_exact = M_exact * N1 * N2;

% Method 2: Using approximation for small coil (a1 << a2, d)
% B field from large coil at its center: B = mu0 * N2 * I / (2*a2)
% For small coil at distance d along axis, B = mu0 * N2 * I * a2^2 / (2*(a2^2 + d^2)^(3/2))
% Then M = B * (pi*a1^2) / I
M_approx = mu0 * pi * a1^2 * a2^2 * N1 * N2 / (2 * (a2^2 + d^2)^(3/2));

% Method 3: Numerical integration using Biot-Savart law
% Discretize both coils into segments
num_segments = 200;
M_numerical = mutual_inductance_numerical(a1, a2, d, mu0, N1, N2, num_segments);

% Display results
fprintf('\n========================================\n');
fprintf('SET 17: Mutual Inductance Calculation\n');
fprintf('========================================\n');
fprintf('Parameters:\n');
fprintf('  a1 = %.4f m (%.2f cm)\n', a1, a1*100);
fprintf('  a2 = %.4f m (%.2f cm)\n', a2, a2*100);
fprintf('  d  = %.4f m (%.2f cm)\n', d, d*100);
fprintf('  N1 = %d, N2 = %d\n', N1, N2);
fprintf('  mu0 = %.2e H/m\n', mu0);
fprintf('\nResults:\n');
fprintf('  Method 1 (Exact - Elliptic Integrals): M = %.4e H\n', M_exact);
fprintf('  Method 2 (Approximation):              M = %.4e H\n', M_approx);
fprintf('  Method 3 (Numerical Integration):      M = %.4e H\n', M_numerical);
fprintf('\n');

% Plot the configuration
figure(1);
clf;

% Plot coil 1 (small coil) at z = -d/2
theta = linspace(0, 2*pi, 100);
x1 = a1 * cos(theta);
y1 = a1 * sin(theta);
z1 = -d/2 * ones(size(theta));

% Plot coil 2 (large coil) at z = d/2
x2 = a2 * cos(theta);
y2 = a2 * sin(theta);
z2 = d/2 * ones(size(theta));

% 3D plot
subplot(1,2,1);
plot3(x1, y1, z1, 'b-', 'LineWidth', 2);
hold on;
plot3(x2, y2, z2, 'r-', 'LineWidth', 2);
plot3([0 0], [0 0], [-d/2 d/2], 'k--', 'LineWidth', 1);
xlabel('x (m)');
ylabel('y (m)');
zlabel('z (m)');
title('Coaxial Coil Configuration');
legend('Coil 1 (a=0.01m)', 'Coil 2 (a=0.04m)', 'Axis');
grid on;
axis equal;
view(45, 30);

% 2D projection
subplot(1,2,2);
plot(x1, y1, 'b-', 'LineWidth', 2);
hold on;
plot(x2, y2, 'r-', 'LineWidth', 2);
plot(0, 0, 'ko', 'MarkerSize', 8);
xlabel('x (m)');
ylabel('y (m)');
title('Top View (x-y plane)');
legend('Coil 1', 'Coil 2', 'Center');
axis equal;
grid on;

sgtitle('Mutual Inductance Problem Geometry');

% Function for numerical integration
function M = mutual_inductance_numerical(a1, a2, d, mu0, N1, N2, num_segments)
    % Discretize the angles
    phi1 = linspace(0, 2*pi, num_segments + 1);
    phi2 = linspace(0, 2*pi, num_segments + 1);
    
    % Coil 1 is at z = -d/2, Coil 2 is at z = d/2
    z1 = -d/2;
    z2 = d/2;
    
    % Precompute coil points
    points1_x = a1 * cos(phi1(1:end-1));
    points1_y = a1 * sin(phi1(1:end-1));
    points1_z = z1 * ones(size(points1_x));
    
    points2_x = a2 * cos(phi2(1:end-1));
    points2_y = a2 * sin(phi2(1:end-1));
    points2_z = z2 * ones(size(points2_x));
    
    % Calculate dl vectors for coil 1
    dl1_x = diff(a1 * cos(phi1));
    dl1_y = diff(a1 * sin(phi1));
    dl1_z = zeros(size(dl1_x));
    
    % Calculate dl vectors for coil 2
    dl2_x = diff(a2 * cos(phi2));
    dl2_y = diff(a2 * sin(phi2));
    dl2_z = zeros(size(dl2_x));
    
    % Calculate mutual inductance using Neumann's formula
    M_sum = 0;
    
    for i = 1:num_segments
        for j = 1:num_segments
            % Position vectors
            r1 = [points1_x(i), points1_y(i), points1_z];
            r2 = [points2_x(j), points2_y(j), points2_z];
            
            % dl vectors
            dl1 = [dl1_x(i), dl1_y(i), dl1_z(i)];
            dl2 = [dl2_x(j), dl2_y(j), dl2_z(j)];
            
            % Distance between segments
            R_vec = r2 - r1;
            R = norm(R_vec);
            
            % Dot product of dl vectors
            dl1_dot_dl2 = dot(dl1, dl2);
            
            % Add contribution to mutual inductance
            M_sum = M_sum + dl1_dot_dl2 / R;
        end
    end
    
    M = mu0/(4*pi) * M_sum * N1 * N2;
end

fprintf('Set 17 - Mutual Inductance Calculation Completed\n');