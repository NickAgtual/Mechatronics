close all
f = [20 40 60 70 80 100 200 300 400 500 1000 5000 ...
    10000 20000 30000 31000 32000 33000 33500 ...
    34000 35000 40000];

omega = f * (2 * pi);

% Circuit Parameters
R1 = 22e3;
R2 = 10e3;
C1 = 0.1e-6;
C2 = 0.47e-9;

% Input Parameters
Vp  = 3;    % Peak Voltage
phi = 0;    % Signal phase in radians


% Find input voltage in complex form
Vrms = Vp/sqrt(2);
Vi   = Vrms*(cos(phi) + 1i*sin(phi));

% Find the Impedances in the circuit
Zr1 = R1;
Zr2 = R2;
Zc1 = -1i./(omega*C1);
Zc2 = -1i./(omega*C2);

% Find the Transmittances in the circuit for nodal analysis
Yr1 = 1./Zr1;
Yr2 = 1./Zr2;
Yc1 = 1./Zc1;
Yc2 = 1./Zc2;

Vn2 = zeros(1, length(omega));
Vn3 = zeros(1, length(omega));
Vout = zeros(1, length(omega));
for ii = 1:length(omega)

% Linear System of Nodal equations
A = [ (Yr1+Yr2+Yc1(ii)) -Yr2 ;...
    -Yr2           (Yc2(ii)+Yr2) ];

b = [ Yc1(ii)*Vi  ;...
    0 ];

Vnodal = A\b;

Vn2(ii)    = Vnodal(1,1);
Vn3(ii)    = Vnodal(2,1);

Vout(ii)   = Vn3(ii);

end

%% Phase Angle
phaseAngleVoltageRAD = zeros(1, length(omega));
phaseAngleVoltageDEG = zeros(1, length(omega));

for ii = 1:length(omega)
    
phaseAngleVoltageRAD(ii) = angle(Vout(ii));
phaseAngleVoltageDEG(ii) = angle(Vout(ii)) * (180 / pi);

end

%% Gain

gain = zeros(1, length(omega));

for ii = 1:length(omega)
    
    gain(ii) = 20 * log10(abs(Vout(ii)) ./ Vi);
    
end

%% Cap current

Ic2 = zeros(1, length(omega));

for ii = 1:length(omega)
    
Ic2 = Vout(ii) ./ Zc2;

end


%% Plots

figure(1)
semilogx(f, gain)
hold on
grid on
grid minor
semilogx(f, ones(1, length(f)) * Vi)
legend('Gain', 'Vin')
title('Gains vs Frequency')
xlim([-1 * 10^4, 4.5 * 10^4])


figure(2)

semilogx(f, phaseAngleVoltageRAD)
hold on
grid on
grid minor
title('Phase Angel (RAD) vs Frequency')

figure(3)
semilogx(f, abs(Vout))
hold on
plot(f, abs(Ic2))
legend('Vout', 'IC2')
grid on
grid minor
xlim([-.25 * 10^4, 4.5 * 10^4]);
title('Vout & IC2 vs Frequency')
