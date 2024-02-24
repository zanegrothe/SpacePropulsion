% Zane Grothe
% AERO 6530
% Test 1
% 3/21/22

clear all
close all
clc

% Problem 3 ~~~~~~~~~~~~~~~~~~~~

% Initial conditions (arbitrary)
p0i=800; % Chamber pressure (psia)
Fti=1000; % Thrust (lbf)
Ii=100; % Total impulse (lb-s)

% Rocket scale (pulled from slides)
L=(1:10);
p0=p0i*L./L;
Ft=L.^2;
I=L.^3;

% Plot (altogether)
y=[p0',Ft',I'];
plot(L,y)
xlabel('Length Scaled')
ylabel('Property Scaled')
title('Similitude in Solid Rockets')
legend({'Chamber Pressure','Normalized Thrust','Normalized Total Impulse'},'Location','west')

