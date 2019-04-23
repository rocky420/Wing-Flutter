% Sruti Vutukury, Aaron Brown 
% MAE 2030, Spring 2019, Extra Credit Project
% Cornell University
%
% Dynamic Aeroelasticity
clear; clc;
%% Inputs
p.L = 1; p.m = 1; p.Kh = 1; p.Ka = 1; p.Ch = 1; p.Ca = 1;
p.My = 1; p.Ia = 1;

%% Solve
tstart = 0; tend = 12; npointspers = 100;                     
ntimes = tend*npointspers+1; % total number of time points
t = linspace(tstart,tend,ntimes);

h0 = 0; hd0 = 0; al0 = 0; ald0 = 0;
z0 = [h0;hd0;al0;ald0];

% ODE45
small = 1e-7; 
options = odeset('RelTol', small, 'AbsTol', small);
f = @(t,z) SimpleFlutterRHS(t,z,p);
[t,z] = ode45(f, t, z0, options);

h = z(:,1); hd = z(:,2); al = z(:,3); ald = z(:,4);

%% Plot
figure();
subplot(3,1,1);
plot(t,h);
title('h(t)'); xlabel('t'); ylabel('h');

subplot(3,1,2);
plot(t,al);
title('alpha(t)'); xlabel('t'); ylabel('alpha');

subplot(3,1,3);
plot(al,h);
title('h vs alpha'); xlabel('alpha'); ylabel('h');
%% Simple Flutter RHS Function
function zdot = SimpleFlutterRHS(t,z,p)
m = p.m; Kh = p.Kh; Ch = p.Ch; L = p.L;
My = p.My; Ka = p.Ka; Ca = p.Ca; Ia = p.Ia;

h = z(1); hd = z(2);
al = z(3); ald = z(4);

hdd = (-1/m)*(Kh*h+Ch*hd+L);
aldd = (1/Ia)*(My-Ka*al-Ca*ald);

zdot = [hd;hdd;ald;aldd];
end

