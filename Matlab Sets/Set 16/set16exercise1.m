%% Set 16 - Toroid Magnetic Field Plot
% Exercise: Toroid with N=200 turns, I=5.0 A, inner radius=1.5 cm, 
% outer radius=2.5 cm. Plot B field in x-y plane from -4 cm to 4 cm.

clc;
clear;
close all;

% Constants
mu0 = 4*pi*1e-7;    % permeability of free space (H/m)
N = 200;            % number of turns
I = 5.0;            % current (A)
a = 0.015;          % inner radius (m)
b = 0.025;          % outer radius (m)

% Precompute constant factor
B_factor = mu0 * N * I / (2*pi);  % = 2e-4

% Define plotting grid (in meters)
x_min = -0.04;
x_max = 0.04;
y_min = -0.04;
y_max = 0.04;

% Number of plotting points
num_points_x = 25;
num_points_y = 25;

% Create grid
x = linspace(x_min, x_max, num_points_x);
y = linspace(y_min, y_max, num_points_y);
[X, Y] = meshgrid(x, y);

% Initialize field components
Bx = zeros(size(X));
By = zeros(size(X));

% Calculate magnetic field at each point
for i = 1:num_points_x
    for j = 1:num_points_y
        rho = sqrt(X(j,i)^2 + Y(j,i)^2);
        
        if rho > a && rho < b
            % Inside toroid core - B field present
            B_mag = B_factor / rho;
            Bx(j,i) = -B_mag * Y(j,i) / rho;  % Bx = -B * sin(phi)
            By(j,i) = B_mag * X(j,i) / rho;   % By = B * cos(phi)
        else
            % Outside toroid core - B field approximately zero
            Bx(j,i) = 0;
            By(j,i) = 0;
        end
    end
end

% Plot the magnetic field
figure(1);
quiver(X, Y, Bx, By, 'b', 'LineWidth', 1);
hold on;

% Draw the toroid boundaries
theta_circle = linspace(0, 2*pi, 200);
x_inner = a * cos(theta_circle);
y_inner = a * sin(theta_circle);
x_outer = b * cos(theta_circle);
y_outer = b * sin(theta_circle);

plot(x_inner, y_inner, 'r--', 'LineWidth', 2);
plot(x_outer, y_outer, 'r--', 'LineWidth', 2);

% Fill the toroid region
fill([x_inner, fliplr(x_outer)], [y_inner, fliplr(y_outer)], [0.9 0.9 0.9], 'EdgeColor', 'none');

hold off;

% Formatting
xlabel('x (m)');
ylabel('y (m)');
title(sprintf('Magnetic Field of Toroid (N=%d, I=%.1f A)', N, I));
axis equal;
axis([x_min x_max y_min y_max]);
grid on;
legend('B Field', 'Toroid Boundaries', 'Location', 'best');

% Add text annotation
text(0.03, 0.035, sprintf('Inner radius = %.2f cm\na = %.2f cm', a*100, a*100), 'FontSize', 9, 'BackgroundColor', 'w');
text(0.03, 0.03, sprintf('Outer radius = %.2f cm\nb = %.2f cm', b*100, b*100), 'FontSize', 9, 'BackgroundColor', 'w');
text(0.03, 0.025, sprintf('N = %d turns\nI = %.1f A', N, I), 'FontSize', 9, 'BackgroundColor', 'w');

% Create a second plot showing magnitude as colormap
figure(2);
B_magnitude = sqrt(Bx.^2 + By.^2);
surf(X, Y, B_magnitude);
xlabel('x (m)');
ylabel('y (m)');
zlabel('|B| (T)');
title('Magnetic Field Magnitude Distribution');
colorbar;
colormap('jet');
view(45, 30);
grid on;

disp('Set 16 - Toroid Magnetic Field Plot Completed');