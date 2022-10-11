close all; clear; clc;

tOn = [1 3; 4 7; 9 11];
tOff = [0 1; 3 4; 7 9];

Von = .2;
Voff = 5;

syms x 

% Creating piecewse function
y = piecewise(tOff(1,1) < x < tOff(1, 2), Voff, ...
              tOn(1, 1) < x < tOn(1, 2), Von, ...
              tOn(2, 1) < x < tOn(2, 2), Von, ...
              tOn(3, 1) < x < tOn(3, 2), Von, Voff);

% Opening new figure
figure(1)

% Plotting function
fplot(y)

% Axis Limits
xlim([0 12]);
ylim([0 5.5]);

% Plot Descriptors
xlabel('Time (s)', 'fontsize', 14, 'Interpreter', 'latex');
ylabel('V$_{out}$ (V)', 'fontsize', 14, ...
    'Interpreter', 'latex');
title('{Output Voltage vs. Time}', ...
    'fontsize', 16, 'Interpreter', 'latex');
legend('V$_{out}$', 'location','northeast', 'Interpreter', 'latex');
