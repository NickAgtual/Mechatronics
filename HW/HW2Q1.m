close all; clear; clc;
%% Given Parameters

% Resistance 1 [ohms]
R1 = 100000;
% Resistance 2 [Ohms]
R2 = 100000;

% Inductance [Henrys]
L = 4.7e-3;

% Capacitance [Farads]
C = .001e-9;

% Conductace [1 / Ohms]
% G = 1 / R
G1 = 1 / R1;
G2 = 1 / R2;

%% Transfer Function

% as^2 + bs + c = 0
% Normalizing the polynomial: s^2 + (b/a)s + (c/a) = 0
a = (G1 + G2);
b = ((G1 * G2 * L) + C) / (L * C);
c = G2 / (L * C);

% Numerator of tranfer function
numerator = [(G1 * G2 ) / C, 0];

% Denominator of transfer function
denominator = [a, b, c];

% Constructing transfer function
Gs = tf(numerator, denominator);

% Creating new figure
figure(1)

% Ploting the step responce of the system
step(Gs);

% Plot parameters
hold on
grid on
grid minor

% Plot descriptors
xlabel('{\emph Time}','fontsize',14,'Interpreter','latex');
ylabel('{\emph Aplitude }','fontsize',14,'Interpreter','latex');
title('{Step Response}','fontsize',16,'Interpreter','latex');
legend('Output', 'fontsize', 10, 'Interpreter', 'latex');
   

%% Characteristic Parameters

% Natural frequency [Hz]
wn = sqrt(c/a);

% x = 2 * zeta * wn
x = b / a;

% Daming ratio
zeta = x / (2 * wn);

%% System Response

% Solving for roots of characteristic polynomial 
characteristicRoots = roots(denominator);

% Creating new figure
figure(2)

pzplot(Gs)
hold on
grid on

% Plot descriptors
set(gca, 'fontName', 'Times');
xlabel('\sigma Real Axis', 'fontName', 'Times', 'fontSize', 14);
ylabel('j\omega_{n} Imaginary Axis', 'fontName', 'Times', 'fontSize', 14);
title('{Pole-Zero Map}','fontsize',16,'Interpreter','latex');
