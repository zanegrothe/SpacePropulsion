% Zane Grothe
% AERO 6530
% HW 2
% 1/31/22

clear all
close all
clc

% Problem 4

% Part a --------------------

% Define givens, keep units consistent
gam=1.4;
Ru=8314; % J/kmol/K
g=9.81; % m/s^2

AreaR=100; % ~~ASSUMPTION~~
MWH=1; % kg/kmol
MWH2=2; % kg/kmol
T0H=linspace(2000,6000); % Kelvin
T0H2=linspace(300,6000); % Kelvin

% Calculate Me from Area Ratio
syms M
eq1=(1/M)*(2/(gam+1)*(1+(gam-1)/2*M^2))^((gam+1)/(gam-1)/2)-AreaR;
f=vpasolve(eq1,M);
Me=double(f(2,1));

% Calculate Te from Me and T0
TeH=T0H/(1+(gam-1)/2*Me.^2);
TeH2=T0H2/(1+(gam-1)/2*Me.^2);

% Calculate ue from Me and Te
ueH=Me*sqrt(gam*Ru/MWH*TeH);
ueH2=Me*sqrt(gam*Ru/MWH2*TeH2);

% Calculate Isp from ue
IspH=ueH/g;
IspH2=ueH2/g;

% Resize matrices
T0_HsizeLow=find(T0H < 3000); % find elements with temps less than 4000
T0_HLow=T0H(1,1:max(T0_HsizeLow)); % isolate temps for H low end
Isp_HLow=IspH(1,1:max(T0_HsizeLow)); % isolate Isp's for H low end

T0_HsizeHigh=find(T0H > 3000); % find elements with temps greater than 4000
T0_HHigh=T0H(1,min(T0_HsizeHigh):end); % isolate temps for H high end
Isp_HHigh=IspH(1,min(T0_HsizeHigh):end); % isolate Isp's for H high end

T0_H2sizeLow=find(T0H2 < 4000); % find elements with temps less than 3000
T0_H2Low=T0H2(1,1:max(T0_H2sizeLow)); % isolate temps for H2 low end
Isp_H2Low=IspH2(1,1:max(T0_H2sizeLow)); % isolate Isp's for H2 low end

T0_H2sizeHigh=find(T0H2 > 4000); % find elements with temps less than 3000
T0_H2High=T0H2(1,min(T0_H2sizeHigh):end); % isolate temps for H2 high end
Isp_H2High=IspH2(1,min(T0_H2sizeHigh):end); % isolate Isp's for H2 high end

% Plot Isp's for HHigh, HLow, H2High, H2Low
figure(1)
plot(T0_HLow,Isp_HLow,'Color','r','LineStyle','--')
hold on
plot(T0_HHigh,Isp_HHigh,'Color','c','LineStyle','-')
plot(T0_H2Low,Isp_H2Low,'Color','b','LineStyle','-')
plot(T0_H2High,Isp_H2High,'Color','g','LineStyle','--')
hold off
legend({'H low','H high','H2 low','H2 high'},'Location','southeast')
xlabel('Chamber Temperature (Kelvin)')
ylabel('Specific Impulse (seconds)')
title('T0 vs. Isp')


% Part b --------------------

% Define givens, keep units consistent
p0=100; % bar ~~ASSUMPTION~~
AreaR=logspace(0,3);

k=1;
while k<51
    % Calculating exit Mach number from Area Ratio
    syms M
    eq1=(1/M^2)*(2/(gam+1)*(1+(gam-1)/2*M^2))^((gam+1)/(gam-1))-AreaR(1,k)^2;
    f=vpasolve(eq1,M);
    Me=double(f(4,1));
    pe=p0/(1+(gam-1)/2*Me^2)^(gam/(gam-1)); % Calc pe from Me
    % Compile
    if k==1
        pem=pe;
        mem=Me;
    else
        pem=[pem,pe];
        mem=[mem,Me];
    end
    k=k+1;
end

% Calculate Cf
U=(2*(gam^2)/(gam-1));
V=((2/(gam+1))^((gam+1)/(gam-1)));
W=(1-((pem/p0).^((gam-1)/gam)));
Cf=sqrt(U*V*W); % Calc Cf

% Plot loop using Cfm rows on 1 plot
figure(2)
semilogx(AreaR,Cf)
xlim([1,1000])
ylim([0,2])
grid on
xlabel('Area Ratio')
ylabel('Thrust Coefficient')
title('Ae/At vs. Cf')


