% Zane Grothe
% AERO 6530
% HW 4
% 3/14/22

clear all
close all
clc

% Problem 6 ~~~~~~~~~~~~~~~~~~~~

% Givens

% Design Parameters
Ro=5; % (in)
Rp=2.8; % (in)
f=0.5; % (in)
ep=0.9;
N=7;
L=24; % (in)

% Propellant Parameters
a=0.00475; % (in/s/psi^n)
n=0.6;
cstar=3803; % (ft/s)
rho=0.063; % (lbm/in^3)
T0=2759; % (Rankine)
MW=21.8; % (lbm/lbm-R)
gam=1.26;


% Part a) ------------------------------------
% Determine Ri such that phase I is neutral

% Independent
pen=pi*ep/N;
H=Rp*sin(pen);

% Calculate Ri for neutral Phase I burn
syms Rii
THo2i=atan(H*tan(pen)/(H-Rii*tan(pen)));
coef=pi/2-THo2i+pi/N-cot(THo2i)==0;
Ri=double(solve(coef,Rii));
disp(sprintf('For a neutral Phase I burn Ri is %.2f in',Ri))


% Part b) ------------------------------------
% Determine the throat diameter for a phase I chamber pressure of 700 psi.
p0=700; % (psia)

THo2=atan(H*tan(pen)/(H-Ri*tan(pen)));
beta=(pi/2-THo2+pen);
y0=H/cos(THo2);

% Calculate Throat Area and Diameter
S1i=H/sin(THo2)-(0+f)*cot(THo2);
S2i=(0+f)*beta;
S3i=(Rp+0+f)*(pi/N-pen);
Si=2*N*(S1i+S2i+S3i);
Abi=Si*L;
At=Abi*a*rho*cstar/32.2/p0^(1-n);
Dt=sqrt(4*At/pi);
disp(sprintf('For a Phase I chamber presssure of 700psi Dt is %.2f in',Dt))


% Part c) ------------------------------------
% Determine the burn time for phase I with this value for Ri and throat
% diameter.

web1=y0-f;
r1=a*p0^n;
t1=web1/r1;
disp(sprintf('Burn time for Phase I is %.3f seconds',t1))


% Part d) ------------------------------------
% Plot the pressure-time curve for the full burn. 

WEB=Ro-Rp-f; % Total web thickness
web2=Ro-web1-f-Rp;

% Phase I
y=WEB/100; % Divide Web into 100 steps
while y+f <= y0
    S1=H/sin(THo2)-(y+f)*cot(THo2);
    S2=(y+f)*beta;
    S3=(Rp+y+f)*(pi/N-pen);
    S=2*N*(S1+S2+S3);
    Ab=S*L;
    p0s1=((Ab/At)*a*rho*cstar/32.2)^(1/(1-n)); % p0 step Phase I
    if y == WEB/100
        p0m=p0s1; % p0 matrix
    else
        p0m=[p0m,p0s1];
    end
    y=y+WEB/100;
end

tb=t1; % Total burn time (for now just phase I)

% Phase II
while WEB+f > y+f && y+f > y0
    psi=atan(sqrt((y+f)^2-H^2)/H)-THo2;
    S2=(y+f)*(beta-psi');
    S3=(Rp+y+f)*(pi/N-pen);
    S=2*N*(S2+S3);
    Ab=S*L;
    p0s2=((Ab/At)*a*rho*cstar/32.2)^(1/(1-n)); % p0 step Phase II
    p0m=[p0m,p0s2]; % Continue adding to p0 matrix
    r2s=a*p0s2^n; % Burnrate at web step
    t2s=WEB/100/r2s; % Phase II time step
    tb=tb+t2s; % Continue adding to total burn time
    y=y+WEB/100;
end

% Check loop outputs
size(p0m);
p0m(:,1:10);
range=[min(p0m),max(p0m)];

% Plot Chamber Pressure vs. Time
figure(1)
t=linspace(0,tb);
plot(t,p0m)
hold on
xlim([0,max(tb)*1.3])
ylim([0,max(p0m)*1.3])
xlabel('Burn Time (s)')
ylabel('Chamber Pressure (psi)')
title('d) Neutral Star (Phase I), Chamber Pressure vs. Time')

plot(t1,p0m)
text(t1-.5,max(p0m)*1.05,'End of Phase I')
plot(tb,p0m)
text(tb-.5,min(p0m)*.95,'End of Burn')
hold off


% Part e) ------------------------------------
% Assume that the rocket is designed for operation at 35,000 ft, plot the
% thrust-time curve if the rocket is fired at sea level. 
pe=3.46; % @35,000ft (psia)
pa=14.7; % @sea level (psia)

% Assuming nozzle exit radius is equal to Ro
Re=Ro;
Ae=pi*Re^2; % Nozzle exit area

U=(2*(gam^2)/(gam-1));
V=((2/(gam+1))^((gam+1)/(gam-1)));
W=(1-((pe./p0m).^((gam-1)/gam)));
Cfm=sqrt(U*V*W)+(Ae/At)*(pe./p0m-pa./p0m); % Thrust Coefficient matrix

Ftm=p0m*At.*Cfm; % Thrust matrix

% Plot Thrust vs. Time
figure(2)
plot(t,Ftm)
hold on
xlim([0,max(tb)*1.3])
ylim([0,max(Ftm)*1.3])
xlabel('Burn Time (s)')
ylabel('Thrust (lbf)')
title('e) Neutral Star (Phase I), Thrust vs. Time')

plot(t1,Ftm)
text(t1-.5,max(Ftm)*1.05,'End of Phase I')
plot(tb,Ftm)
text(tb-.5,min(Ftm)*.95,'End of Burn')
hold off


