clear; clc
%% Defining Values

% Resistors
R1 = {1, 'kOhm'};
R2 = {2.2, 'kOhm'};
R3 = {3.3, 'kOhm'};
R4 = {4.7, 'kOhm'};
R5 = {5.1, 'kOhm'};

% Voltage Source
Vn1 = {5, 'V'};

%% Nodal Equations

% Defining Symbolic Variables
syms Vn2 Vn3

% Node 2 Equation
node2 = ((Vn2 - Vn1{1}) ./ R2{1} ) + ...
        ((Vn2 - Vn3) ./ R4{1}) + ...
        (Vn2 ./ R3{1}) == 0;

% Node 3 Equation
node3 = ((Vn3 - Vn2) ./ R4{1}) + ...
        ((Vn3 - Vn1{1}) ./ R1{1}) + ...
        (Vn3 ./ R5{1}) == 0;

% Solving System of Equations
[A, b] = equationsToMatrix([node2 node3], [Vn2 Vn3]);

voltages = linsolve(A, b);

Vn2 = {double(voltages(1 ,1)), 'V'};
Vn3 = {double(voltages(2, 1)), 'V'};

voltages = [Vn1; Vn2; Vn3];

% Displaying Results
for ii = 1: length(voltages)
    
    fprintf('Node %d Voltage = %f %s \n', ii ,voltages{ii}, ...
        voltages{ii, 2});
    
end
%% Current Across Resistors

I1 = {(Vn1{1} - Vn3{1}) ./ R1{1}, 'mA'};
I2 = {(Vn1{1} - Vn2{1}) ./ R2{1}, 'mA'};
I3 = {Vn2{1} ./ R3{1}, 'mA'};
I4 = {(Vn2{1} - Vn3{1}) ./ R4{1}, 'mA'};
I5 = {-Vn3{1} ./ R5{1}, 'mA'};

currents = [I1; I2; I3; I4; I5;];

%Displaying Results
for ii = 1:length(currents)
    
    fprintf('Current Through R%d = %f %s \n', ii, currents{ii}, ...
        currents{ii, 2});
end

%% Voltages Across Resistors
VR1 = {Vn1{1} - Vn3{1}, 'V'};
VR2 = {Vn1{1} - Vn2{1}, 'V'};
VR3 = {Vn2{1}, 'V'};
VR4 = {Vn2{1} - Vn3{1}, 'V'};
VR5 = {-Vn3{1}, 'V'};

resistorVoltages = [VR1; VR2; VR3; VR4; VR5];

% Displaying Results
for ii = 1:length(resistorVoltages)
    
    fprintf('Voltage Across R%d = %f %s \n', ii, resistorVoltages{ii}, ...
        resistorVoltages{ii, 2});
    
end




