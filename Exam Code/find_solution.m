function [Vout] = find_solution(R1,R2,C1,C2,f,phi,Vp)

    % Calculate frequency omega
    omega = 2*pi*f;

    % Find input voltage in complex form
    Vrms = Vp/sqrt(2);
    Vi   = Vrms*(cos(phi) + 1i*sin(phi));

    % Find the Impedances in the circuit
    Zr1 = R1;
    Zr2 = R2;
    Zc1 = -1i/(omega*C1);
    Zc2 = -1i/(omega*C2);

    % Find the Transmittances in the circuit for nodal analysis
    Yr1 = 1/Zr1;
    Yr2 = 1/Zr2;
    Yc1 = 1/Zc1;
    Yc2 = 1/Zc2;

    % Linear System of Nodal equations
    A = [ (Yr1+Yr2+Yc1) -Yr2 ;...
          -Yr2           (Yc2+Yr2) ];
  
    b = [ Yc1*Vi  ;...
               0 ];
    
    Vnodal = A\b;

    Vn2    = Vnodal(1,1);
    Vn3    = Vnodal(2,1);

    Vout   = Vn3;

    fprintf('Input Signal Frequency    (Hz)  %13.10f \n',f);
    fprintf('Input Signal Peak Voltage (V)   %13.10f \n',Vp);
    fprintf('Input Signal RMS Voltage  (V)   %13.10f \n',Vrms);
    fprintf('Output Voltage Amplitude  (V)   %13.10f \n',abs(Vout));
    fprintf('Output Voltage phase      (rad) %13.10f \n',angle(Vout));
    fprintf('Output Voltage phase      (deg) %13.10f \n',(180/pi)*angle(Vout));
    fprintf('Gain                      (dB) %13.10f \n',20*log10(abs(Vout)/Vrms));

end

