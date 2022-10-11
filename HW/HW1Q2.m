clear; close all; clc
%% Given Values

% Frequencies
frequencies = {[796 1193 1592 3183 3979], 'Hz'};

% Resistor
R = {1, 'kOhm'};

% Capacitor
C = {.1, 'uF'};

%% Impedance Conversions

% Calculating Omega
w = {frequencies{1} .* 2 .* pi, 'rad/s'};

% Capacitor impedance equivalent
Zc = -1i ./ (w{1} * (C{1} * 10^-6));

% Voltages source
Vi = @(t) sin(w * t);

% Complex Voltage (RMS)
ViComplex = (sqrt(2) ./ 2 ) * exp(1i);

%% Nodal Equations

% Defining voltage at node 1
Vn1 = ViComplex;

% Defining symbolic variables
syms Vn2

% Node voltage equation
nodalEq = ((Vn2 - Vn1) ./ (R{1} * 1000)) + ...
    (Vn2 ./ Zc) ==0;


voltageNode2 = zeros(1, length(Zc));

% Calculating voltages for different frequencies
for ii = 1:length(Zc)
    
    voltageNode2(ii) = double(solve(nodalEq(ii), Vn2));
    
end

current = zeros(1, length(Zc));

% Calculating current for different frequencies
for ii = 1:length(Zc)
    
    current(ii) = (Vn1 - voltageNode2(ii)) ./ (R{1} * 1000);
    
end

%% Complex Capacitor Voltages

Vc = zeros(1, length(current));

% Calculating complex capacitor voltages for different
% Frequencies
for ii = 1:length(current)
    
    Vc(ii) = Zc(ii) * current(ii);
    
end

%% Plots

% Creating Figure
figure(1)

% Adding axes
hold on
grid on
grid minor

% Computing y-Values
yVals = 20 * log(abs(Vc) ./ abs(ViComplex));

% Plotting y-values vs. frequencies
plot(frequencies{1}, yVals, 'o-');

% Plot Descriptors
xlabel('{Frequency (Hz)}', 'fontsize', 14, 'Interpreter', 'latex');
ylabel('20log($\mid$Vc$\mid$/$\mid$Vi$\mid$)', 'fontsize', 14, ...
    'Interpreter', 'latex');
title('{Decibels vs. Frequency}', ...
    'fontsize', 16, 'Interpreter', 'latex');
legend('Decibel Reading', 'location','northeast');
xlim([min(frequencies{1}) max(frequencies{1})]);

% Creating Figure
figure(2)

% Adding axes
hold on
grid on
grid minor

phaseAngles = angle(Vc) * (180 ./ pi);

plot(frequencies{1}, phaseAngles, 'o-');

% Plot Descriptors
xlabel('{Frequency (Hz)}', 'fontsize', 14, 'Interpreter', 'latex');
ylabel('Phase Angle (Degrees)', 'fontsize', 14, ...
    'Interpreter', 'latex');
title('{Phase Angle vs. Frequency}', ...
    'fontsize', 16, 'Interpreter', 'latex');
legend('Phase Angle', 'location','northeast');
xlim([min(frequencies{1}) max(frequencies{1})]);

%% Displaying Results
for ii = 1: length(Vc)
    
    fprintf('Complex Capacitor voltage for w%d = %e + %ej %s \n', ii, ...
        real(Vc(ii)), imag(Vc(ii)), 'V');
end


%% Magnitude and Phase Angle of Complex Currents & Voltages for Inductor

magnitudeCurrent = abs(current);

magnitudeVoltage = abs(Vc);

angleCurrent = angle(current) * (180 ./ pi);

angleVoltage = angle(Vc) * (180 ./ pi);
