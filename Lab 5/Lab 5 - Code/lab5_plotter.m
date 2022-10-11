close all;
%% SECTION 1
% Initialize a results matrix
results = zeros(2,8);

%% SECTION 2
% OPEN the Matrix and paste the data

% Separate the result columns
current_error  = results(:,1);
previous_error = results(:,2);
integral       = results(:,3);
derivative     = results(:,4);
PWM            = results(:,5);
dt             = results(:,6);
pos_servo      = results(:,7);
pos_input      = results(:,8);


% Create the time vector
time    = zeros(size(dt));
time(1) = dt(1);
for i = 2:length(dt)
    time(i) = time(i-1) + dt(i);    
end


plot(time,pos_input,time,pos_servo); axis tight; grid; grid minor;
xlabel('Time'); ylabel('Servo');
legend('Input','Servo');

%% SECTION 3
my_filename = 'Derivative5';

save( strcat( my_filename , '.mat' ) ,'results');

%% SECTION 4
% SYSTEM Identification
input   = pos_input;
output = pos_servo;
dtmean  = mean(dt);

data    = iddata(output,input,dtmean);
g       = tfest(data,2,0);

