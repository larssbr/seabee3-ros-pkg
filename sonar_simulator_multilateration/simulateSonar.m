function [data] = simulateSonar(pinger_truth, hydrophone_spacing, varargin)
plot_sim = false;
plot_hyperboloid = false;
plot_2d = false;
plot_3d = false;
%pinger_truth: Location of the pinger in cartesian coordinates
%hydrophone_spacing: Side length of regular tetrahedron formed by the
%hydrophones
%Options: 'Plot'
%% Parse function arguments
num_varargs = length(varargin);
if num_varargs > 4
    error('Function accepts at most 4 optionals inputs');
end


if num_varargs > 0
    for i = 1:num_varargs
        if strcmpi(varargin{i}, 'Plot')
            plot_sim = true;
        end
        if strcmpi(varargin{i}, 'Hyp')
            plot_hyperboloid = true;
        end
        if strcmpi(varargin{i}, '3d')
            plot_3d = true;
        end
        if strcmpi(varargin{i}, '2d')
            plot_2d= true;
        end
    end
end

%% Simulation Parameters

% Possible pinger frequencies in hertz
available_pinger_frequency = [22000;23000;24000;25000;26000;27000;28000;29000;30000];

% Pinger frequency in use
pinger_frequency = available_pinger_frequency(1);

% Highest possible pinger frequency, used for hydrophone spacing
%max_frequency = available_pinger_frequency(length(available_pinger_frequency));

% Sample rate
sample_frequency = 10000000;

% Number of hydrophones we will be using
num_hydrophones = 4;

% Set arbitrary water temperature of 90F
water_temp = 90;

% Get velocity of the pinger signal
water_velocity = waterVelocityLookup(water_temp);

% Max distance to a point in the pool
pool_size = 10;

% Size of spheres in plot
pinger_model = .2;

% Size of the pinger in ft
pinger_radius = .2;

% Arbitrary pinger location.
%phi= pi/2;
%theta = 0;
%rho = 50;

% Get pinger coordinates in cartesian
%pinger_truth = [rho*sin(phi)*cos(theta),rho*sin(phi)*sin(theta),rho*cos(phi)];


hydroi = [0, 0, hydrophone_spacing*sqrt(2/3)];
hydroj = [hydrophone_spacing/sqrt(3), 0, 0];
hydrok = [-hydrophone_spacing/(2*sqrt(3)), hydrophone_spacing/2, 0];
hydrol = [-hydrophone_spacing/(2*sqrt(3)), -hydrophone_spacing/2, 0];
hydrophones = {hydroi, hydroj, hydrok, hydrol};

% Generate the source signal
[time, signal] = generatePingerOutput(pinger_frequency, sample_frequency);

% Order is: hydrophone i, hydrophone j, hydrophone k, hydrophone l
hydrophone_signal = addPropagationDelay(signal, hydrophones, sample_frequency, pinger_truth, water_velocity);

if plot_sim == true
    
    figure;
    subplot(2,1,1);
    plot_colors = {'b', 'r', 'g', 'm'};
    plot(time, signal, 'k');
    hold on;
    for i = 1:length(hydrophone_signal)
        plot(time, hydrophone_signal{i}, plot_colors{i});
    end
    
    % Plot the delayed signals
    title('Hydrophone Signals');
    xlabel('Time [s]');
    ylabel('Amplitude');
    legend('Pinger Output', 'Hydrophone 1', 'Hydrophone 2', 'Hydrophone 3', 'Hyrophone 4');
    
end

% Correlate signals to find delay
corr_time = [-fliplr(time), time(1:(length(time)-1))];

%Tij
corr{1} = xcorr(hydrophone_signal{2}, hydrophone_signal{1});
%Tik
corr{2} = xcorr(hydrophone_signal{3}, hydrophone_signal{1});
%Tjk
corr{3} = xcorr(hydrophone_signal{2}, hydrophone_signal{3});
%Tkl
corr{4} = xcorr(hydrophone_signal{4}, hydrophone_signal{3});

delay = zeros(1,num_hydrophones);
for i = 1:length(delay)
    [~, corr_delay] = max(corr{i});
    delay(i) = corr_time(corr_delay);
end

if plot_sim == true
    % Plot phase differences
    subplot(2,1,2);
    x = [1,2,3,4];
    bar(x, [delay(1), delay(2), delay(3), delay(4)]);
    set(gca, 'XTickLabel', {'i-j', 'i-k', 'k-j', 'k-l'});
    title('Hydrophone Pair Time Differences');
    xlabel('Hydrophone pair');
    ylabel('Time [s]');
    
    
    % Plot correlated signals
    figure;
    for i = 1:length(corr)
       subplot(4,1,i);
       plot(corr_time, corr{i});
    end
    
    
    
