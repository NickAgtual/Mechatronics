close all; clear; clc;

%% Given Parameters

% Mass [kg]
M = 100;

% K [N/m]
K = [1.5 15 150];

% fv [kg/s]
fv = [3 270 78];

%% Constructing Transfer Function and Plotting Output

% Creating new figure
figure(1)

% Numerator of transfer function
% Constant for all cases
numerator = 1/M;


for ii = 1:length(K)
    
    % Denominator of transfer function for all 3 cases
    denominator = [1 fv(ii)/M K(ii)/M];
    
    % Generating transfer function
    Gs = tf(numerator, denominator);
    
    % Creating subplot
    subplot(3, 1, ii)
    
    % Plotting the step response of the system
    step(Gs)
    hold on
    
    % Plot parameters
    grid on
    grid minor
    
    % Plot descriptors
    xlabel('{\emph Time}','fontsize',14,'Interpreter','latex');
    ylabel('{\emph Aplitude }','fontsize',14,'Interpreter','latex');
    titleText = sprintf('Step Response - %d', ii);
    title(titleText,'fontsize',16,'Interpreter','latex');
    leg = sprintf('System Parameter Combination - %d', ii);
    
    % Placing legend in southeast corner for cobination 2
    if ii == 2
        
    legend(leg, 'fontsize', 10, 'location', 'southeast','Interpreter', ...
        'latex')
    
    % Placing legend in northeast corner for combination 1 & 3
    else
        
        legend(leg, 'fontsize', 10, 'location', 'northeast','Interpreter', ...
        'latex')
    
    end

end


%% Characteristic Parameters

% Initializing vectors
wn = zeros(1, length(K));
x = zeros(1, length(K));
zeta = zeros(1, length(K));

for ii = 1: length(K)
    
    % Natural frequency
    wn(ii) = sqrt(K(ii) / M);
    
    % x = 2 * zeta * wn
    x(ii) = fv(ii) / M;
    
    zeta(ii) = x(ii) / (2 * wn(ii));
    
end



%% System Response

% Creating new figure
figure(2)

% Initializing arrays
characteristicRoots = zeros(length(K), 2);

% Plotting poles
for ii = 1:length(K)
    
    % Denominator of transfer function for all 3 cases
    denominator = [1 fv(ii)/M K(ii)/M];
    
    % Generating transfer function
    Gs = tf(numerator, denominator);
    
    % Solving for roots of characteristic polynomial
    polynomialRoots = roots(denominator);
    
    % Storing roots
    characteristicRoots(ii, 1) = polynomialRoots(1, 1);
    characteristicRoots(ii, 2) = polynomialRoots(2, 1);
    
    % Creating pole - zero plot
    pzplot(Gs);
    
    hold on

end

% Turning grid on
grid on

% Plot descriptors
set(gca, 'fontName', 'Times');
xlabel('\sigma Real Axis', 'fontName', 'Times', 'fontSize', 14);
ylabel('j\omega_{n} Imaginary Axis', 'fontName', 'Times', 'fontSize', 14);
title('{Pole-Zero Map}','fontsize',16,'Interpreter','latex');
legend('Poles - Case 1', 'Poles - Case 2', 'Poles - Case 3', ...
       'fontsize', 10, 'Interpreter', 'latex', 'location', 'northwest');
  
   
   










