% Zane Grothe
% AERO 6530
% Test 1
% 3/21/22

clear all
close all
clc

% Problem 5 ~~~~~~~~~~~~~~~~~~~~


% Define givens, keep units consistent
gam=1.25;
p0=100; % bar
pap0=[0.1,0.05,0.03,0.01,0.005,0.003,0.001,0.0]; % pa/p0 ratios
pa=pap0*p0; % bar
AreaR=logspace(0,3);

k=1;
while k<51
    % Calculate exit Mach number from Area Ratio
    syms M
    eq1=(1/M^2)*(2/(gam+1)*(1+(gam-1)/2*M^2))^((gam+1)/(gam-1))-AreaR(1,k)^2;
    f=vpasolve(eq1,M);
    Me=double(f(4,1));
    pe=p0/(1+(gam-1)/2*Me^2)^(gam/(gam-1)); % Calculate pe from Me
    % Compile
    if k==1
        pem=pe;
        mem=Me;
    else
        pem=[pem,pe]; %#ok<AGROW>
        mem=[mem,Me]; %#ok<AGROW>
    end
    k=k+1;
end

% Loop for calculating Cf and collecting in a matrix (Cfm)
z=1;
while z<9
    % Set up equation
    U=(2*(gam^2)/(gam-1));
    V=((2/(gam+1))^((gam+1)/(gam-1)));
    W=(1-((pem/p0).^((gam-1)/gam)));
    n=pa(1,z);
    Cf=sqrt(U*V*W)+AreaR.*(pem/p0-n/p0); % Calculate Cf
    % Compile
    if z==1
        Cfm=Cf;
    else
        Cfm=[Cfm;Cf]; %#ok<AGROW>
    end
    z=z+1;
end


% Plot loop using Cfm rows on 1 plot

% Color matrix to pick from
C=[1,0,0; 0,1,0; 0,0,1; .929,.694,.125; 0,1,1; 1,0,1; 0,0,0; .85,.325,.098];
% [ red ; green; blue ; gold          ; cyan ; mag. ; black; brown        ]

for b=1:8
    semilogx(AreaR,Cfm(b,:),'color',C(b,:))
    hold on
end
hold off
xlim([1,1000])
ylim([0,2])
grid on
xlabel('Ae/At')
ylabel('Cf')
title('Thrust Coefficient vs. Area Ratio')
legend({'pa/po=0.1','0.05','0.03','0.01','0.005','0.003','0.001','0.0'},'Location','southwest')

