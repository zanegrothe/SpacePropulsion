% Zane Grothe
% AERO 6530
% HW 2
% 1/31/22

% Problem 3

clear all
close all
clc

gamm=[1.2,1.4,1.67];

pe=1; % bar ~~ASSUMPTION~~
p0=linspace(1,300); % bar

k=1;
while k<4
    gam=gamm(1,k);
    U=(2*(gam^2)/(gam-1));
    V=((2/(gam+1))^((gam+1)/(gam-1)));
    W=(1-((pe./p0).^((gam-1)/gam)));
    Cf=sqrt(U*V*W);
    if k==1
        Cfm=Cf;
    else
        Cfm=[Cfm;Cf];
    end
    k=k+1;
end

% Plot loop using Cfm rows on 1 plot
plot(p0,Cfm(1,:),'red')
hold on
plot(p0,Cfm(2,:),'green')
plot(p0,Cfm(3,:),'blue')
hold off
legend({'gamma(1.2)','gamma(1.4)','gamma(1.67)'},'Location','southeast')
xlim([1,300])
ylim([0,2])
xlabel('Chamber Pressure (bar)')
ylabel('Thrust Coefficient')
title('p0 vs. Cf')




