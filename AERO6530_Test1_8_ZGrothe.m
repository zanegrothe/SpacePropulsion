% Zane Grothe
% AERO 6530
% Test 1
% 3/21/22

clear all
close all
clc

% Problem 8 ~~~~~~~~~~~~~~~~~~~~

% Givens

% Design Parameters
Rp=1.5; % (in)
f=0.5; % (in)
ep=0.9;
N=9;

Ftg=10000; % (lbf)
pa=0; % (psia)
AreaR=10;

% Propellant Parameters
a=0.0563; % (in/s/psi^n)
n=0.33;
cstar=5343; % (ft/s)
rho=0.064; % (lbm/in^3)
T0=6260; % (Rankine)
MW=25.3; % (lbm/lbm-R)
gam=1.24;

p0i=[500;1000;1500]; % (psia)


% Calculations

% Independent
pen=pi*ep/N;
H=Rp*sin(pen);

% Calculate Ri for neutral Phase I burn
syms Rii
THo2i=atan(H*tan(pen)/(H-Rii*tan(pen)));
coef=pi/2-THo2i+pi/N-cot(THo2i)==0;
Ri=double(solve(coef,Rii));

THo2=atan(H*tan(pen)/(H-Ri*tan(pen)));
beta=(pi/2-THo2+pen);
y0=H/cos(THo2);


% Giant loop to make all calculations for each p0
z=1; % Counter
while z < 4
    p0=p0i(z,1);
    
    syms M % Find exit Mach number
    AR=(1/M)*(2/(gam+1)*(1+(gam-1)/2*M^2))^((gam+1)/2/(gam-1))==10;
    Me=double(solve(AR,M));
    pe=p0/(1+(gam-1)/2*Me^2)^(gam/(gam-1)); % Calculate pe from Me (psia)
    
    U=(2*(gam^2)/(gam-1));
    V=((2/(gam+1))^((gam+1)/(gam-1)));
    W=(1-((pe/p0)^((gam-1)/gam)));
    Cf=sqrt(U*V*W)+AreaR*(pe/p0-pa/p0); % Calculate Cf
    
    At=Ftg/p0/Cf; % Throat area (in^2)
    
    Abi=At*p0^(1-n)*32.2/a/rho/cstar; % Initial burn area (in^2)
    
    S1i=H/sin(THo2)-(0+f)*cot(THo2);
    S2i=(0+f)*beta;
    S3i=(Rp+0+f)*(pi/N-pen);
    Si=2*N*(S1i+S2i+S3i);
    L=Abi/Si; % Calculate grain length from burn area geometry (in)
    Do=L/5; % Outer grain diameter (in)
    Ro=Do/2; % Outer grain radius (in)
    % Compile
    if z == 1
        Atm=At;
        Rim=Ri;
        Lm=L;
        Dom=Do;
        Rom=Ro;
        Cfm=Cf;
    else
        Atm=[Atm;At]; %#ok<AGROW>
        Rim=[Rim;Ri]; %#ok<AGROW>
        Lm=[Lm;L];    %#ok<AGROW>
        Dom=[Dom;Do]; %#ok<AGROW>
        Rom=[Rom;Ro]; %#ok<AGROW>
        Cfm=[Cfm;Cf]; %#ok<AGROW>
    end
    
    web1=y0-f; % (in)
    r1=a*p0^n; % Phase I burn rate (in/sec/psi^n)
    t1=web1/r1; % Phase I burn time (s)
    tb=t1; % Set total burn time as Phase I burn time for now
    
    WEB=Ro-Rp-f; % (in)
    y=WEB/100; % step size
    
    % Phase II
    k=1; % Counter
    while y+f <= WEB+f
        psi=atan(sqrt((y+f)^2-H^2)/H)-THo2;
        S2=(y+f)*(beta-psi');
        S3=(Rp+y+f)*(pi/N-pen);
        S=2*N*(S2+S3);
        Ab=S*L; % Calculate burn area as function of y (in^2)
        p0s2=((Ab/At)*a*rho*cstar/32.2)^(1/(1-n)); % p0 step Phase II (psia)
        % Compile
        if k == 1
            p0m2=p0s2;
        elseif k == 100 
            break % make them all the same size
        else
            p0m2=[p0m2,p0s2]; % Continue adding to p0 matrix
        end
        r2s=a*p0s2^n; % Burnrate at web step
        t2s=WEB/100/r2s; % Phase II time step
        tb=tb+t2s; % Continue adding to total burn time
        y=y+WEB/100;
        k=k+1;
    end
    Ft=p0m2*At*Cf; % Phase II Thrust (lbf)
    t=linspace(t1,tb,99); % Phase II burn time step (s)
    % Compile
    if z == 1
        p0m=p0m2;
        tbm=tb;
        Ftm=Ft;
        tm=t;
    else
        p0m=[p0m;p0m2]; %#ok<AGROW>
        tbm=[tbm;tb];   %#ok<AGROW>
        Ftm=[Ftm;Ft];   %#ok<AGROW>
        tm=[tm;t];      %#ok<AGROW>
    end
    z=z+1; % Next pressure
end

t1p=linspace(0,t1,10); % Phase I burn time step (s)

% Plot Thrust vs. Time
for b=1:3
    figure(b)
    plot(tm(b,:),Ftm(b,:))
    hold on
    plot(t1p,Ftg)
    xlim([0,max(tm(b,:))*1.3])
    ylim([0,max(Ftm(b,:))*1.3])
    xlabel('Burn Time (s)')
    ylabel('Thrust (lbf)')
    title(sprintf('Neutral Star (Phase I), Thrust vs. Time (for p0 of %.f psia)',p0i(b,1)))
    plot(t1,Ftm(b,:))
    text(t1-.5,max(Ftm(b,:))*1.05,'End of Phase I')
    plot(max(tm(b,:)),Ftm(b,:))
    text(max(tm(b,:))-.5,min(Ftm(b,:))*.95,'End of Burn')
    hold off
end

% Results
for c=1:3
    disp(sprintf('For p0 = %.f psia',p0i(c,1)))
    disp(sprintf('Ri              = %.3f in',Rim(c,1)))
    disp(sprintf('Rp              = %.1f in',Rp))
    disp(sprintf('Grain diameter  = %.3f in',Dom(c,1)))
    disp(sprintf('Grain length    = %.3f in',Lm(c,1)))
    disp(sprintf('Throat area     = %.3f in^2',Atm(c,1)))
    disp(' ')
end