end

% Multilateration from Misra et al. ---------------------------------------

% Time-difference-of-arrivals
R = delay*water_velocity;
Rij = R(1);
Rik = R(2);
Rkj = R(3);
Rkl = R(4);

% Let me tell you a story about how my life got flipped turned upside down:
hydroij = hydroi - hydroj;
hydroik = hydroi - hydrok;
hydroil = hydroi - hydrol;
hydroji = hydroj - hydroi;
hydrojk = hydroj - hydrok;
hydrojl = hydroj - hydrol;
hydroki = hydrok - hydroi;
hydrokj = hydrok - hydroj;
hydrokl = hydrok - hydrol;
hydroli = hydrol - hydroi;
hydrolj = hydrol - hydroj;
hydrolk = hydrol - hydrok;

% Coefficients for the linear position equations
A = (Rik*hydroji(1) - Rij*hydroki(1))/(Rij*hydroki(2)- Rik*hydroji(2));
B = (Rik*hydroji(3) - Rij*hydroki(3))/(Rij*hydroki(2)- Rik*hydroji(2));
C = (Rik*(Rij^2 + hydroi(1)^2 - hydroj(1)^2 + hydroi(2)^2 - hydroj(2)^2 + hydroi(3)^2 - hydroj(3)^2) - Rij*(Rik^2 + hydroi(1)^2 - hydrok(1)^2 + hydroi(2)^2 - hydrok(2)^2 + hydroi(3)^2 - hydrok(3)^2))/(2*(Rij*hydroki(2) - Rik*hydroji(2)));
D = (Rkl*hydrojk(1) - Rkj*hydrolk(1))/(Rkj*hydrolk(2) - Rkl*hydrojk(2));
E = (Rkl*hydrojk(3) - Rkj*hydrolk(3))/(Rkj*hydrolk(2) - Rkl*hydrojk(2));
F = (Rkl*(Rkj^2 +hydrok(1)^2 - hydroj(1)^2 + hydrok(2)^2 - hydroj(2)^2 + hydrok(3)^2 - hydroj(3)^2) - Rkj*(Rkl^2 + hydrok(1)^2 - hydrol(1)^2 + hydrok(2)^2 - hydrol(2)^2 + hydrok(3)^2 - hydrol(3)^2))/(2*(Rkj*hydrolk(2) - Rkl*hydrojk(2)));
G = (E - B)/(A -D);
H = (F - C)/(A - D);
I = A*G + B;
J = A*H + C;
K = Rik^2 + hydroi(1)^2 - hydrok(1)^2 + hydroi(2)^2 - hydrok(2)^2 + hydroi(3)^2 - hydrok(3)^2 + 2*hydroki(1)*H - 2*hydroki(2)*J;
L = 2*(hydroki(1)*G + hydroki(2)*I + 2*hydroki(3));
M = 4*(Rik^2)*(G^2 + I^2 + 1) - L^2;
N = 8*(Rik^2)*(G*(hydroi(1) - H) + I*(hydroi(2)- J) + hydroi(3)) + 2*L*K;
O = 4*(Rik^2)*((hydroi(1) - H)^2 + (hydroi(2) - J)^2 + hydroi(3)^2) - K^2;

% Get estimated pinger coordinates
zcoeff = sqrt((N/(2*M))^2 - O/M);
z= (N/(2*M)) + [zcoeff, - zcoeff];
%z = z*100;
x = G*z + H;
y = I*z + J;
pinger_solved{1} = [x(1),y(1),z(1)];
pinger_solved{2} = [x(2),y(2),z(2)];


% fprintf('Found %d possible pinger points\n', length(intersection_cartesian));
% fprintf('Average pinger location (%f, %f, %f)\n', avg_intersect_cartesian(1), avg_intersect_cartesian(2), avg_intersect_cartesian(3));
%
% fprintf('Got average pinger angles phi=%f deg, theta=%f deg\n', avg_intersect_spherical(2)*180/pi, avg_intersect_spherical(3)*180/pi);
% fprintf('Truth values: phi=%f, theta=%f deg\n', phi*180/pi, theta*180/pi);
% fprintf('Error: phi %f deg, theta %f deg\n', angleDifference(phi, avg_intersect_spherical(2))*180/pi, angleDifference(theta,avg_intersect_spherical(3))*180/pi);
%
% plot_title = sprintf('Phase Cones with pinger at {\\rho}=%f {\\theta}=%f {\\phi}=%f',rho,theta,phi);
% title(plot_title);

