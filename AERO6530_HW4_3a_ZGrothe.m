% Zane Grothe
% AERO 6530
% HW 4
% 3/14/22

clear all
close all
clc

% Problem 3 ~~~~~~~~~~~~~~~~~~~~
% Part a) [English units]


% Givens

a=0.05; % Burn rate coefficient (in/s/psi^n)
cstar=5343; % Characteristic velocity (ft/s)
rhob=0.064; % Propellant density (lbm/in^3)
T0=6260; % Chamber temperature (Rankine)
MW=25.3; % Molecular weight (lbm/lbm-mol)
gam=1.24; % Specific heat ratio
Dt=5; % Throat diameter (in)
Di=8; % Grain initial diameter (in)
Dc=16; % Grain outer diameter (in)
L=60; % Grain length (in)
Me=2.5; % Exit Mach number

pa=14.7; % Atmospheric pressure (psia)
g=32.17; % Mass conversion (lbm/slug)
Ru=1545.43; % Universal gas constant (ft-lbf/lbm-mol-R)


nm=[0.3,0.33,0.4,0.5,0.55,0.6]; % Burn rate exponent matrix


% Calculations

At=pi*Dt^2/4; % Throat area (in^2)
Abi=pi*Di*L; % Initial burn area (in^2)
Abf=pi*Dc*L; % Final burn area (in^2)

x=1; % Counter
while x < 7
    n=nm(1,x); % Use the counter to pull n value
    
    K1=2*pi*L*a*(a*cstar*rhob/At/g)^(n/(1-n));
    K2=K1*(2*n-1)/(n-1);
    
    if n == 0.5
        tf=log(Abf/Abi)/K1; % Burnout time for special case of n=0.5 (s)
    else
        tf=(Abf^((2*n-1)/(n-1))-Abi^((2*n-1)/(n-1)))/K2; % Burnout time (s)
    end
    
    t=linspace(0,tf); % Burn time (s)
    
    if n == 0.5
        Ab=Abi*exp(K1*t); % Burn area for special case of n=0.5 (in^2)
    else
        Ab=(K2*t+Abi^((2*n-1)/(n-1))).^((n-1)/(2*n-1)); % Burn area (in^2)
    end
    
    p0=(a*rhob*cstar*Ab/At/g).^(1/(1-n)); % Chamber pressure (psia)
    mdot=p0*At/cstar; % Mass flow rate (slug/s)
    Te=T0/(1+(gam-1)*Me/2); % Exit temperature (Rankine)
    ue=Me*sqrt(gam*Te*g*Ru/MW); % Exhaust velocity (ft/s)
    Ae=At/Me*(2/(gam+1)*((1+(gam-1)/2*Me^2)))^((gam+1)/2/(gam-1)); % Exit area (in^2)
    pe=p0/(1+(gam-1)*Me/2)^(gam/(gam-1)); % Exit pressure (psia)
    Ft=mdot*ue+Ae*(pe-pa); % Thrust (lbf)
    Isp=Ft./mdot/g; % Specific impulse (s)
    
    % Collect data into rows (subscript m denotes a matrix of the values)
    if x == 1
        Abm=Ab/144; % Converting burn area to ft
        p0m=p0;
        Ftm=Ft;
        Ispm=Isp;
        tm=t;
    else
        Abm=[Abm;Ab/144]; % Converting burn area to ft
        p0m=[p0m;p0];
        Ftm=[Ftm;Ft];
        Ispm=[Ispm;Isp];
        tm=[tm;t];
    end
    
    x=x+1; % Increase counter
end


% Plot loop using data matrices' rows on 1 plot each

C=[1,0,0;0,1,0;0,0,1;0,1,1;1,0,1;0,0,0]; % Color matrix to pick from

% Burn Area
for b=1:6
    figure(1)
    plot(tm(b,:),Abm(b,:),'color',C(b,:))
    hold on
end
hold off
xlim([0,max(tm(:))])
ylim([min(Abm(:))*0.95,max(Abm(:))*1.05])
xlabel('Burn Time')
ylabel('Burn Area (ft^2)')
title('Burn Area vs. Time')
legend({'n=0.3','0.33','0.4','0.5','0.55','0.6'},'Location','southeast')

% Chamber Pressure
for b=1:6
    figure(2)
    plot(tm(b,:),p0m(b,:),'color',C(b,:))
    hold on
end
hold off
xlim([0,max(tm(:))])
ylim([0,max(p0m(:))])
xlabel('Burn Time')
ylabel('Chamber Pressure (psia)')
title('Chamber Pressure vs. Time')
legend('n=0.3','0.33','0.4','0.5','0.55','0.6')

% Thrust
for b=1:6
    figure(3)
    plot(tm(b,:),Ftm(b,:),'color',C(b,:))
    hold on
end
hold off
xlim([0,max(tm(:))])
ylim([0,max(Ftm(:))])
xlabel('Burn Time')
ylabel('Thrust (lbf)')
title('Thrust vs. Time')
legend('n=0.3','0.33','0.4','0.5','0.55','0.6')

% Specific Impulse
for b=1:6
    figure(4)
    plot(tm(b,:),Ispm(b,:),'color',C(b,:))
    hold on
end
hold off
xlim([0,max(tm(:))])
ylim([min(Ispm(:))*0.95,max(Ispm(:))*1.05])
xlabel('Burn Time')
ylabel('Specific Impulse (s)')
title('Specific Impulse vs. Time')
legend('n=0.3','0.33','0.4','0.5','0.55','0.6')

