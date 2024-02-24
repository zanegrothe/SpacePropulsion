% Zane Grothe
% AERO 6530
% HW 5
% 4/22/22

clear all
close all
clc

% Problem 1 ~~~~~~~~~~~~~~~~~~~~

TMax=2500;
g=9.81;
gam=1.4;
Ru=8314;
MW=2;

L=100;
x=linspace(0,L);
y=linspace(10,70);
z=linspace(11,100);
S=1-10./z;
Tt=S-.1;
Tw=.85;

figure(1)
plot(x/L,Tw,x/L,Tt)
xlim([0,1])
ylim([0,1])
xlabel('x/L')
ylabel('T/Ts')
title('x/L vs. T/Ts')

T=1-10./z;
Ts=1;

figure(2)
plot(5*x/L,T/Ts)
xlim([0,5])
ylim([0,1])
xlabel('fL/D')
ylabel('Tt/Ts')
title('fL/D vs. Tt/Ts')


IspMax=(1/g)*sqrt(2*gam*8314*TMax/(1.4-1)/2);
Tc=T*TMax;
Isp=(1/g)*sqrt(2*gam*8314*Tc/(1.4-1)/2);

figure(3)
plot(5*x/L,T/Ts)
xlim([0,5])
ylim([0,1])
xlabel('fL/D')
ylabel('Isp/IspMax')
title('fL/D vs. Isp/IspMax')




