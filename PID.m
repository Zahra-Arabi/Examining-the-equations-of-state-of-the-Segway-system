% Parameters
m = 0.1;    % Mass of the wheel
l = 0.5;    % Distance from body's center of mass to the wheel axis
I = 0.006;  % Moment of inertia of the body around its center of mass
g = 9.81;   % Acceleration due to gravity
M = 1.0;    % Parameter M

% Desired performance specifications
zeta = 0.6;      % Damping ratio
wn = 1.4;        % Natural frequency (rad/s)

% Calculate PID gains
Kp = 2 * zeta * wn;
Ki = wn^2/zeta;
Kd = 2 * zeta * wn;

% Nonlinear state-space equations
A = @(t, x, u) [
    x(2);
    ((m*g*l*sin(x(1)))/(I^2 + m*l^2) * u - m*l*sin(x(1))*x(4)^2 + m*l*cos(x(1))) / ((m^2*l^2*cos(x(1))^2)/(I^2 + m*l^2) - (M+m));
    x(4);
    (((u^2 - m*l*sin(x(1))*x(2))/(M+m)) * m*g*l*sin(x(1)) - m*l*cos(x(1))) / ((m*l^2*cos(x(1))^2)/(M+m) - I^2 + m*l)
];

% Simulation settings
tspan = [0 10];         % Simulation time span
x0 = [0.1; 0; 0.2; 0];   % Initial state [theta; theta_dot; phi; phi_dot]

% Simulate the system with PID control using ode45
[t, x] = ode45(@(t, x) A(t, x, -Kp*x(1) - Ki*trapz(t, x(:, 1)) - Kd*x(2)), tspan, x0);

% Plot the response
figure;

% Plotting angles
subplot(2, 1, 1);
plot(t, x(:, 1), 'b', 'LineWidth', 2);
hold on;
plot(t, x(:, 3), 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Angle (rad)');
title('Nonlinear Segway System Response (PID Control)');
legend('theta', 'phi');
grid on;

% Plotting angular velocities
subplot(2, 1, 2);
plot(t, x(:, 2), 'b', 'LineWidth', 2);
hold on;
plot(t, x(:, 4), 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Angular Velocity (rad/s)');
legend('theta\_dot', 'phi\_dot');
grid on;

% Performance metrics
info = stepinfo(x(:, 1), t);  % Step info for theta
OS = info.Overshoot;         % Overshoot
Ts = info.SettlingTime;      % Settling time

disp(['Overshoot (theta): ', num2str(OS)]);
disp(['Settling Time (theta): ', num2str(Ts)]);

