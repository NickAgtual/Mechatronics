close all; clear; clc

% LED Values
LED(1).Color = 'RED';
LED(1).FWDcurrent = {[20 * 10 ^ -3, 1] 'A'};
LED(1).FWDvoltage = {[2 3] 'V'};

LED(2).Color = 'GREEN';
LED(2).FWDcurrent = {[30 * 10 ^ -3, 1] 'A'};
LED(2).FWDvoltage = {[2 3] 'V'};

Vout = {5 'V'};
Vc = {5 'V'};
Ileak = {1 * 10 ^ -3 'A'};


%% Solving for resistances R2 & R3

% Initializing arry
R = zeros(length(LED(1).FWDcurrent), ...
    length(LED(1).FWDvoltage), ...
    length(LED));
% R(:,:,1) = R2
% R(:,:,2) = R3

for ii = 1:length(LED)
    for jj = 1:length(LED(1).FWDcurrent{1})
        for kk = 1:length(LED(1).FWDvoltage{1})
            
            R(jj, kk, ii) = (Vout{1} - LED(ii).FWDvoltage{1}(kk)) / ...
                LED(ii).FWDcurrent{1}(jj);
           
        end
    end
end

%% Solving for pull-down resistance (R4 & R5)

RpullDown = {(.3 * Vc{1}) / Ileak{1} 'Ohms'};

