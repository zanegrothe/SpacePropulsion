% Zane Grothe
% AERO 6530
% HW 5
% 4/22/22

clear all
close all
clc

% Problem 2/3 ~~~~~~~~~~~~~~~~~~~~

CfL_D=2.5;
Tt1_Ts=0.1;
x=linspace(0,100);
L=100;

Tt_Ts=(1/(1+sqrt(1+(pi/2/CfL_D)^2)))*(1+Tt1_Ts*sqrt(1+(pi/2/CfL_D)^2)...
    -(1-Tt1_Ts)*cos(pi*x/L));
Tw_Ts=(1/(1+sqrt(1+(pi/2/CfL_D)^2)))*(1+Tt1_Ts*sqrt(1+(pi/2/CfL_D)^2)...
    +(1-Tt1_Ts)*(pi/2/CfL_D*sin(pi*x/L)-cos(pi*x/L)));

figure(1)
plot(x/L,Tt_Ts,x/L,Tw_Ts)
xlim([0,1])
ylim([0,1])
axis square
xlabel('x/L')
ylabel('T/Ts')
title('x/L vs T/Ts')
legend({'Tt','Ts'},'Location','east')

CfL_D=linspace(0,5);

Tt2_Ts=(1./(1+sqrt(1+(pi./2./CfL_D).^2))).*(2+Tt1_Ts.*(sqrt(1+(pi./2./CfL_D).^2)-1));

figure(2)
plot(CfL_D,Tt2_Ts)
xlim([0,5])
ylim([0,1])
axis square
xlabel('fL/D')
ylabel('Tt/Ts')
title('fL/D vs Tt/Ts')

g=9.81;
gam=1.4;
Ru=8314;
MW=2;
TMax=2500;

IspMax=sqrt(2*gam*Ru*TMax/(gam-1)/MW)/g;
Isp=sqrt(2*gam*Ru*Tt2_Ts*TMax/(gam-1)/MW)/g;

figure(3)
plot(CfL_D,Isp/IspMax)
xlim([0,5])
ylim([0,1])
axis square
xlabel('fL/D')
ylabel('Isp/IspMax')
title('fL/D vs Isp/IspMax')

