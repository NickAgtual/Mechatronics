close all; clear; clc

%% Importing Excel Workbook
fileName = 'Lab 4 - Data';

%% Bang Bang Temperature Controller

% Time and temperature data
tempBangBang = xlsread(fileName, 'Bang Bang Temp Controller', 'H2:H1412');
timeBangBang = xlsread(fileName, 'Bang Bang Temp Controller', ...
    'I2:I1412');


% Plot
figure(1)
plot(timeBangBang * 10 ^ -3, tempBangBang);

% Plot features
hold on
grid on
grid minor
ylim([77 88]);
xlim([0 45]);

% Plot Descriptors
xlabel('\emph {Time (Seconds)}', 'fontsize', 14, 'Interpreter', 'latex');
ylabel('\emph {Temperature ($^{\circ}$F)}', 'fontsize', 14, ...
    'Interpreter', 'latex');
title('\emph {Bang-Bang Controller Output (85 $^{\circ}$F Setpoint)}', ...
    'fontsize', 16, 'Interpreter', 'latex');
legend('Bang Bang Controller', 'fontsize', 10, 'Interpreter', 'latex');

hold off


%% Step Input Response

% Time and temperature data
tempStepInput = xlsread(fileName, 'Step Response', 'H2:H1772');
timeStepInput = xlsread(fileName, 'Step Response', 'I2:I1772');

% Plot
figure(2)
plot(timeStepInput * 10 ^ -3, tempStepInput);

% Plot features
hold on
grid on
grid minor
xlim([0 timeStepInput(end) * 10 ^ -3]);
ylim([76 93]);


% Plot Descriptors
xlabel('\emph {Time (Seconds)}', 'fontsize', 14, 'Interpreter', 'latex');
ylabel('\emph {Temperature ($^{\circ}$F)}', 'fontsize', 14, ...
    'Interpreter', 'latex');
title('\emph {Natural response (100 PWM)}', ...
    'fontsize', 16, 'Interpreter', 'latex');
legend('Step Input response', 'fontsize', 10, 'Interpreter', 'latex');

hold off
%% Proportional Controller

% Time and temperature data
tempProportionalController = xlsread(fileName, ...
    'Proportional Controller', 'H2:H1184');
timeProportionalController = xlsread(fileName, ...
    'Proportional Controller', 'I2:I1184');

% Plot
figure(3)
plot(timeProportionalController * 10 ^ -3, tempProportionalController);

% Plot features
hold on
grid on
grid minor
xlim([0 timeProportionalController(end) * 10 ^ -3]);
ylim([78 88]);

% Plot Descriptors
xlabel('\emph {Time (Seconds)}', 'fontsize', 14, 'Interpreter', 'latex');
ylabel('\emph {Temperature ($^{\circ}$F)}', 'fontsize', 14, ...
    'Interpreter', 'latex');
title('\emph {Proportional Controller Output (10X Gain \& 95 $^{\circ}$ Setpoint)}', ...
    'fontsize', 16, 'Interpreter', 'latex');
legend('Proportional Controller response', 'fontsize', 10, ...
    'Interpreter', 'latex');

hold off
%%

figure(4)

hold on
grid on
grid minor

%% Transfer Function Plot


Tf = 86;
T0 = 78.5;
t0 = T0;
t63 = T0 + .63 * 7.5;

Tcorrected = Tf - T0;
tau = t63 - t0;

PWMcoil = 100;

Kg = Tcorrected ./ (tau * PWMcoil);

Gs = tf( [Kg], [1, (1/tau)]);
[c, t] = step(PWMcoil * Gs);


plot(timeProportionalController * 10 ^ -3, tempProportionalController);
plot(t, T0 + c);

% Plot Descriptors
xlim([0 20])
xlabel('\emph {Time (Seconds)}', 'fontsize', 14, 'Interpreter', 'latex');
ylabel('\emph {Temperature ($^{\circ}$F)}', 'fontsize', 14, ...
    'Interpreter', 'latex');
title('\emph {Transfer Function Overlay on Output}', ...
    'fontsize', 16, 'Interpreter', 'latex');
legend('Temperature Controller Response', 'Transfer Function', 'fontsize', 10, ...
    'Interpreter', 'latex', 'location', 'southeast');