if plot_sim == true && plot_2d == true
    %% Plot simulation in 2d
        
    figure;
    hold on;
    
    % Plot the hydrophone array
    scatter(hydroi(1), hydroi(2), 'b');
    scatter(hydroj(1), hydroj(2), 'r');
    scatter(hydrok(1), hydrok(2), 'g');
    scatter(hydrol(1), hydrol(2), 'y');
    hydrovector = [hydroi;hydroj;hydrok;hydroi;hydrol;hydroj;hydrok;hydrol];
    plot(hydrovector(:,1), hydrovector(:,2), 'b')
    
    % Plot pinger location and estimate
        
    % Plot a sphere at pinger location
    scatter(pinger_truth(1),  pinger_truth(2), 'k');
    
    % Plot a sphere at estimated pinger location
    scatter(pinger_solved{1}(1), pinger_solved{1}(2), 'r');
    scatter(pinger_solved{2}(1), pinger_solved{2}(2), 'b');
    for i = 1:2
        cplabel = sprintf('\\leftarrow Pinger solution %d at (%f ,%f, %f)', i, pinger_solved{i}(1), pinger_solved{i}(2), pinger_solved{i}(3));
        text(pinger_solved{i}(1), pinger_solved{i}(2), cplabel);
    end
    cplabel = sprintf('True pinger location at (%f ,%f, %f) \\rightarrow', pinger_truth(1), pinger_truth(2), pinger_truth(3));
    text(pinger_truth(1), pinger_truth(2), cplabel, 'HorizontalAlignment', 'right');
        
     
    if plot_hyperboloid == true
        %% Plot hyperboloid in 2d    
        colors = {'green', 'red', 'blue', 'yellow'};
        range = -100:10:100;
        z = pinger_solved{2}(3);
        x = range; y = range;
        hyp{1} = ((hydroi(1) - x).^2 + (hydroi(2) - y).^2 + (hydroi(3) - z).^2) - ((Rij^2 + hydroi(1)^2 - hydroj(1)^2 + hydroi(2)^2 - hydroj(2)^2 + hydroi(3)^2 - hydroj(3)^2 + 2*hydroji(1).*x + 2*hydroji(2).*y + 2*hydroji(3).*z)/(2*Rij)).^2;
        hyp{2} = ((hydroi(1) - x).^2 + (hydroi(2) - y).^2 + (hydroi(3) - z).^2) - ((Rik^2 + hydroi(1)^2 - hydrok(1)^2 + hydroi(2)^2 - hydrok(2)^2 + hydroi(3)^2 - hydrok(3)^2 + 2*hydroki(1).*x + 2*hydroki(2).*y + 2*hydroki(3).*z)/(2*Rik)).^2;
        hyp{3} = ((hydrok(1) - x).^2 + (hydrok(2) - y).^2 + (hydrok(3) - z).^2) - ((Rkj^2 + hydrok(1)^2 - hydroj(1)^2 + hydrok(2)^2 - hydroj(2)^2 + hydrok(3)^2 - hydroj(3)^2 + 2*hydrojk(1).*x + 2*hydrojk(2).*y + 2*hydrojk(3).*z)/(2*Rkj)).^2;
        hyp{4} = ((hydrok(1) - x).^2 + (hydrok(2) - y).^2 + (hydrok(3) - z).^2) - ((Rkl^2 + hydrok(1)^2 - hydrol(1)^2 + hydrok(2)^2 - hydrol(2)^2 + hydrok(3)^2 - hydrol(3)^2 + 2*hydrolk(1).*x + 2*hydrolk(2).*y + 2*hydrolk(3).*z)/(2*Rkl)).^2;
        
        for i = 1:4
            y = isoline(x,y,hyp{i});
            scatter(x,y);
        end
        camlight;  
        
    end
end

