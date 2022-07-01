%% Set the initial conditions
% State vector x will consist of the position and velocity vectors of the
% satellite
Pos_0 = [8000; 0; 6000];        % Initial position of the satellite (x, y, z) [km]
Vel_0 = [0; 5; 5];              % Initial velocity of the satellite (x, y, z) [km/s] 
x_0 = [Pos_0; Vel_0];           % Initial state of the satellite

%% Prelocate some variables
t = 0;
x = NaN(1,6);

%% Integrating the state value over time
tspan = 0 : 20 : 4*60*60;                % time span (2 hours times 60 minutes 
                                    % times 60 seconds) [s]
[t,x] = ode45(@f, tspan, x_0);      % Intergate the differential equation 
                                    % over the time span with Runge-Kutta
                                    % 4-5 ordinary differentail equation solver 

Pos = x(:,1:3);     % Extract the position
Vel = x(:,4:6);     % Extract the velocity

%% Plot the results
figure;             % Plot the 3D trajectory
draw_sphere(0,0,0, 6371), hold on;
grid on, title('Orbital trajectory (inertial reference frame)');
xlabel('X [km]'), ylabel('Y [km]'), zlabel('Z [km]');
plot3(Pos_0(1), Pos_0(2), Pos_0(3), 'or', 'Linewidth', 2);	% Initial point
plot3(Pos(:,1), Pos(:,2), Pos(:,3), 'r', 'Linewidth', 2);   % Trajectory

figure;             % Plot the position and velocity over time
ax1 = subplot(2,1,1);
plot(t, Pos), grid on, ylabel('Position [km]');
legend('X','Y','Z');
ax2 = subplot(2,1,2);
plot(t, Vel), grid on, ylabel('Velocity [km/s]'), xlabel('Time [s]');
legend('X','Y','Z');

%% Calculating the state derivatives function
function dxdt = f(t,x)
    dxdt = zeros(6, 1);
    
    mu = 398600;            % Standard gravitational parameter for Earth

    Pos = x(1:3);           % Extracting position from the state vector
    Vel = x(4:6);           % Extractng velocity from the state vector
    
    r = sqrt(sum(Pos.^2));  % Calculateing the distance from the centre of the Earth 
    dPos_dt = Vel;              % Derivative of the position
    dVel_dt = -mu / r^3 * Pos;  % Derivative of the velocity
    
    dxdt = [dPos_dt; dVel_dt];
end