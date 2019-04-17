%% Inputs/Constants
l = 1; c = 1; S = c*l; % wing span (m); wing chord (m); % wing area (m^2)
e = 0.5; % distance from aerodynamic center to elastic axis (m)

rho = 1.225; % air density
U = 1; % velocity (m/s)
q = (1/2)*rho*U^2;

alpha0 = 0; alphae = 0; % initial AoA (deg); twist due to spring (deg) 
alpha = alpha0 + alphae; % angle of attack (deg)

%% Flat Plate
CLdot = 2*pi; % dCL/dalpha for a flat plate
C_MAC0 = 0; CL0 = 0; % flat plate

CL = CL0 + CLdot*alpha; % coefficient of lift
L = CL*q*S; % lift (N)

C_MAC = C_MAC0;
M_AC = C_MAC*q*S*c; % moment about aerodynamic center

K_alpha = 1; % torsional spring stiffness
My = M_AC + L*e - K_alpha*alphae; % moment about elastic axis or center

% solving for alphae when My = 0 (assuming C_MAC0 = 0 for simplicity)
alphae = (q*S/K_alpha)*(e*CLdot*alpha0)/(1-q*(S*e/K_alpha)*CLdot);

% divergence condition: alphae -> inf as denominator -> 0
% 1-q*(S*e/K_alpha)*CLdot=0