clear; clc
%% Given Values

% Frequencies
frequencies = {[3671 5506 7341.27 14683 18353], 'Hz'};

% Resistor
R = {1, 'kOhm'};

% Capacitor
C = {.1, 'uF'};

% Inductor
L = {4.7, 'mH'};

%% Calculations

% Converting frequencies to rad/s
w = {frequencies{1} .* 2 .* pi, 'rad/s'};

% Inductor equivalent impedance
Zl = {1i .* w{1} .* L{1} .* 10^-3, 'Ohms'};

% Capacitor equivalne impedance
Zc = {-1i ./ (w{1} .* (C{1} .* 10^-6)), 'Ohms'};

% Complex Voltage (RMS)
ViComplex = (sqrt(2) ./ 2 ) * exp(1i);

%% KVL( Finding Current)

% Defining Symbolic Variable
syms I

% Creating Empty current array
current = {zeros(1, length(Zc{1})), 'A'};


for ii = 1: length(Zc{1})
    
    kvl = ViComplex - I * (Zc{1}(ii) + Zl{1}(ii) + (R{1} * 1000)) == 0;
    
    current{1}(ii) = double(solve(kvl, I));
    
end

%% Complex Inductor Voltage

% Creating empty complex inductor array
Vl = {zeros(1, length(Zl{1})), 'V'};
    
for ii = 1:length(Zl{1})
    
    Vl{1}(ii) = current{1}(ii) .* Zl{1}(ii);

end

%% Displaying Results

for ii = 1:length(current{1})
    
    fprintf('Complex Inductor Current for w%d = %e + %ej %s \n', ii, ...
        real(current{1}(ii)), imag(current{1}(ii)), current{2});
    
    fprintf('Complex Inductor Voltage w%d = %e + %ej %s \n', ii, ...
        real(Vl{1}(ii)), imag(Vl{1}(ii)), Vl{2});
    
end

%% Magnitude and Phase Angle of Complex Currents & Voltages for Inductor

magnitudeCurrent = abs(current{1});

magnitudeVoltage = abs(Vl{1});

angleCurrent = angle(current{1}) * (180 ./ pi);

angleVoltage = angle(Vl{1}) * (180 ./ pi);




