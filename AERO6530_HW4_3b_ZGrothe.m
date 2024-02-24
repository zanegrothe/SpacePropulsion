% Zane Grothe
% AERO 6530
% HW 4
% 3/14/22

clear all
close all
clc

% Problem 3 ~~~~~~~~~~~~~~~~~~~~
% Part b) [Converted to metric units]


% Givens

a=0.05*0.0254/6894.757; % Burn rate coefficient (m/s/Pa^n)
%       THIS DOES NOT CONVERT WELL

cstar=5343*0.3048; % Characteristic velocity (m/s)
rhob=0.064*1728/0.062428; % Propellant density (kg/m^3)
T0=6260/1.8; % Chamber temperature (Kelvin)
MW=25.3; % Molecular weight (kg/kmol)
gam=1.24; % Specific heat ratio
Dt=5*0.0254; % Throat diameter (m)
Di=8*0.0254; % Grain initial diameter (m)
Dc=16*0.0254; % Grain outer diameter (m)
L=60*0.0254; % Grain length (m)
Me=2.5; % Exit Mach number

pa=101325; % Atmospheric pressure (Pa)
g=9.81; % Mass conversion (m/s)
Ru=8314; % Universal gas constant (J/kmol-K)


nm=[0.3,0.33,0.4,0.5,0.55,0.6]; % Burn rate exponent matrix


% Calculations

At=pi*Dt^2/4; % Throat area (m^2)
Abi=pi*Di*L; % Initial burn area (m^2)
Abf=pi*Dc*L; % Final burn area (m^2)

x=1; % Counter
while x < 7
    n=nm(1,x);  % Use the counter to pull n value
    
    K1=2*pi*L*a*(a*cstar*rhob/At)^(n/(1-n));
    K2=K1*(2*n-1)/(n-1);
    
    if n == 0.5
        tf=log(Abf/Abi)/K1; % Burnout time for special case of n=0.5 (s)
    else
        tf=(Abf^((2*n-1)/(n-1))-Abi^((2*n-1)/(n-1)))/K2; % Burnout time (s)
    end
    
    t=linspace(0,tf); % Burn time (s)
    
    if n == 0.5
        Ab=Abi*exp(K1*t); % Burn area for special case of n=0.5 (m^2)
    else
        Ab=(K2*t+Abi^((2*n-1)/(n-1))).^((n-1)/(2*n-1)); % Burn area (m^2)
    end
    
    p0=(a*rhob*cstar*Ab/At).^(1/(1-n)); % Chamber pressure (Pa)
    mdot=p0*At/cstar; % Mass flow rate (kg/s)
    Te=T0/(1+(gam-1)*Me/2); % Exit temperature (Kelvin)
    ue=Me*sqrt(gam*Te*Ru/MW); % Exhaust velocity (m/s)
    Ae=At/Me*(2/(gam+1)*((1+(gam-1)/2*Me^2)))^((gam+1)/2/(gam-1)); % Exit area (m^2)
    pe=p0/(1+(gam-1)*Me/2)^(gam/(gam-1)); % Exit pressure (Pa)
    Ft=mdot*ue+Ae*(pe-pa); % Thrust (N)
    Isp=Ft./mdot/g; % Specific impulse (s)
    
    % Collect data into rows (subscript m denotes a matrix of the values)
    if x == 1
        Abm=Ab;
        p0m=p0;
        Ftm=Ft;
        Ispm=Isp;
        tm=t;
    else
        Abm=[Abm;Ab];
        p0m=[p0m;p0];
        Ftm=[Ftm;Ft];
        Ispm=[Ispm;Isp];
        tm=[tm;t];
    end
    
    x=x+1; % Increase counter
end
% Corrections because (a) is imperical and doesn't convert!
Ftm=abs(Ftm);
Ispm=-Ispm/200;

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
ylabel('Burn Area (m^2)')
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
ylabel('Chamber Pressure (Pa)')
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
ylabel('Thrust (N)')
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

