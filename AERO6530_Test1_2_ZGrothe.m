% Zane Grothe
% AERO 6530
% Test 1
% 3/21/22

clear all
close all
clc

% Problem 2 ~~~~~~~~~~~~~~~~~~~~


% Givens

a=0.06; % Burn rate coefficient (in/s/psi^n)
n=0.37; % Burn rate exponent
cstar=5500; % Characteristic velocity (ft/s)
rhob=0.064; % Propellant density (lbm/in^3)
T0=6260; % Chamber temperature (Rankine)
MW=25.3; % Molecular weight (lbm/lbm-mol)
gam=1.24; % Specific heat ratio
Dt=4; % Throat diameter (in)
Di=7; % Grain initial diameter (in)
Do=15; % Grain outer diameter (in)
De=Do; % Nozzle is embedded (in)
L=50; % Grain length (in)

% Constants

pa=14.7; % Atmospheric pressure (psia)
g=32.17; % Mass conversion (lbm/slug)
Ru=1545.43; % Universal gas constant (ft-lbf/lbm-mol-R)


% Calculations

AreaR=(De/Dt)^2; % Area ratio
syms M
AA=(1/M)*(2/(gam+1)*((1+(gam-1)/2*M^2)))^((gam+1)/2/(gam-1))==AreaR;
Me=double(solve(AA,M)); % exit Mach number

At=pi*Dt^2/4; % Throat area (in^2)
Abi=pi*Di*L; % Initial burn area (in^2)
Abf=pi*Do*L; % Final burn area (in^2)

% Constants
K1=2*pi*L*a*(a*cstar*rhob/At/g)^(n/(1-n));
K2=K1*(2*n-1)/(n-1);

tf=(Abf^((2*n-1)/(n-1))-Abi^((2*n-1)/(n-1)))/K2; % Burnout time (s)
t=linspace(0,tf); % Burn time (s)
    
Ab=(K2*t+Abi^((2*n-1)/(n-1))).^((n-1)/(2*n-1)); % Burn area (in^2)

p0=(a*rhob*cstar*Ab/At/g).^(1/(1-n)); % Chamber pressure (psia)
mdot=p0*At/cstar; % Mass flow rate (slug/s)
Te=T0/(1+(gam-1)*Me/2); % Exit temperature (Rankine)
ue=Me*sqrt(gam*Te*g*Ru/MW); % Exhaust velocity (ft/s)
Ae=At/Me*(2/(gam+1)*((1+(gam-1)/2*Me^2)))^((gam+1)/2/(gam-1)); % Exit area (in^2)
pe=p0/(1+(gam-1)*Me/2)^(gam/(gam-1)); % Exit pressure (psia)
Ft=mdot*ue+Ae*(pe-pa); % Thrust (lbf)
Isp=Ft./mdot/g; % Specific impulse (s)


% Plots

% Burn Area
Ab=Ab/144; % Convert to feet
figure(1)
plot(t,Ab)
xlim([0,max(t(:))+1])
ylim([min(Ab(:))*0.95,max(Ab(:))*1.05])
xlabel('Burn Time')
ylabel('Burn Area (ft^2)')
title('Burn Area vs. Time')

% Chamber Pressure
figure(2)
plot(t,p0)
xlim([0,max(t(:))+1])
ylim([0,max(p0(:))*1.1])
xlabel('Burn Time')
ylabel('Chamber Pressure (psia)')
title('Chamber Pressure vs. Time')

% Thrust
figure(3)
plot(t,Ft)
xlim([0,max(t(:))+1])
ylim([0,max(Ft(:))*1.1])
xlabel('Burn Time')
ylabel('Thrust (lbf)')
title('Thrust vs. Time')

% Specific Impulse
figure(4)
plot(t,Isp)
xlim([0,max(t(:))+1])
ylim([min(Isp(:))*0.99,max(Isp(:))*1.01])
xlabel('Burn Time')
ylabel('Specific Impulse (s)')
title('Specific Impulse vs. Time')


% Pressure drop calulation

GAM=sqrt(Ru/MW*T0*g)/cstar;
Aporti=pi*Di^2/4; % initial port area
J=At/Aporti;
p2_p0 = 1-(GAM^2*J^2)/2;
p1_p2 = 1+gam/(gam-1)*(sqrt(1+2*(gam-1)/gam*(GAM*J/p2_p0)^2)-1);
p2 = p2_p0*p0(1,1); % pressure at aft end
p1 = p1_p2*p2; % pressure at head end
delta_p = p1-p2; % Pressure drop
disp(sprintf('Pressure drop is %.2f psia',delta_p))