if plot_sim == true && plot_3d == true
    %% Plot simulation in 3d
        
    % Plot simulation with phase cones
    figure;
    hold on;
    
    % Plot a sphere at pinger location
    plotSphere(pinger_truth,  pinger_radius, [0 0 0]);
    
    % Plot a sphere at estimated pinger location
    plotSphere(pinger_solved{1}, pinger_radius, [1 0 0]);
    plotSphere(pinger_solved{2}, pinger_radius, [0 0 1]);
    for i = 1:2
        cplabel = sprintf('\\leftarrow Pinger solution %d at (%f ,%f, %f)', i, pinger_solved{i}(1), pinger_solved{i}(2), pinger_solved{i}(3));
        text(pinger_solved{i}(1), pinger_solved{i}(2), pinger_solved{i}(3), cplabel);
    end
    cplabel = sprintf('True pinger location at (%f ,%f, %f) \\rightarrow', pinger_truth(1), pinger_truth(2), pinger_truth(3));
    text(pinger_truth(1), pinger_truth(2), pinger_truth(3), cplabel, 'HorizontalAlignment', 'right');
    
    % Plot spheres at hydrophone coordinates
    %hydrophone_spacing = 1;
    
    plotSphere(hydroi, pinger_model,[0 0 0]);
    plotSphere(hydroj, pinger_model,[1 0 0]);
    plotSphere(hydrok, pinger_model,[0 1 0]);
    plotSphere(hydrol, pinger_model,[0 0 1]);
    
    % Plots the edges of the hydrophone tetrahedron
    hydrovector = [hydroi;hydroj;hydrok;hydroi;hydrol;hydroj;hydrok;hydrol];
    plot3(hydrovector(:,1), hydrovector(:,2), hydrovector(:,3));
    
    if plot_hyperboloid == true
        %% Plot hyperboloid in 3d    
        colors = {'green', 'red', 'blue', 'yellow'};
        range = -100:10:100;
        [x,y,z]=meshgrid(range);
        hyp{1} = ((hydroi(1) - x).^2 + (hydroi(2) - y).^2 + (hydroi(3) - z).^2) - ((Rij^2 + hydroi(1)^2 - hydroj(1)^2 + hydroi(2)^2 - hydroj(2)^2 + hydroi(3)^2 - hydroj(3)^2 + 2*hydroji(1).*x + 2*hydroji(2).*y + 2*hydroji(3).*z)/(2*Rij)).^2;
        hyp{2} = ((hydroi(1) - x).^2 + (hydroi(2) - y).^2 + (hydroi(3) - z).^2) - ((Rik^2 + hydroi(1)^2 - hydrok(1)^2 + hydroi(2)^2 - hydrok(2)^2 + hydroi(3)^2 - hydrok(3)^2 + 2*hydroki(1).*x + 2*hydroki(2).*y + 2*hydroki(3).*z)/(2*Rik)).^2;
        hyp{3} = ((hydrok(1) - x).^2 + (hydrok(2) - y).^2 + (hydrok(3) - z).^2) - ((Rkj^2 + hydrok(1)^2 - hydroj(1)^2 + hydrok(2)^2 - hydroj(2)^2 + hydrok(3)^2 - hydroj(3)^2 + 2*hydrojk(1).*x + 2*hydrojk(2).*y + 2*hydrojk(3).*z)/(2*Rkj)).^2;
        hyp{4} = ((hydrok(1) - x).^2 + (hydrok(2) - y).^2 + (hydrok(3) - z).^2) - ((Rkl^2 + hydrok(1)^2 - hydrol(1)^2 + hydrok(2)^2 - hydrol(2)^2 + hydrok(3)^2 - hydrol(3)^2 + 2*hydrolk(1).*x + 2*hydrolk(2).*y + 2*hydrolk(3).*z)/(2*Rkl)).^2;
        
        for i = 1:4
            p=patch(isosurface(x,y,z,hyp{i}, 0));
            isonormals(x,y,z,hyp{i}, p)
            set(p, 'FaceColor', colors{i}, 'EdgeColor', 'none')
        end
        camlight;  
        
    end
end

% Data to return
% rho_solved = norm(pinger_solved{2});
% 
% phi_solved = acos(pinger_solved{2}(3)/rho_solved);
% theta_solved = atan2(pinger_solved{2}(2),pinger_solved{2}(1));
% pinger_solved_spherical = [rho_solved, phi_solved, theta_solved];
% 
% est_error(1) = abs(pinger_solved_spherical(1) - rho);
% est_error(2) = angleDifference(pinger_solved_spherical(2), phi);
% est_error(3) = angleDifference(pinger_solved_spherical(3), theta);
pinger_solved = pinger_solved{2};
est_error = abs(pinger_truth - pinger_solved);

data = struct('SolvedPingerPosition', pinger_solved,'Error', est_error, 'HydrophoneI', hydroi, 'HydrophoneJ', hydroj, 'HydrophoneK', hydrok, 'HydrophoneL', hydrol);


    