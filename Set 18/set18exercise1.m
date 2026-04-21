%% Set 18 - Toroid Self Inductance
% Exercise: Toroid with N=200 turns, inner radius=2.0 cm, outer radius=2.5 cm.
% Find self inductance analytically and numerically.

clc;
clear;
close all;

% Constants
mu0 = 4*pi*1e-7;    % permeability of free space (H/m)

% Given parameters
N = 200;            % number of turns
a = 0.02;           % inner radius (m)
b = 0.025;          % outer radius (m)
h = b - a;          % height of toroid (assuming square cross-section) (m)

% Analytical solution (assuming rectangular cross-section)
L_analytical = (mu0 * N^2 * h) / (2*pi) * log(b/a);

% Display analytical result
fprintf('\n========================================\n');
fprintf('SET 18: Toroid Self Inductance\n');
fprintf('========================================\n');
fprintf('Parameters:\n');
fprintf('  N = %d turns\n', N);
fprintf('  a = %.4f m (%.2f cm)\n', a, a*100);
fprintf('  b = %.4f m (%.2f cm)\n', b, b*100);
fprintf('  h = %.4f m (%.2f cm)\n', h, h*100);
fprintf('  mu0 = %.2e H/m\n', mu0);
fprintf('\nAnalytical Result:\n');
fprintf('  L_analytical = %.4e H = %.4f μH\n', L_analytical, L_analytical*1e6);

%% Numerical Solution Method 1: Energy Method
% Calculate total magnetic energy stored in toroid
% Energy = 1/2 * L * I^2, so L = 2*Energy/I^2

I_test = 1.0;  % Test current (A)

% Discretize the toroid volume
num_rho = 100;      % divisions in radial direction
num_phi = 100;      % divisions in azimuthal direction
num_z = 50;         % divisions in vertical direction

drho = (b - a) / num_rho;
dphi = 2*pi / num_phi;
dz = h / num_z;

total_energy = 0;

for i = 1:num_rho
    rho = a + (i - 0.5) * drho;
    B = mu0 * N * I_test / (2 * pi * rho);
    H = B / mu0;
    
    for j = 1:num_phi
        for k = 1:num_z
            % Volume element
            dV = rho * drho * dphi * dz;
            % Energy density = 1/2 * B * H
            dW = 0.5 * B * H * dV;
            total_energy = total_energy + dW;
        end
    end
end

L_numerical_energy = 2 * total_energy / I_test^2;

fprintf('\nNumerical Results:\n');
fprintf('  Method 1 (Energy Method): L = %.4e H = %.4f μH\n', ...
        L_numerical_energy, L_numerical_energy*1e6);

%% Numerical Solution Method 2: Flux Linkage Method
% Direct calculation of flux linkage

num_phi_flux = 200;     % divisions for flux calculation
num_rho_flux = 200;

drho_flux = (b - a) / num_rho_flux;
dphi_flux = 2*pi / num_phi_flux;

% Calculate flux through one turn at mean radius
% For a toroid, flux through each turn is approximately the same
flux_per_turn = 0;

for i = 1:num_rho_flux
    rho = a + (i - 0.5) * drho_flux;
    B = mu0 * N * I_test / (2 * pi * rho);
    
    % Area element in the cross-section
    dA = drho_flux * h;
    flux_per_turn = flux_per_turn + B * dA;
end

% Total flux linkage
lambda = N * flux_per_turn;
L_numerical_flux = lambda / I_test;

fprintf('  Method 2 (Flux Linkage): L = %.4e H = %.4f μH\n', ...
        L_numerical_flux, L_numerical_flux*1e6);

%% Method 3: Using formula for circular cross-section toroid
% For toroid with circular cross-section of radius r_c
r_c = h / 2;  % radius of circular cross-section
L_circular = mu0 * N^2 * (sqrt(b) - sqrt(a))^2;

fprintf('  Method 3 (Circular CS approx): L = %.4e H = %.4f μH\n', ...
        L_circular, L_circular*1e6);

%% Plot the magnetic field distribution in the toroid
figure(1);
clf;

% Create grid for plotting
rho_plot = linspace(a, b, 50);
phi_plot = linspace(0, 2*pi, 50);
[rho_grid, phi_grid] = meshgrid(rho_plot, phi_plot);

% Calculate B field magnitude
B_mag = mu0 * N * I_test ./ (2 * pi * rho_grid);

% Convert to Cartesian coordinates for plotting
X = rho_grid .* cos(phi_grid);
Y = rho_grid .* sin(phi_grid);

% Plot B field magnitude as a surface
surf(X, Y, B_mag);
xlabel('x (m)');
ylabel('y (m)');
zlabel('|B| (T)');
title('Magnetic Field Distribution in Toroid');
colorbar;
colormap('jet');
view(0, 90);  % Top view
axis equal;
grid on;

% Add toroid boundaries
hold on;
theta_circle = linspace(0, 2*pi, 100);
x_inner = a * cos(theta_circle);
y_inner = a * sin(theta_circle);
x_outer = b * cos(theta_circle);
y_outer = b * sin(theta_circle);
plot(x_inner, y_inner, 'k--', 'LineWidth', 2);
plot(x_outer, y_outer, 'k--', 'LineWidth', 2);
hold off;

% Second plot: B field vs radial distance
figure(2);
rho_line = linspace(a, b, 200);
B_line = mu0 * N * I_test ./ (2 * pi * rho_line);
plot(rho_line*100, B_line*1e6, 'b-', 'LineWidth', 2);
xlabel('Radial Distance (cm)');
ylabel('Magnetic Field |B| (μT)');
title('Magnetic Field Inside Toroid vs. Radial Position');
grid on;
xlim([a*100, b*100]);

% Add vertical lines for inner and outer boundaries
hold on;
yl = ylim;
plot([a*100 a*100], yl, 'r--', 'LineWidth', 1.5);
plot([b*100 b*100], yl, 'r--', 'LineWidth', 1.5);
text(a*100, yl(2)*0.9, sprintf('a = %.1f cm', a*100), ...
     'HorizontalAlignment', 'right', 'Color', 'r');
text(b*100, yl(2)*0.9, sprintf('b = %.1f cm', b*100), ...
     'HorizontalAlignment', 'left', 'Color', 'r');
hold off;

%% Summary Table
fprintf('\n========================================\n');
fprintf('SUMMARY - Self Inductance of Toroid\n');
fprintf('========================================\n');
fprintf('Method                     | Inductance (H)    | Inductance (μH)\n');
fprintf('---------------------------|-------------------|-----------------\n');
fprintf('Analytical (rectangular)   | %.4e     | %.4f\n', L_analytical, L_analytical*1e6);
fprintf('Numerical (energy method)  | %.4e     | %.4f\n', L_numerical_energy, L_numerical_energy*1e6);
fprintf('Numerical (flux method)    | %.4e     | %.4f\n', L_numerical_flux, L_numerical_flux*1e6);
fprintf('Circular cross-section     | %.4e     | %.4f\n', L_circular, L_circular*1e6);
fprintf('========================================\n');

% Calculate percent difference between methods
diff_percent = abs(L_numerical_energy - L_analytical) / L_analytical * 100;
fprintf('\nPercent difference (Analytical vs Energy Method): %.2f%%\n', diff_percent);

disp('Set 18 - Toroid Self Inductance Calculation Completed');